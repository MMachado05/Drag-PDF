import 'package:desktop_drop/desktop_drop.dart';
import 'package:drag_pdf/common/localization/localization.dart';
import 'package:drag_pdf/components/components.dart';
import 'package:drag_pdf/model/enums/loader_of.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../helper/dialogs/custom_dialog.dart';
import '../helper/helpers.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();

  Future<void> loadFilesOrImages(LoaderOf from) async {
    setState(() {
      Loading.show();
    });
    try {
      switch (from) {
        case LoaderOf.imagesFromGallery:
          await viewModel.loadImagesFromStorage();
        case LoaderOf.filesFromFileSystem:
          await viewModel.loadFilesFromStorage();
      }
    } catch (error) {
      final subtitle =
          error.toString().contains(HomeViewModel.extensionForbidden)
              ? "forbidden_file_error_subtitle"
              : "read_file_error_subtitle";
      if (!mounted) return; // check "mounted" property
      CustomDialog.showError(
          context: context,
          error: error,
          titleLocalized: 'read_file_error_title',
          subtitleLocalized: subtitle,
          buttonTextLocalized: 'accept');
    } finally {
      setState(() {
        Loading.hide();
        Utils.printInDebug(viewModel.getMergeableFilesList());
      });
    }
  }

  Future<void> scanImages() async {
    try {
      context.pop('Scan');
      final file = await viewModel.scanDocument();
      if (file != null) {
        setState(() {
          Utils.printInDebug("Document Scanned: $file");
        });
      }
    } catch (error) {
      if (!mounted) return; // check "mounted" property
      CustomDialog.showError(
          context: context,
          error: error,
          titleLocalized: 'read_file_error_title',
          subtitleLocalized: 'scan_file_error_subtitle',
          buttonTextLocalized: 'accept');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Loading.isPresented
          ? const LoadingScreen()
          : Scaffold(
              appBar: AppBar(
                title: Text(Localization.of(context).string('drag_pdf')),
                actions: [
                  IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(Localization.of(context)
                            .string('choose_an_option')),
                        // Choose an option
                        content: Text(Localization.of(context)
                            .string('content_home_screen_dialog')),
                        // 'Do you want to load the file(s) from disk or from the document scanner?'
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                              FileDialog.add(
                                  context: context,
                                  loadImageFromGallery: () async =>
                                      await loadFilesOrImages(
                                          LoaderOf.imagesFromGallery),
                                  loadFileFromFileSystem: () async =>
                                      await loadFilesOrImages(
                                          LoaderOf.filesFromFileSystem));
                            },
                            child: Text(Localization.of(context)
                                .string('load')), // LOAD
                          ),
                          TextButton(
                            onPressed: () async => await scanImages(),
                            child: Text(Localization.of(context)
                                .string('scan')), // SCAN
                          ),
                          TextButton(
                            onPressed: () => context.pop('Cancel'),
                            child: Text(
                              Localization.of(context)
                                  .string('cancel'), // Cancel
                            ),
                          )
                        ],
                      ),
                    ),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              body: viewModel.thereAreFilesLoaded()
                  ? DropTarget(
                      onDragDone: (detail) {
                        setState(() {
                          viewModel.addFilesFromDragAndDrop(detail.files);
                        });
                      },
                      child: ReorderableListView.builder(
                        proxyDecorator: (child, index, animation) =>
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.blueAccent.withValues(alpha: 0.2),
                                    BlendMode.srcATop),
                                child: child),
                        itemCount:
                            viewModel.getMergeableFilesList().numberOfFiles(),
                        padding: const EdgeInsets.all(8),
                        onReorderStart: (int value) =>
                            HapticFeedback.mediumImpact(),
                        itemBuilder: (context, position) {
                          final file = viewModel
                              .getMergeableFilesList()
                              .getFile(position);
                          return Dismissible(
                            key: Key("${file.hashCode}"),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              viewModel.removeFileFromDisk(position);
                              setState(() {
                                // Then show a snackbar.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${Localization.of(context).string('removed_toast')} ${file.getName()}'),
                                  ),
                                );
                              });
                            },
                            background: Container(
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: FileRow(
                              file: file,
                              removeButtonPressed: () {
                                setState(() {
                                  viewModel.removeFileFromDiskByFile(file);
                                });
                              },
                              rotateButtonPressed: () async {
                                setState(() {
                                  Loading.show();
                                });
                                await viewModel
                                    .rotateImageInMemoryAndFile(file);
                                setState(() {
                                  Loading.hide();
                                });
                              },
                              resizeButtonPressed:
                                  (int width, int height) async {
                                setState(() {
                                  Loading.show();
                                });
                                await viewModel.resizeImageInMemoryAndFile(
                                    file, width, height);
                                setState(() {
                                  Loading.hide();
                                });
                              },
                              renameButtonPressed: (String name) async {
                                await viewModel.renameFile(file, name);
                                setState(() {
                                  Utils.printInDebug("Renamed File: $file");
                                });
                              },
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex = newIndex - 1;
                          }
                          setState(() {
                            final element =
                                viewModel.removeFileFromList(oldIndex);
                            viewModel.insertFileIntoList(newIndex, element);
                          });
                        },
                      ),
                    )
                  : DropTarget(
                      onDragDone: (detail) {
                        setState(() {
                          viewModel.addFilesFromDragAndDrop(detail.files);
                        });
                      },
                      child: Center(
                        child: Image.asset('assets/images/files/file.png'),
                      ),
                    ),
              floatingActionButton: Visibility(
                visible: viewModel.thereAreFilesLoaded(),
                child: FloatingActionButton(
                  onPressed: () async {
                    setState(() {
                      Loading.show();
                    });
                    try {
                      final file = await viewModel.generatePreviewPdfDocument();
                      setState(() {
                        Utils.openFileProperly(context, file);
                      });
                    } catch (error) {
                      if (!context.mounted) return; // check "mounted" property
                      CustomDialog.showError(
                        context: context,
                        error: error,
                        titleLocalized: 'generate_file_error_title',
                        subtitleLocalized: 'generate_file_error_subtitle',
                        buttonTextLocalized: 'accept',
                      );
                    } finally {
                      setState(() {
                        Loading.hide();
                      });
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
    );
  }
}

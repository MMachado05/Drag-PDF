import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:drag_pdf/helper/file_manager.dart';
import 'package:drag_pdf/helper/helpers.dart';
import 'package:drag_pdf/model/enums/supported_file_type.dart';
import 'package:drag_pdf/model/file_read.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class HomeViewModel {
  final FileManager _mfl = AppSession.singleton.mfl;

  final List<String> allowedExtensions =
      SupportedFileTypeExtension.namesOfSupportedExtension();

  String invalidFormat = "";
  static const String extensionForbidden = "Extension file forbidden: ";

  Future<void> loadFilesFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    _checkExtensionsFromPickFiles(result);
    _mfl.addMultiplePlatformFiles(
        result?.files ?? [], _mfl.fileHelper.localPath);
  }

  Future<void> addFilesFromDragAndDrop(List<DropItem> files) async {
    _checkExtensionsFromDropItem(files);
    final files2 = files.map((e) => File(e.path)).toList();
    _mfl.addMultipleFiles(files2, _mfl.fileHelper.localPath);
  }

  void _checkExtensionsFromDropItem(List<DropItem> files) {
    for (DropItem file in files) {
      final extension = p.extension(file.path);
      if (!SupportedFileTypeExtension.namesOfSupportedType()
          .contains(extension)) {
        print(
            "La extension $extension no es contenido en ${SupportedFileTypeExtension.namesOfSupportedType()}");
        invalidFormat = extension;
        throw Exception(extensionForbidden + invalidFormat);
      }
    }
  }

  void _checkExtensionsFromPickFiles(FilePickerResult? result) {
    if (result != null) {
      for (PlatformFile file in result.files) {
        final extension = file.extension?.toLowerCase();
        if (!allowedExtensions.contains(extension)) {
          invalidFormat = extension ?? "unknown";
          throw Exception(extensionForbidden + invalidFormat);
        }
      }
    }
  }

  Future<void> loadImagesFromStorage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    List<FileRead> files =
        await IsolateHelper.createAddMultiplesImagesIsolate(images);
    _mfl.addFilesInMemory(files);
  }

  FileManager getMergeableFilesList() => _mfl;

  bool thereAreFilesLoaded() => _mfl.hasAnyFile();

  FileRead removeFileFromDisk(int index) => _mfl.removeFileFromDisk(index);

  void removeFileFromDiskByFile(FileRead file) =>
      _mfl.removeFileFromDiskByFile(file);

  FileRead removeFileFromList(int index) => _mfl.removeFileFromList(index);

  void insertFileIntoList(int index, FileRead file) =>
      _mfl.insertFile(index, file);

  Future<void> rotateImageInMemoryAndFile(FileRead file) async {
    final rotateImage = await IsolateHelper.createRotateIsolate(file);
    file.setImage(rotateImage.getImage());
    await ImageHelper.updateCache(file);
  }

  Future<void> resizeImageInMemoryAndFile(
      FileRead file, int width, int height) async {
    final resizedFile =
        await IsolateHelper.createResizeIsolate(file, width, height);
    file.setImage(resizedFile.getImage());
    await ImageHelper.updateCache(file);
  }

  Future<void> renameFile(FileRead file, String newName) async {
    await _mfl.renameFile(file, newName);
  }

  Future<FileRead?> scanDocument() async {
    return await _mfl.scanDocument();
  }

  Future<FileRead> generatePreviewPdfDocument() async {
    final lp = AppSession.singleton.fileHelper.localPath;
    final pathFinal = '$lp${Utils.nameOfFinalFile}';
    AppSession.singleton.fileHelper.removeIfExist(pathFinal);
    return await _mfl.generatePreviewPdfDocument(
        pathFinal, Utils.nameOfFinalFile);
  }

  void restartApp() {
    AppSession.singleton.resetApp();
  }
}

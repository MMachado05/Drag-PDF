import 'package:drag_pdf/model/file_read.dart';
import 'package:get_it/get_it.dart';

// Singleton class for managing service registrations
class ServiceLocator {
  // Create a single instance of GetIt
  final GetIt getIt = GetIt.instance;

  // Private constructor to prevent external instantiation
  ServiceLocator._();

  // The single instance of ServiceLocator
  static final ServiceLocator _instance = ServiceLocator._();

  // Getter for the single instance
  static ServiceLocator get instance => _instance;

  // Function to register or update FileRead in GetIt
  void registerFile(FileRead file) {
    if (getIt.isRegistered<FileRead>()) {
      getIt.unregister<FileRead>();
    }
    getIt.registerLazySingleton<FileRead>(() => file);
  }
}

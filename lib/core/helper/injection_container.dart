import 'package:get_it/get_it.dart';
import 'package:test_ai/core/services/database_service.dart';
import 'package:test_ai/core/services/firebase_auth_services.dart';
import 'package:test_ai/core/services/firestore_service.dart';
import 'package:test_ai/features/auth/data/repos/auth_repo_impl.dart';
import 'package:test_ai/features/auth/domain/repos/auth_repo.dart';
import 'package:test_ai/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../features/chat/data/datasources/gemini_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> setupDI() async {
  // ==========================================
  // 1. Data Sources & Services
  // ==========================================
  sl.registerLazySingleton<GeminiRemoteDataSource>(
    () => GeminiRemoteDataSourceImpl(),
  );

  sl.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  sl.registerSingleton<DatabaseService>(FirestoreService());

  // ==========================================
  // 2. Repositories (LazySingleton / Singleton)
  // ==========================================
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      databaseService: sl(),
    ),
  );

  sl.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthServices: sl(), databaseService: sl()),
  );

  // ==========================================
  // 3. Use Cases (LazySingleton)
  // ==========================================
  sl.registerLazySingleton(() => SendMessageUseCase(repository: sl()));

  // ==========================================
  // 4. Features - BLoCs (Factory)
  // ==========================================
  sl.registerFactory(() => ChatBloc(
        sendMessageUseCase: sl(),
        chatRepository: sl(),
      ));
  sl.registerFactory(() => AuthBloc(authRepo: sl()));
}

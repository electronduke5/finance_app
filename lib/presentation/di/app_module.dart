import 'package:finance_app/data/repositories/asset_repository_impl.dart';
import 'package:finance_app/data/repositories/auth_repository_impl.dart';
import 'package:finance_app/data/repositories/profile_repository_impl.dart';
import 'package:finance_app/data/repositories/transaction_repo_impl.dart';
import 'package:finance_app/domain/repositories/asset_repository.dart';
import 'package:finance_app/domain/repositories/auth_repository.dart';
import 'package:finance_app/domain/repositories/category_repository.dart';
import 'package:finance_app/domain/repositories/transaction_category.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/category_repo_impl.dart';
import '../../data/repositories/prefs_respository_impl.dart';
import '../../domain/repositories/preferenses_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import 'token_holder.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;

    _provideTokenHolder();
    _provideAuthRepository();
    _providePreferencesRepository();
    _provideProfileRepository();
    _provideAssetRepository();
    _provideCategoryRepository();
    _provideTransactionRepository();

    _provided = true;
  }

  void _provideTokenHolder() {
    GetIt.instance.registerSingleton(TokenHolder());
  }

  static TokenHolder getTokenHolder() {
    return GetIt.instance.get<TokenHolder>();
  }

  void _provideAuthRepository() {
    GetIt.instance.registerSingleton(AuthRepositoryImpl());
  }

  static AuthRepository getAuthRepository() {
    return GetIt.instance.get<AuthRepositoryImpl>();
  }

  void _provideCategoryRepository() {
    GetIt.instance.registerSingleton(CategoryRepositoryImpl());
  }

  static CategoryRepository getCategoryRepository() {
    return GetIt.instance.get<CategoryRepositoryImpl>();
  }
  void _provideTransactionRepository() {
    GetIt.instance.registerSingleton(TransactionRepositoryImpl());
  }

  static TransactionRepository getTransactionRepository() {
    return GetIt.instance.get<TransactionRepositoryImpl>();
  }

  void _provideAssetRepository() {
    GetIt.instance.registerSingleton(AssetsRepositoryImpl());
  }

  static AssetsRepository getAssetRepository() {
    return GetIt.instance.get<AssetsRepositoryImpl>();
  }

  void _provideProfileRepository() {
    GetIt.instance.registerSingleton(ProfileRepositoryImpl());
  }

  static ProfileRepository getProfileRepository() {
    return GetIt.instance.get<ProfileRepositoryImpl>();
  }

  void _providePreferencesRepository() {
    final authRepository = getAuthRepository();
    GetIt.instance.registerSingleton(
      PreferencesRepositoryImpl(
        authRepository: authRepository,
      ),
    );
  }

  static PreferencesRepository getPreferencesRepository() {
    if (!_provided) throw Exception("Value not provided");
    return GetIt.instance.get<PreferencesRepositoryImpl>();
  }
}

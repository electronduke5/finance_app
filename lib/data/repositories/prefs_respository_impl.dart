import 'package:finance_app/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/preferenses_repository.dart';
import '../../presentation/di/app_module.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  AuthRepository authRepository;

  PreferencesRepositoryImpl({required this.authRepository});

  @override
  Future<void> saveApiToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_api_token', token);
  }

  @override
  Future<void> removeSavedApiToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_api_token');
  }

  @override
  Future<String?> restoreSavedApiToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedApiToken = prefs.getString('user_api_token');

    if (savedApiToken != null) {
      final token = await authRepository.refreshToken(savedApiToken);
      if (token.data == null) {
        await removeSavedApiToken();
        return null;
      }
      AppModule.getTokenHolder().apiToken = token.data!;
      await saveApiToken(token.data!);
      return token.data!;
    }
    return savedApiToken;
  }
}

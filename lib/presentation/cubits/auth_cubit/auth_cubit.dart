import 'package:bloc/bloc.dart';
import 'package:finance_app/presentation/cubits/models_status.dart';
import 'package:finance_app/presentation/di/app_module.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<String?> signUp() async {
    final repository = AppModule.getAuthRepository();
    emit(state.copyWith(apiStatus: LoadingStatus()));
    try {
      final token = await repository.signUp(
        state.userName,
        state.password,
        state.email,
      );
      if (token.hasError || token.data == null) {
        throw Exception(
          token.message ?? 'Ошибка на стороне сервера (auth_cubit)',
        );
      }
      AppModule.getTokenHolder().apiToken = token.data!;
      AppModule.getPreferencesRepository().saveApiToken(token.data!);

      emit(state.copyWith(apiStatus: LoadedStatus(token.data!)));
      return (null);
    } catch (exception) {
      emit(state.copyWith(apiStatus: FailedStatus(exception.toString())));
      return (exception.toString());
    }
  }

  Future<String?> signIn() async {
    final repository = AppModule.getAuthRepository();
    emit(state.copyWith(apiStatus: LoadingStatus()));
    try {
      print('userName: ${state.userName}');
      print('password: ${state.password}');
      final token = await repository.signIn(state.userName, state.password);
      if (token.hasError || token.data == null) {
        throw Exception(
          token.message ?? 'Ошибка на стороне сервера (auth_cubit)',
        );
      }
      AppModule.getTokenHolder().apiToken = token.data!;
      await AppModule.getPreferencesRepository().saveApiToken(token.data!);
      print('token: ${token.data!}');

      emit(state.copyWith(apiStatus: LoadedStatus(token.data!)));
      return (null);
    } catch (exception) {
      print(exception);

      emit(state.copyWith(apiStatus: FailedStatus(exception.toString())));
      return exception.toString();
    }
  }

  Future<void> userNameChanged(String value) async {
    emit(state.copyWith(userName: value));
  }

  Future<void> emailChanged(String value) async {
    emit(state.copyWith(email: value));
  }

  Future<void> passwordChanged(String value) async {
    emit(state.copyWith(password: value));
  }
}

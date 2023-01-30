import '../../data/utils/api_response.dart';

abstract class AuthRepository {
  Future<ApiResponse<String>> refreshToken(String currentToken);

  Future<ApiResponse<String>> signIn(
    String userName,
    String password,
  );

  Future<ApiResponse<String>> signUp(
      String userName,
      String password,
      String email,
      );
}

import 'package:finance_app/data/utils/api_response.dart';

import '../../data/model/user.dart';

abstract class ProfileRepository{
  Future<ApiResponse<User>> getProfile();
}
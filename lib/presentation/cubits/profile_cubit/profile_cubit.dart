import 'package:bloc/bloc.dart';
import 'package:finance_app/presentation/cubits/models_status.dart';
import 'package:finance_app/presentation/di/app_module.dart';
import 'package:meta/meta.dart';

import '../../../data/model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadProfile() async {
    final repository = AppModule.getProfileRepository();
    emit(state.copyWith(profileStatus: LoadingStatus()));
    try{
      final user = await repository.getProfile();
      emit(state.copyWith(profileStatus: LoadedStatus(user.data!)));
    }catch (exception){
      emit(state.copyWith(profileStatus: FailedStatus(exception.toString())));
    }
  }
}

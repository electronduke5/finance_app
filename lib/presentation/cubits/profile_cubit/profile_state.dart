part of 'profile_cubit.dart';

class ProfileState {
  final ApiStatus<User> profileStatus;

  ProfileState({
    this.profileStatus = const IdleStatus(),
  });

  ProfileState copyWith({ApiStatus<User>? profileStatus}) => ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
      );
}

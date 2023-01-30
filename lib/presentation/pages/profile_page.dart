import 'package:finance_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user.dart';
import '../cubits/models_status.dart';
import '../di/app_module.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.profileStatus.runtimeType) {
              case LoadedStatus<User>:
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Email: ${state.profileStatus.item!.email}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Имя пользователя: ${state.profileStatus.item!.userName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 100),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/assets");
                          },
                          child: const Text(
                            'Счета',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/categories");
                          },
                          child: const Text(
                            'Категории',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/transactions");
                          },
                          child: const Text(
                            'Транзакции',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            AppModule.getPreferencesRepository()
                                .removeSavedApiToken()
                                .then((value) {
                              Navigator.of(context)
                                  .pushReplacementNamed("/sign-in");
                            });
                          },
                          child: const Text(
                            'Выйти из профиля',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case FailedStatus<User>:
                return Center(
                  child: Text(
                    state.profileStatus.message ?? "Неизвестная ошибка",
                  ),
                );
              case IdleStatus<User>:
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<ProfileCubit>().loadProfile();
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}

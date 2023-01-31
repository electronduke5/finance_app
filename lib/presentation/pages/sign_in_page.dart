import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/models_status.dart';
import '../widgets/snack_bar.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.apiStatus is FailedStatus) {
                SnackBarInfo.show(
                  context: context,
                  message: state.apiStatus.message ?? 'Ошибка какая то блять',
                  isSuccess: false,
                );
              } else if (state.apiStatus is LoadedStatus) {
                SnackBarInfo.show(
                  context: context,
                  message: state.apiStatus.item.toString(),
                  isSuccess: true,
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                switch (state.apiStatus.runtimeType) {
                  case IdleStatus<String>:
                  case FailedStatus<String>:
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) => context
                                .read<AuthCubit>()
                                .userNameChanged(value),
                            decoration: const InputDecoration(
                              labelText: 'username',
                            ),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            onChanged: (value) => context
                                .read<AuthCubit>()
                                .passwordChanged(value),
                            decoration: const InputDecoration(
                              labelText: 'password',
                            ),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                          ),
                          const SizedBox(height: 40),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context2, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context2
                                      .read<AuthCubit>()
                                      .signIn()
                                      .then((error) {
                                    if (error == null) {
                                      Navigator.of(context).pushNamed('/profile');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: state.apiStatus is LoadedStatus
                                    ? const CircularProgressIndicator()
                                    : const Text('Войти'),
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/sign-up");
                            },
                            child: const Text(
                              'Ещё нет профиля?',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

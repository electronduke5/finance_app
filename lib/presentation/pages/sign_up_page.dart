import 'package:finance_app/presentation/cubits/models_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/snack_bar.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  static final _emailRegex = RegExp(
    r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+",
  );
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
                  isSuccess: false,
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
                          TextFormField(
                            onChanged: (value) =>
                                context.read<AuthCubit>().emailChanged(value),
                            decoration: const InputDecoration(
                              labelText: 'email',
                            ),
                            validator: (value) {
                              if (value?.trim().isEmpty != false) {
                                return "Это обязательное поле";
                              }
                              if (!_emailRegex.hasMatch(value!)) {
                                return "Некорректный email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<AuthCubit>().signUp();
                                  Navigator.of(context)
                                      .pushReplacementNamed('/profile');
                                },
                                child: state.apiStatus is LoadedStatus
                                    ? const CircularProgressIndicator()
                                    : const Text('Регистрация'),
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/sign-in");
                            },
                            child: const Text(
                              'Уже есть профиль?',
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

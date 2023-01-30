import 'package:finance_app/domain/repositories/preferenses_repository.dart';
import 'package:finance_app/presentation/cubits/asset_cubit/asset_cubit.dart';
import 'package:finance_app/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:finance_app/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:finance_app/presentation/cubits/transaction_cubit/transaction_cubit.dart';
import 'package:finance_app/presentation/di/app_module.dart';
import 'package:finance_app/presentation/pages/assets_page.dart';
import 'package:finance_app/presentation/pages/categories_page.dart';
import 'package:finance_app/presentation/pages/profile_page.dart';
import 'package:finance_app/presentation/pages/sign_in_page.dart';
import 'package:finance_app/presentation/pages/transaction_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/cubits/profile_cubit/profile_cubit.dart';
import 'presentation/pages/sign_up_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late PreferencesRepository _preferencesRepository;

  MyApp({super.key}) {
    _preferencesRepository = AppModule.getPreferencesRepository();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _preferencesRepository.restoreSavedApiToken(),
      builder: (context, token) {
        if (token.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: FlexThemeData.light(
            scheme: FlexScheme.bahamaBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 9,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
            // To use the playground font, add GoogleFonts package and uncomment
            // fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.bahamaBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 15,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
            // To use the Playground font, add GoogleFonts package and uncomment
            // fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
          routes: {
            '/sign-up': (context) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: SignUpPage(),
                ),
            '/sign-in': (context) => BlocProvider<AuthCubit>.value(
                  value: AuthCubit(),
                  child: SignInPage(),
                ),
            '/profile': (context) => BlocProvider<ProfileCubit>(
                  create: (context) => ProfileCubit()..loadProfile(),
                  child: ProfilePage(),
                ),
            '/assets': (context) => BlocProvider<AssetCubit>(
                  create: (context) => AssetCubit()..loadAssets(),
                  child: AssetsPage(),
                ),
            '/categories': (context) => BlocProvider<CategoryCubit>(
                  create: (context) => CategoryCubit()..loadCategories(),
                  child: CategoriesPage(),
                ),
            '/transactions': (context) => BlocProvider<TransactionCubit>(
                  create: (context) => TransactionCubit()..loadTransaction(),
                  child: TransactionPage(),
                ),
          },
          initialRoute: token.data == null ? '/sign-in' : '/profile',
        );
      },
    );
  }
}

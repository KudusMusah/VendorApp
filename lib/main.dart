import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/dependency_injection/dp_imports.dart';
import 'package:didi/src/core/routes/routes_imports.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:didi/src/core/theme/theme_config.dart';
import 'package:routemaster/routemaster.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (fn) {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AuthBloc>()),
            BlocProvider(create: (context) => sl<AppUserCubit>()),
          ],
          child: const MainApp(),
        ),
      );
    },
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // context.read<AuthBloc>().add(GetLoggedInUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  // if (state is AppUserLoggedIn) {
                  //   return loggedInRoutes;
                  // }
                  if (state is AppTestLoggedIn) {
                    return loggedInRoutes;
                  }
                  return loggedOutRoutes;
                },
              ),
              routeInformationParser: const RoutemasterParser(),
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeConfig().darkTheme,
              theme: ThemeConfig().lightTheme,
              themeMode: ThemeMode.dark,
            );
          },
        );
      },
    );
  }
}

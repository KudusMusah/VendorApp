part of "routes_imports.dart";

final loggedOutRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: OnboardingScreen()),
    '/signUp': (_) => const MaterialPage(child: SignUpScreen()),
    '/signIn': (_) => const MaterialPage(child: SignInScreen()),
    '/signIn/resetPasswordRequest': (_) =>
        const MaterialPage(child: ResetPasswordRequest()),
    '/signIn/resetPasswordRequest/otpVerification/:email': (info) =>
        MaterialPage(
          child: OtpScreen(
            email: info.pathParameters['email']!,
          ),
        ),
    '/signIn/resetPasswordRequest/passwordChange/:email/:resetCode': (info) =>
        MaterialPage(
          child: PasswordChangeScreen(
            email: info.pathParameters['email']!,
            resetCode: info.pathParameters['resetCode']!,
          ),
        ),
    '/signIn/passwordResetComplete': (_) =>
        const MaterialPage(child: PasswordResetComplete()),
  },
);

final loggedInRoutes = RouteMap(
  onUnknownRoute: (_) => const Redirect('/'),
  routes: {
    '/': (_) => const MaterialPage(child: TabBarPage()),
    '/details/:productId': (info) => MaterialPage(
          child: ProductDetails(
            productId: info.pathParameters['productId']!,
          ),
        ),
    '/updatePhone': (_) => const MaterialPage(child: UpdatePhone()),
  },
);

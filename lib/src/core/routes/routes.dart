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
    '/seller_dahboard': (_) => const MaterialPage(child: SellerDashboard()),
    '/seller_dahboard/create_screen': (_) =>
        const MaterialPage(child: PostScreen()),
    '/seller_dahboard/create_screen/product': (_) =>
        const MaterialPage(child: AddProductPage()),
    '/seller_dahboard/edit_product/:id': (info) => MaterialPage(
          child: EditProductPage(
            id: info.pathParameters['id']!,
          ),
        ),
    '/details/:id': (info) => MaterialPage(
          child: ProductDetails(
            id: info.pathParameters['id']!,
          ),
        ),
    '/updatePhone': (_) => const MaterialPage(child: UpdatePhone()),
  },
);

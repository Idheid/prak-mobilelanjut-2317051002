import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/signup_screen.dart';

void main() {
  testWidgets('Login Screen Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JustduitApp());

    // Verify that the LoginScreen is shown.
    expect(find.byType(LoginScreen), findsOneWidget);

    // Verify the title is present.
    expect(find.text('Hi, Welcome Back to Justduit'), findsOneWidget);

    // Verify the email and password fields are present.
    expect(find.bySemanticsLabel('Enter your email'), findsOneWidget);
    expect(find.bySemanticsLabel('Enter your password'), findsOneWidget);


    // Verify the Sign In button is present.
    expect(find.widgetWithText(GestureDetector, 'Sign In Now'), findsOneWidget);
  });

  testWidgets('Navigate to Signup Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JustduitApp());

    // Verify that we start on the LoginScreen.
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(SignupScreen), findsNothing);

    // Find and tap the "Create New Account" button.
    await tester.tap(find.text('Create New Account'));
    await tester.pumpAndSettle(); // pumpAndSettle to wait for navigation animation

    // Verify that we have navigated to the SignupScreen.
    expect(find.byType(SignupScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);

    // Verify the title on the SignupScreen is present.
    expect(find.text('Sign Up Now and Unlock the Power of Justduit'), findsOneWidget);
  });

   testWidgets('Navigate from Signup to Login Screen', (WidgetTester tester) async {
    // Build the app and navigate to the signup screen first.
    await tester.pumpWidget(const JustduitApp());
    await tester.tap(find.text('Create New Account'));
    await tester.pumpAndSettle();

    // Verify that we are on the SignupScreen.
    expect(find.byType(SignupScreen), findsOneWidget);

    // Find and tap the "Sign In" button on the signup screen.
    await tester.tap(find.widgetWithText(TextButton, 'Sign In'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that we have navigated back to the LoginScreen.
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(SignupScreen), findsNothing);
  });
}
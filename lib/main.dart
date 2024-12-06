import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:patest1/utils/theme_provider.dart';
import 'package:patest1/screens/auth/login.dart';
import 'package:patest1/screens/auth/register.dart';
import 'package:patest1/screens/forum/forum_screen.dart';
import 'package:patest1/screens/home/home.dart';
import 'package:patest1/utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hair Type Detection',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/forum': (context) => const ForumScreen(),
      },
    );
  }
}

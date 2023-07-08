import 'package:elibrary/constant/theme.dart';
import 'package:elibrary/providers/dashboard_provider.dart';
import 'package:elibrary/providers/homepage_provider.dart';
import 'package:elibrary/providers/student_provider.dart';
import 'package:elibrary/providers/book_provider.dart';
import 'package:elibrary/providers/transaction_provider.dart';
import 'package:elibrary/screens/login_screen.dart';
import 'package:elibrary/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomePageProvider(index: 0),
      ),
      ChangeNotifierProvider(
        create: (context) => StudentProvider(context: context),
      ),
      ChangeNotifierProvider(
        create: (context) => BookProvider(context: context),
      ),
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(context: context),
      ),
      ChangeNotifierProvider(
        create: (context) => DashboardProvider(context: context),
      )
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool validToken = false, loading = true;

  Future<void> checkAdmin() async {
    validToken = await AuthService().checkAdmin(context: context);
    Future.delayed(
        Duration(seconds: 5),
        () => {
              setState(() {
                loading = false;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            backgroundColor: const Color(0XFF1f6cc7),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Welcome To Pccoe Library',style: appTheme().textTheme.headlineLarge,),
                  ),
                  Image(
                    image: AssetImage('icons/library.gif'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Loading ......',style: appTheme().textTheme.headlineLarge),
                  )
                ],
              ),
            ),
          )
        : validToken
            ? HomePage()
            : LoginScreen();
  }
}

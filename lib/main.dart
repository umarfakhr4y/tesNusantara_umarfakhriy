part of 'pages/auth.dart';

void main() async {
  await GetStorage.init;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/', page: () => MyApp()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => Regispage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/addBook', page: () => addBookPage()),
        // GetPage(name: '/editBook', page: () => editBookPage()),
      ],
      home: const LoginPage(),
    );
  }
}

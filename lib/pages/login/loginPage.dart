part of '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  GetStorage storage = GetStorage();
  bool loading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> login() async {
    try {
      Map<String, dynamic> data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      var response = await _dio.post(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/login',
        data: data,
      );
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');
      setState(() {
        if (response.statusCode == 200) {
          // print(response.data['token']);
          storage.write('token', response.data['token']);
          print(storage.read('token'));
          Get.offAllNamed("/home");
          Get.snackbar(
            'Sukses',
            'Berhasil Login',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.white,
          );
        }
      });
    } catch (error) {
      Get.defaultDialog(
          title: "Gagal",
          middleText: "Silahkan cek kembali email dan password anda",
          textCancel: "Kembali",
          radius: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[100],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Log In',
                style: TextStyle(
                    fontSize: displayHeight(context) * 0.03,
                    fontWeight: FontWeight.bold),
              )),
              Padding(
                padding: EdgeInsets.all(displayHeight(context) * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.017),
                        autofocus: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Email Address",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            // border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tolong lengkapi Email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
                      TextFormField(
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.017),
                        controller: _passwordController,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Kata Sandi',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0)),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.amber[300]),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tolong lengkapi Kata Sandi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: displayHeight(context) * 0.03),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[300],
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          // backgroundColor: ConstantColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Dont have an account?',
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.018,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: displayHeight(context) * 0.008,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed("/register");
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: displayHeight(context) * 0.018,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

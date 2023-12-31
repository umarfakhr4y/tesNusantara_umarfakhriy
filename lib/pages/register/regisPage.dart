part of '../auth.dart';

class Regispage extends StatefulWidget {
  const Regispage({super.key});

  @override
  State<Regispage> createState() => _RegispageState();
}

class _RegispageState extends State<Regispage> {
  final Dio _dio = Dio();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _obscureText = true;

  Future<void> regis() async {
    try {
      Map<String, dynamic> data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _confirmpasswordController.text,
      };
      var response = await _dio.post(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/register',
        data: data,
      );
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');
      setState(() {
        if (response.statusCode == 200) {
          Get.defaultDialog(
              title: "Berhasil",
              middleText: "Berhasil mendaftarkan akun",
              textConfirm: "Login",
              barrierDismissible: false,
              onConfirm: () {
                Get.toNamed("/login");
              },
              radius: 20);
        }
      });
    } catch (error) {
      Get.defaultDialog(
          textCancel: "Kembali",
          title: "Gagal",
          middleText: "Silahkan coba lagi",
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
                'Register',
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
                        controller: _nameController,
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.017),
                        autofocus: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Name",
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
                            return 'Tolong lengkapi Nama';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
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
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
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
                      SizedBox(height: displayHeight(context) * 0.02),
                      TextFormField(
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.017),
                        controller: _confirmpasswordController,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Konfirmasi Kata Sandi',
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
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
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
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          // backgroundColor: ConstantColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          regis();
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.018,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: displayHeight(context) * 0.008,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed("/login");
                              },
                              child: Text(
                                'Login',
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

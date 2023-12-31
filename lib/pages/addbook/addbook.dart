part of '../auth.dart';

class addBookPage extends StatefulWidget {
  const addBookPage({super.key});

  @override
  State<addBookPage> createState() => _addBookstate();
}

class _addBookstate extends State<addBookPage> {
  final Dio _dio = Dio();
  GetStorage storage = GetStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _isbnController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<void> addBook() async {
    try {
      var headers = {
        'Authorization': "Bearer " + storage.read('token'),
      };

      Map<String, dynamic> data = {
        'isbn': _isbnController.text,
        'title': _titleController.text,
        'author': _authorController.text,
        'subtitle': _subtitleController.text,
      };
      var response = await _dio.post(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/add',
        data: data,
        options: Options(headers: headers),
      );
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');
      setState(() {
        if (response.statusCode == 200) {
          Get.offAllNamed('/home');
        }
      });
    } catch (error) {
      print(error);
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
      appBar: AppBar(
        title: Text("Tambah Buku"),
        backgroundColor: Colors.amber[200],
      ),
      backgroundColor: Colors.amber[100],
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(displayHeight(context) * 0.04),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: _titleController,
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                          autofocus: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Title",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                              return 'Tolong lengkapi TItle';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: displayHeight(context) * 0.02),
                        TextFormField(
                          controller: _isbnController,
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                          autofocus: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Isbn",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                          controller: _subtitleController,
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                          autofocus: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Subtitle",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                          controller: _authorController,
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.017),
                          autofocus: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Author",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            // backgroundColor: ConstantColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            addBook();
                          },
                          child: Text(
                            'Add book',
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.017),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

part of '../auth.dart';

class editBookPage extends StatefulWidget {
  final int idOper;
  const editBookPage({required this.idOper, super.key});

  @override
  State<editBookPage> createState() => _editBookstate();
}

class _editBookstate extends State<editBookPage> {
  final Dio _dio = Dio();
  GetStorage storage = GetStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _isbnController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();

  void initState() {
    super.initState();
    print(widget.idOper);
    getBook();
  }

  Future<void> getBook() async {
    try {
      var headers = {
        'Authorization': "Bearer " + storage.read('token'),
      };

      var response = await _dio.get(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/' +
            widget.idOper.toString(),
        options: Options(headers: headers),
      );
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');
      setState(() {
        if (response.statusCode == 200) {
          print("masuk 200");
          print(response.data['title']);
          setState(() {
            _titleController.text = response.data['title'];
            _isbnController.text = response.data['isbn'];
            _subtitleController.text = response.data['subtitle'];
            _authorController.text = response.data['author'];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> editBook() async {
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
      var response = await _dio.put(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/${widget.idOper}/edit',
        data: data,
        options: Options(headers: headers),
      );
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');
      setState(() {
        if (response.statusCode == 200) {
          Get.offAllNamed('/home');
          Get.snackbar(
            'Sukses',
            'Buku Berhasil di Edit',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.white,
          );
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
        title: Text("Edit Buku"),
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
                            backgroundColor: Colors.amber[300],
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            // backgroundColor: ConstantColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            editBook();
                          },
                          child: Text(
                            'Edit book',
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

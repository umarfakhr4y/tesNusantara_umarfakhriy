part of 'pages/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _Homestate();
}

class _Homestate extends State<HomePage> {
  final Dio _dio = Dio();
  GetStorage storage = GetStorage();
  List<dynamic> books = [];

  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      var headers = {
        'Authorization': "Bearer " + storage.read('token'),
      };
      var response = await _dio.get(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          books.clear();
          if (response.data is Map && response.data.containsKey('data')) {
            books.addAll(List.from(response.data['data']));
          } else {
            print('Invalid response format');
          }
        });
      } else {
        print('Failed to fetch books. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching books: $error');
    }
  }

  Future<void> logout() async {
    try {
      var headers = {
        'Authorization': "Bearer " + storage.read('token'),
      };
      var response = await _dio.delete(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user/logout',
        options: Options(headers: headers),
      );

      setState(() {
        if (response.statusCode == 200) {
          print("berhasil");
          Get.offAllNamed("/login");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteBooks(int $id) async {
    print($id);

    try {
      var headers = {
        'Authorization': "Bearer " + storage.read('token'),
      };
      var response = await _dio.delete(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/' +
            $id.toString(),
        options: Options(headers: headers),
      );

      setState(() {
        if (response.statusCode == 200) {
          print("berhasil");
          Get.offAllNamed("/home");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        actions: [
          Padding(
            padding: EdgeInsets.only(right: displayHeight(context) * 0.025),
            child: GestureDetector(
              onTap: () {
                logout();
              },
              child: Icon(
                Icons.logout,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: displayHeight(context) * 0.025),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/addBook');
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.amber[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        books[index]['title'] ?? 'No Title',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'ISBN: ${books[index]['isbn'] ?? 'No ISBN'}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              print('Edit button clicked for index $index');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteBooks(books[index]['id']);
                            },
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

part of '../auth.dart';

class detailBookPage extends StatefulWidget {
  final int idOper;
  const detailBookPage({required this.idOper, super.key});

  @override
  State<detailBookPage> createState() => _detailBookstate();
}

class _detailBookstate extends State<detailBookPage> {
  final Dio _dio = Dio();
  GetStorage storage = GetStorage();
  String title = "N/A";
  String isbn = "N/A";
  String author = "N/A";
  String subtitle = "N/A";

  void initState() {
    super.initState();
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
            title = response.data['title'];
            isbn = response.data['isbn'];
            author = response.data['author'];
            subtitle = response.data['subtitle'];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: Text('Detail Buku'),
      ),
      backgroundColor: Colors.amber[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Title'),
              subtitle: Text(title),
            ),
            ListTile(
              title: Text('ISBN'),
              subtitle: Text(isbn),
            ),
            ListTile(
              title: Text('Author'),
              subtitle: Text(author),
            ),
            ListTile(
              title: Text('Subtitle'),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}

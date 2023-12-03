
import 'dart:convert';
import 'package:brl_task4/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  List<Map<String, String>> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
   // String storedValue = await secureStorage.readSecureData(key);
    var headers = {
      // 'Authorization':
      //    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRXVjbGlkICIsImVtYWlsIjoiZ2F1cmF2MjIxMjAwMkBha2dlYy5hYy5pbiIsImlzTG9nZ2VkSW4iOiJZZXMiLCJpYXQiOjE3MDE1OTYxODJ9.IoU1uvEuoTWzoTheebjF-o9ErQ37_d4FflXcFhC74rc',
       'Content-Type': 'application/json',
      'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiRXVjbGlkICIsImVtYWlsIjoiZ2F1cmF2MjIxMjAwMkBha2dlYy5hYy5pbiIsImlzTG9nZ2VkSW4iOiJZZXMiLCJpYXQiOjE3MDE1OTYxODJ9.IoU1uvEuoTWzoTheebjF-o9ErQ37_d4FflXcFhC74rc'
    };

    var request = http.Request(
      'GET',
      Uri.parse(
          'http://ec2-3-7-70-25.ap-south-1.compute.amazonaws.com:8006/image/showImage/656b824c78c1e46e4951910c'),
    );
    request.headers.addAll(headers);

    try {
      http.Response response = await http.get(request.url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Map<String, String>> fetchedImages = List<Map<String, String>>.from(
          data.map(
            (item) => {
              'imgURL': item['imgURL'],
            },
          ),
        );

        setState(() {
          images = fetchedImages;
          isLoading = false;
        });
      } else {
        print('Failed to load images: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailScreen(
                          imageUrl: images[index]['imgURL']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Image.network(
                      images[index]['imgURL']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  ImageDetailScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

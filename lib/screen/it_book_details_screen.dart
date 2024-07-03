import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../api_service/it_book_api_service.dart';
import '../api_models/it_book_model.dart';

class BookDetailPage extends StatelessWidget {
  final String isbn13;
  final ApiService apiService = ApiService();

  BookDetailPage({required this.isbn13});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.purple,
        title: Text('Book Details', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<Book>(
        future: apiService.fetchBookDetail(isbn13),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerDetail();
          }
          Book book = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(book.image),
                SizedBox(height: 10),
                Text('Title : ${book.title}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Subtitle :  ${book.subtitle}', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                Text('Price: ${book.price}', style: TextStyle(fontSize: 18, color: Colors.green)),
                SizedBox(height: 20),
                Text('ISBN13 : ${book.isbn13}'),
                SizedBox(height: 10),
                Text('URL : ${book.url}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerDetail() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 30.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: 100.0,
              height: 20.0,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

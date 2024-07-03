import 'package:api/screen/api_list_screen.dart';
import 'package:api/screen/customer_api_Screen.dart';
import 'package:api/screen/it_book_screen.dart';
import 'package:api/api_models/photos_model.dart';
import 'package:api/screen/pixel_api_screen.dart';
import 'package:api/screen/post_screen.dart';
import 'package:api/screen/user_screen.dart';
import 'package:api/screen/userlist_post_screen.dart';
import 'package:api/screen/userlist_screen.dart';
import 'package:api/screen/weather_app_design_screen.dart';
import 'package:flutter/material.dart';
import '../api_service/photo_api_service.dart';
import 'package:shimmer/shimmer.dart';

class PhotoListPage extends StatefulWidget {
  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {

  late Future<List<Photo>> futurePhotos;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Photos Api ( json )',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            iconColor: Colors.white,
            offset: Offset(10, 40),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Customer Api'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomersScreen(),));
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 30),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ahmad Raja',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'ahmadraja@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title:  const Text('Pixels Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PexelApiPage(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('It Book Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPage(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Post Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostPage(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Users Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserScreen(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('UserList Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserListPage(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('UserList Post Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserListPostPage(),
                        ));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: const Text('Weather Api'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApiList_Page(),
                        ));
                  },
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: const Text('Weather App Design'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WeatherAppDesign(),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No photos found'));
          } else {
            List<Photo>? photos = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: photos!.length,
              itemBuilder: (context, index) {
                Photo photo = photos[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Icon(Icons.pending);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          photo.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

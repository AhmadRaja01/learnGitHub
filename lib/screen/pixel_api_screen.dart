import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../api_models/pixels_model.dart';
import '../api_service/pexels_api_service.dart';
import 'video_player_screen.dart';
import 'pixels_search_screen.dart';

class PexelApiPage extends StatefulWidget {
  const PexelApiPage({Key? key}) : super(key: key);

  @override
  State<PexelApiPage> createState() => _PexelApiPageState();
}

class _PexelApiPageState extends State<PexelApiPage> {

  final PexelsApiService _apiService = PexelsApiService();
  late Future<List<Video>> _videos;

  @override
  void initState() {
    super.initState();
    _videos = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    final Map<String, dynamic> data = await _apiService.getPopularVideos();
    final List<dynamic> videosJson = data['videos'];
    return videosJson.map((json) => Video.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PixelSearchPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.purple,
        title: const Text('Pexels Videos', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<Video>>(
        future: _videos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerEffect();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found'));
          } else {
            final videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return _buildVideoRow(context, video);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVideoRow(BuildContext context, Video video) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              video.creatorName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 180.0, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 15, // Repeat each video 15 times
              itemBuilder: (context, index) {
                return _buildVideoTile(context, video);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTile(BuildContext context, Video video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Container(
        width: 260.0, // Adjust width as needed
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                video.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 3, // Number of shimmer rows you want to show
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150,
                    height: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 180.0, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15, // Repeat the shimmer effect 15 times
                  itemBuilder: (context, index) {
                    return _buildShimmerTile();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerTile() {
    return Container(
      width: 260.0, // Adjust width as needed
      margin: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: Colors.grey,
            width: double.infinity,
            height: 180.0,
          ),
        ),
      ),
    );
  }
}


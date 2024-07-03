import 'package:flutter/material.dart';
import '../api_models/pixels_model.dart';
import '../api_service/pexels_api_service.dart';
import 'video_player_screen.dart';

class PixelSearchPage extends StatefulWidget {
  const PixelSearchPage({Key? key}) : super(key: key);

  @override
  _PixelSearchPageState createState() => _PixelSearchPageState();
}

class _PixelSearchPageState extends State<PixelSearchPage> {
  final PexelsApiService _apiService = PexelsApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Video> _videos = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Listen to changes in the search controller
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _videos = [];
          _error = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchVideos(String query) {
    if (query.isNotEmpty) {
      _fetchVideos(query: query);
    } else {
      setState(() {
        _videos = [];
        _error = null;
      });
    }
  }

  Future<void> _fetchVideos({required String query}) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final Map<String, dynamic> data = await _apiService.searchVideos(query);
      final List<dynamic> videosJson = data['videos'];
      setState(() {
        _videos = videosJson.map((json) => Video.fromJson(json)).toList();
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _videos = [];
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.purple,
        title: _buildSearchBar(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      child: TextField(
        controller: _searchController,
        onChanged: _searchVideos,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Search...',
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    if (_videos.isEmpty) {
      return const Center(child: Text('Please search..'));
    }

    return ListView.builder(
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        final video = _videos[index];
        return _buildVideoRow(video);
      },
    );
  }

  Widget _buildVideoRow(Video video) {
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
                return _buildVideoTile(video);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTile(Video video) {
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
}

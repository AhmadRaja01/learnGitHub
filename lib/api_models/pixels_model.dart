class Video {
  final int id;
  final int width;
  final int height;
  final String url;
  final String imageUrl;
  final String duration;
  final List<VideoFile> videoFiles;
  final String creatorName;

  Video({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.imageUrl,
    required this.duration,
    required this.videoFiles,
    required this.creatorName,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    var videoFilesJson = json['video_files'] as List;
    List<VideoFile> videoFilesList = videoFilesJson.map((file) => VideoFile.fromJson(file)).toList();

    return Video(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      imageUrl: json['image'],
      duration: json['duration'].toString(),
      videoFiles: videoFilesList,
      creatorName: json['user']['name'],
    );
  }
}

class VideoFile {
  final int id;
  final String quality;
  final String fileType;
  final String link;

  VideoFile({
    required this.id,
    required this.quality,
    required this.fileType,
    required this.link,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) {
    return VideoFile(
      id: json['id'],
      quality: json['quality'],
      fileType: json['file_type'],
      link: json['link'],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatefulWidget {
  String url;
  YoutubeVideo({
    super.key,
    required this.url,
  });

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  // the full url: https://www.youtube.com/watch?v=PQSagzssvUQ&ab_channel=NASA

  late YoutubePlayerController _controller;
  // YoutubePlayerController(
  //   initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
  //   flags: const YoutubePlayerFlags(
  //     autoPlay: true,
  //     mute: false,
  //   ),
  // );

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(
          autoPlay: true, mute: false, loop: true, forceHD: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      liveUIColor: Colors.amber,
    );
  }
}

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../utility/sizes.dart';
import '../../backend/models/trending_model.dart';

class PodcastPlayerPage extends StatefulWidget {
  final EpisodeData episode;
  final List<EpisodeData> playlist;

  const PodcastPlayerPage({
    super.key,
    required this.episode,
    this.playlist = const [],
  });

  @override
  State<PodcastPlayerPage> createState() => _PodcastPlayerPageState();
}

class _PodcastPlayerPageState extends State<PodcastPlayerPage> {
  late AudioPlayer _audioPlayer;
  late EpisodeData _currentEpisode;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  int _currentIndex = 0;

  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _currentEpisode = widget.episode;
    _audioPlayer = AudioPlayer();

    // Find the index of the current episode in the playlist
    if (widget.playlist.isNotEmpty) {
      _currentIndex = widget.playlist.indexWhere((e) => e.id == widget.episode.id);
      if (_currentIndex == -1) _currentIndex = 0;
    }

    _initAudio();
    _setupAudioListeners();
  }

  Future<void> _initAudio() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      if (_currentEpisode.contentUrl == null || _currentEpisode.contentUrl!.isEmpty) {
        throw 'No audio URL available';
      }

      await _audioPlayer.setUrl(_currentEpisode.contentUrl!);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to load audio: ${e.toString()}';
      });
    }
  }

  void _setupAudioListeners() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (mounted && duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  Future<void> _seekBackward() async {
    final newPosition = _position - Duration(seconds: 10);
    await _audioPlayer.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  Future<void> _seekForward() async {
    final newPosition = _position + Duration(seconds: 10);
    await _audioPlayer.seek(newPosition > _duration ? _duration : newPosition);
  }

  Future<void> _skipToPrevious() async {
    if (widget.playlist.isEmpty) return;

    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      // Load previous episode
      _loadEpisode(widget.playlist[_currentIndex]);
    }
  }

  Future<void> _skipToNext() async {
    if (widget.playlist.isEmpty) return;

    if (_currentIndex < widget.playlist.length - 1) {
      setState(() {
        _currentIndex++;
      });
      // Load next episode
      _loadEpisode(widget.playlist[_currentIndex]);
    }
  }

  Future<void> _loadEpisode(EpisodeData episode) async {
    await _audioPlayer.stop();
    setState(() {
      _currentEpisode = episode;
      _isLoading = true;
      _hasError = false;
      _position = Duration.zero;
      _duration = Duration.zero;
    });

    try {
      if (episode.contentUrl == null || episode.contentUrl!.isEmpty) {
        throw 'No audio URL available';
      }
      setState(() {
        _isLoading = false;
      });
      await _audioPlayer.setUrl(episode.contentUrl!);
      await _audioPlayer.play();

    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to load audio: ${e.toString()}';
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GrainOverlay(
      grainOpacity: 0.05, // Adjust for desired intensity
      updateInterval: 50,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF1E6F47), // Darker green (slightly above previous dark green)
                Color(0xFF1E6F47), // Keep darker green for more space
                Color(0xFF4A9B6E), // Lighter green
              ],
              stops: [0.0, 0.6, 1.0], // Darker green takes 60% of space
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top Bar with Back Button
                Padding(
                  padding: EdgeInsets.all(4.pW),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: EdgeInsets.all(2.pW),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 6.pW,
                      ),
                    ),
                  ),
                ),

                3.gap,

                // Album Artwork
                Container(
                  width: 80.pW,
                  height: 45.pH,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _currentEpisode.pictureUrl != null
                        ? Image.network(
                            _currentEpisode.pictureUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade800,
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 20.pW,
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade800,
                            child: Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 20.pW,
                            ),
                          ),
                  ),
                ),

                3.gap,

                // Episode Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.pW),
                  child: Text(
                    _currentEpisode.title ?? 'Unknown Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 5.pW,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                1.gap,

                // Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.pW),
                  child: Text(
                    _currentEpisode.description ?? '',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha:0.8),
                      fontSize: 3.5.pW,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Spacer(),

                // Progress Slider
                if (!_hasError)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.pW),
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white.withValues(alpha:0.3),
                            thumbColor: Colors.white,
                          ),
                          child: Slider(
                            value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble() > 0
                                ? _duration.inSeconds.toDouble()
                                : 1.0,
                            onChanged: (value) async {
                              await _audioPlayer.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.pW),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(_position),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha:0.8),
                                fontSize: 3.pW,
                              ),
                            ),
                            Text(
                              _formatDuration(_duration),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha:0.8),
                                fontSize: 3.pW,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                3.gap,

                // Player Controls
                if (_hasError)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.pW),
                    child: Column(
                      children: [
                        Text(
                          _errorMessage ?? 'Error loading audio',
                          style: TextStyle(color: Colors.red, fontSize: 4.pW),
                          textAlign: TextAlign.center,
                        ),
                        2.gap,
                        ElevatedButton(
                          onPressed: _initAudio,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.pW),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Skip to Previous
                        IconButton(
                          onPressed: widget.playlist.isNotEmpty && _currentIndex > 0
                              ? _skipToPrevious
                              : null,
                          icon: Opacity(
                            opacity: widget.playlist.isNotEmpty && _currentIndex > 0
                                ? 1.0
                                : 0.3,
                            child: Image.asset(
                              'assets/images/Group 1597.png',
                              width: 10.pW,
                              height: 10.pW,
                            ),
                          ),
                        ),
                        // 10 Seconds Back
                        IconButton(
                          onPressed: _seekBackward,
                          icon: Icon(
                            Icons.replay_10_rounded,
                            color: Colors.white,
                            size: 10.pW,
                          ),
                        ),
                        // Play/Pause Button
                        _isLoading
                            ? Container(
                                width: 15.pW,
                                height: 15.pW,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                 border: Border.all(
                                   color: Colors.white,
                                   width: 2
                                 )
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: _playPause,
                                child: Container(
                                  width: 15.pW,
                                  height: 15.pW,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white,
                                        width: 2
                                      )
                                  ),
                                  child: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 10.pW,
                                  ),
                                ),
                              ),
                        // 10 Seconds Forward
                        IconButton(
                          onPressed: _seekForward,
                          icon: Icon(
                            Icons.forward_10_rounded,
                            color: Colors.white,
                            size: 10.pW,
                          ),
                        ),
                        // Skip to Next
                        IconButton(
                          onPressed: widget.playlist.isNotEmpty &&
                                  _currentIndex < widget.playlist.length - 1
                              ? _skipToNext
                              : null,
                          icon: Opacity(
                            opacity: widget.playlist.isNotEmpty &&
                                    _currentIndex < widget.playlist.length - 1
                                ? 1.0
                                : 0.3,
                            child: Image.asset(
                              'assets/images/Group 1598.png',
                              width: 10.pW,
                              height: 10.pW,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                4.gap,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GrainOverlay extends StatefulWidget {
  final Widget child;
  final double grainOpacity;
  final int updateInterval;

  const GrainOverlay({
    Key? key,
    required this.child,
    this.grainOpacity = 0.015,
    this.updateInterval = 50,
  }) : super(key: key);

  @override
  State<GrainOverlay> createState() => _GrainOverlayState();
}

class _GrainOverlayState extends State<GrainOverlay> {
  late Timer _timer;
  int _seed = 0;
  ui.Image? _noiseImage;

  @override
  void initState() {
    super.initState();
    _createNoiseImage();
    _timer = Timer.periodic(
        Duration(milliseconds: widget.updateInterval),
            (_) {
              if (mounted) {
                setState(() => _seed = Random().nextInt(1000));
              }
            }
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _createNoiseImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();
    final size = const Size(256, 256);
    final random = Random();

    for (int y = 0; y < size.height; y++) {
      for (int x = 0; x < size.width; x++) {
        paint.color = Color.fromRGBO(
            255, 255, 255, random.nextDouble() * widget.grainOpacity
        );
        canvas.drawRect(
            Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
            paint
        );
      }
    }

    final picture = recorder.endRecording();
    _noiseImage = await picture.toImage(
        size.width.toInt(),
        size.height.toInt()
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_noiseImage == null) return widget.child;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return ImageShader(
                    _noiseImage!,
                    TileMode.repeated,
                    TileMode.repeated,
                    Matrix4.identity().storage,
                  );
                },
                blendMode: BlendMode.softLight,
                child: Container(
                  color: Colors.white.withValues(alpha:widget.grainOpacity),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
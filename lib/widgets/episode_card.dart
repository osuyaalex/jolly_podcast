import 'dart:ui';
import 'package:flutter/material.dart';
import '../utility/sizes.dart';
import '../backend/models/trending_model.dart';
import 'circular_action_button.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeData episode;
  final VoidCallback onTap;

  const EpisodeCard({
    super.key,
    required this.episode,
    required this.onTap,
  });

  String _cutUnwantedPart(String name) {
    if (name.length > 26) {
      return name.trim().replaceRange(26, null, '...');
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75.pW,
        margin: EdgeInsets.only(right: 4.pW),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Color(0xff023020).withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Episode Image with Gradient and Play Button
            Expanded(
              child: Stack(
                children: [
                  // Episode Image
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 31.pH,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18),
                            topLeft: Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            onError: (object, stackTrace) {
                              debugPrint('Image load failed: $object');
                            },
                            image: NetworkImage(episode.pictureUrl!),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.pH,
                        left: 30,
                        child: Center(
                          child: Container(
                            width: 15.pW,
                            height: 15.pW,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff20A726).withValues(alpha: 0.7),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 8.pW,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Episode Info at Bottom
                  Positioned(
                    bottom: 1,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(2.pW),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 1.0,
                                colors: [
                                  const Color(0xff023020).withValues(alpha: 0.2),
                                  const Color(0xff023020).withValues(alpha: 0.2),
                                  const Color(0xff023020).withValues(alpha: 0.2),
                                  const Color(0xff023020).withValues(alpha: 0.0),
                                ],
                                stops: const [0.0, 0.7, 0.9, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode.podcast!.author ?? "Unknown Author",
                                  style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  _cutUnwantedPart(episode.title ?? 'Unknown Episode'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3.9.pW,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 0.5.pH),
                                // Podcast Name
                                Text(
                                  episode.podcast?.description ?? 'Unknown Podcast',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 3.pW,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                1.gap,
                                // Action Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Like Button
                                    CircularActionButton(
                                      icon: Icons.favorite,
                                      onTap: () {
                                        // Handle like
                                      },
                                    ),
                                    1.gap,
                                    // Download Button
                                    CircularActionButton(
                                      icon: Icons.download_outlined,
                                      onTap: () {
                                        // Handle download
                                      },
                                    ),
                                    1.gap,
                                    // Share Button
                                    CircularActionButton(
                                      icon: Icons.share,
                                      onTap: () {
                                        // Handle share
                                      },
                                    ),
                                    1.gap,
                                    // More Options Button
                                    CircularActionButton(
                                      icon: Icons.add_circle,
                                      onTap: () {
                                        // Handle more options
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

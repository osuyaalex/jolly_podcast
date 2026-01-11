import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utility/sizes.dart';
import '../../utility/iacolors.dart';
import '../../utility/uiutils.dart';
import '../../backend/episodes_provider.dart';
import '../../widgets/episode_card.dart';
import '../login/login_screen_phone.dart';
import 'podcast_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch trending episodes on page load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchEpisodes();
    });

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchEpisodes({bool loadMore = false}) async {
    try {
      await context.read<EpisodesProvider>().fetchTrendingEpisodes(loadMore: loadMore);
    } catch (error) {
      // Handle authentication error
      if (error.toString().contains('Authentication failed')) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreenPhone()),
          );
        }
      } else {
        // Show error dialog for other errors
        if (mounted) {
          UiUtils.showAlertDialog(
            context: context,
            title: 'Error',
            content: error.toString(),
            defaultActionText: 'close', onDismissed: (bool p1) {  },
          );
        }
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchEpisodes(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar
            _buildTopBar(),

            2.gap,

            // Hot & Trending Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.pW),
              child: Row(
                children: [
                 Image.asset('assets/images/image 34.png'),
                  SizedBox(width: 2.pW),
                  Text(
                    'Hot & trending episodes',
                    style: TextStyle(
                      fontSize: 4.5.pW,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            2.gap,

            // Trending Episodes List
            Consumer<EpisodesProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: IAColors.secondary,
                    ),
                  );
                }

                if (provider.mainError != null && provider.trendingEpisodes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Failed to load episodes',
                          style: TextStyle(color: Colors.white),
                        ),
                        2.gap,
                        ElevatedButton(
                          onPressed: () {
                            _fetchEpisodes();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox(
                  height: 50.pH,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.pW),
                    itemCount: provider.trendingEpisodes.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.trendingEpisodes.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(4.pW),
                            child: CircularProgressIndicator(
                              color: Colors.pink,
                            ),
                          ),
                        );
                      }

                      final episode = provider.trendingEpisodes[index];
                      return EpisodeCard(
                        episode: episode,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PodcastPlayerPage(
                                episode: episode,
                                playlist: context.read<EpisodesProvider>().trendingEpisodes,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.pW, vertical: 2.pH),
      child: Row(
        children: [
          // Jolly Logo
          Image.asset(
            'assets/images/Screenshot__265__1-removebg-preview 1.png',
            height: 6.pH,
          ),
          Spacer(),
          // Profile Picture
         Container(
           padding: EdgeInsets.all(12),
           decoration: BoxDecoration(
             color: Color(0xff3E3E3E),
             borderRadius: BorderRadius.circular(16)
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               CircleAvatar(
                 radius: 4.pW,
                 backgroundColor: Colors.grey,
                 child: Image.asset('assets/images/ab6fa0a1c0ffe0efbfc6793eb6d069aa4399acea.png'),
               ),
               SizedBox(width: 3.pW),
               // Notification Bell
               Image.asset('assets/images/notification.png'),
               SizedBox(width: 3.pW),
               // Search Icon
               Image.asset('assets/images/Group 766.png')
             ],
           ),
         )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(const TiliTiliApp());

const brandPink = Color(0xFFFF2D8D);
const brandCyan = Color(0xFF00D9FF);
const brandPurple = Color(0xFF6D4AFF);

class TiliTiliApp extends StatelessWidget {
  const TiliTiliApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Tili Tili',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF090914),
          colorScheme: ColorScheme.fromSeed(seedColor: brandPink, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const MainShell(),
      );
}

class VideoPost {
  VideoPost({
    required this.id,
    required this.username,
    required this.caption,
    required this.tags,
    required this.videoUrl,
    required this.avatarColor,
    this.likes = 1200,
    this.comments = 126,
    this.isLiked = false,
    this.isFollowing = false,
  });

  final String id, username, caption, tags, videoUrl;
  final Color avatarColor;
  int likes, comments;
  bool isLiked, isFollowing;
}

final List<VideoPost> demoPosts = [
  VideoPost(
    id: '1', username: '@Tili_King', caption: 'Apni life, apne rules! 😎🔥',
    tags: '#TiliTili #Viral',
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    avatarColor: const Color(0xFF5925A8),
  ),
  VideoPost(
    id: '2', username: '@Dance_Star', caption: 'Dance karo, khush raho! 💃✨',
    tags: '#Dance #Trending',
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    avatarColor: const Color(0xFFB51F71),
  ),
  VideoPost(
    id: '3', username: '@Travel_Dost', caption: 'Duniya kitni khoobsurat hai! 🌄',
    tags: '#Travel #Explore',
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    avatarColor: const Color(0xFF087E8B),
  ),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ForYouFeed(posts: demoPosts),
      const SimplePage(icon: Icons.people_alt_outlined, title: 'Friends', subtitle: 'Discover creators and follow people you like.'),
      const CreatePage(),
      const SimplePage(icon: Icons.chat_bubble_outline, title: 'Inbox', subtitle: 'Your messages and notifications will appear here.'),
      const ProfilePage(),
    ];
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF101020),
        indicatorColor: brandPink.withValues(alpha: .18),
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'Friends'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.mail_outline), label: 'Inbox'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class ForYouFeed extends StatefulWidget {
  const ForYouFeed({super.key, required this.posts});
  final List<VideoPost> posts;
  @override
  State<ForYouFeed> createState() => _ForYouFeedState();
}

class _ForYouFeedState extends State<ForYouFeed> {
  late final PageController pageController;
  int currentIndex = 0;
  bool followingFeed = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.posts.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) => VideoCard(
              key: ValueKey(widget.posts[index].id),
              post: widget.posts[index],
              isActive: index == currentIndex,
              onChanged: () => setState(() {}),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => followingFeed = true),
                    child: Text('Following', style: TextStyle(
                      color: followingFeed ? Colors.white : Colors.white60,
                      fontSize: 16, fontWeight: followingFeed ? FontWeight.bold : FontWeight.normal,
                    )),
                  ),
                  const SizedBox(width: 22),
                  GestureDetector(
                    onTap: () => setState(() => followingFeed = false),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('For You', style: TextStyle(
                        color: !followingFeed ? Colors.white : Colors.white60,
                        fontSize: 17, fontWeight: !followingFeed ? FontWeight.bold : FontWeight.normal,
                      )),
                      const SizedBox(height: 5),
                      if (!followingFeed) Container(
                        height: 3, width: 38,
                        decoration: BoxDecoration(color: brandPink, borderRadius: BorderRadius.circular(9)),
                      ),
                    ]),
                  ),
                  const Spacer(),
                  const Icon(Icons.search, size: 26),
                ],
              ),
            ),
          ),
          if (followingFeed)
            Positioned(
              top: 100, left: 24, right: 24,
              child: IgnorePointer(child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                child: const Text('Following feed demo: followed creators are highlighted below.', textAlign: TextAlign.center),
              )),
            ),
        ],
      );
}

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.post, required this.isActive, required this.onChanged});
  final VideoPost post;
  final bool isActive;
  final VoidCallback onChanged;
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? controller;
  bool videoFailed = false, showControls = false, busy = true;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    final c = VideoPlayerController.networkUrl(Uri.parse(widget.post.videoUrl));
    controller = c;
    try {
      await c.initialize();
      await c.setLooping(true);
      if (!mounted) return;
      setState(() { busy = false; videoFailed = false; });
      if (widget.isActive) await c.play();
    } catch (_) {
      if (!mounted) return;
      setState(() { busy = false; videoFailed = true; });
    }
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final c = controller;
    if (c != null && c.value.isInitialized) {
      if (widget.isActive) { c.play(); } else { c.pause(); }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      widget.post.likes += widget.post.isLiked ? 1 : -1;
    });
    widget.onChanged();
  }

  void showComments() {
    final field = TextEditingController();
    final comments = <String>['Super video! 🔥', 'Bhai mast hai ❤️'];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF171727),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, MediaQuery.of(context).viewInsets.bottom + 18),
          child: SafeArea(child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Expanded(child: Text('Comments', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ]),
              const Divider(),
              ...comments.map((comment) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('@tili_user  $comment'),
              )),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: TextField(controller: field, decoration: const InputDecoration(
                  hintText: 'Add a comment...', border: OutlineInputBorder(),
                ))),
                IconButton(
                  onPressed: () {
                    final value = field.text.trim();
                    if (value.isEmpty) return;
                    setSheetState(() => comments.add(value));
                    setState(() => widget.post.comments++);
                    field.clear();
                  },
                  icon: const Icon(Icons.send, color: brandPink),
                ),
              ]),
            ],
          )),
        ),
      ),
    ).whenComplete(field.dispose);
  }

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return GestureDetector(
      onTap: () {
        if (c != null && c.value.isInitialized) {
          setState(() {
            if (c.value.isPlaying) { c.pause(); showControls = true; }
            else { c.play(); showControls = false; }
          });
        }
      },
      onDoubleTap: toggleLike,
      child: Stack(fit: StackFit.expand, children: [
        Container(color: widget.post.avatarColor),
        if (c != null && c.value.isInitialized)
          FittedBox(fit: BoxFit.cover, child: SizedBox(
            width: c.value.size.width, height: c.value.size.height, child: VideoPlayer(c),
          ))
        else
          _VideoFallback(color: widget.post.avatarColor, loading: busy, failed: videoFailed),
        Container(decoration: const BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.black45, Colors.transparent, Colors.black87], stops: [0, .35, 1],
        ))),
        if (showControls) const Center(child: Icon(Icons.play_arrow_rounded, size: 84, color: Colors.white)),
        Positioned(
          left: 16, right: 78, bottom: 22,
          child: SafeArea(top: false, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                CircleAvatar(backgroundColor: widget.post.avatarColor, child: const Icon(Icons.person, color: Colors.white)),
                const SizedBox(width: 9),
                Expanded(child: Text(widget.post.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                if (!widget.post.isFollowing)
                  OutlinedButton(
                    onPressed: () { setState(() => widget.post.isFollowing = true); widget.onChanged(); },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white, side: const BorderSide(color: brandPink),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Follow'),
                  )
                else const Icon(Icons.verified, color: brandCyan, size: 20),
              ]),
              const SizedBox(height: 12),
              Text(widget.post.caption, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 5),
              Text(widget.post.tags, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 10),
              const Row(children: [
                Icon(Icons.music_note, size: 16), SizedBox(width: 5),
                Expanded(child: Text('Original sound · Tili Tili', maxLines: 1)),
              ]),
            ],
          )),
        ),
        Positioned(
          right: 12, bottom: 28,
          child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
            _ActionButton(icon: widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.post.isLiked ? brandPink : Colors.white, label: formatCount(widget.post.likes), onTap: toggleLike),
            const SizedBox(height: 22),
            _ActionButton(icon: Icons.mode_comment_outlined, label: formatCount(widget.post.comments), onTap: showComments),
            const SizedBox(height: 22),
            _ActionButton(icon: Icons.share_outlined, label: 'Share',
              onTap: () => Share.share('Check out ${widget.post.username} on Tili Tili! ${widget.post.tags}')),
            const SizedBox(height: 22),
            _ActionButton(icon: Icons.album_outlined, label: 'Sound',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sound page can be connected next.')))),
          ])),
        ),
      ]),
    );
  }

  String formatCount(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return '$value';
  }
}

class _VideoFallback extends StatelessWidget {
  const _VideoFallback({required this.color, required this.loading, required this.failed});
  final Color color;
  final bool loading, failed;

  @override
  Widget build(BuildContext context) => Container(
    color: color, alignment: Alignment.center,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(failed ? Icons.video_library_outlined : Icons.movie_creation_outlined, size: 74, color: Colors.white),
      const SizedBox(height: 12),
      Text(loading ? 'Loading video…' : 'Tili Tili', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      if (failed) const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Video could not load. Check internet connection or replace the demo URL.', textAlign: TextAlign.center),
      ),
    ]),
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.color = Colors.white});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap, borderRadius: BorderRadius.circular(40),
    child: SizedBox(width: 55, child: Column(children: [
      Icon(icon, size: 33, color: color),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ])),
  );
}

class SimplePage extends StatelessWidget {
  const SimplePage({super.key, required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(28),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 76, color: brandPink),
      const SizedBox(height: 18),
      Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
    ]),
  ));
}

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(28),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.video_call_outlined, size: 80, color: brandPink),
      const SizedBox(height: 18),
      const Text('Create on Tili Tili', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Camera recording and gallery upload are the next integration step.', textAlign: TextAlign.center),
      const SizedBox(height: 18),
      FilledButton.icon(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connect camera/gallery plugin to enable creation.'))),
        icon: const Icon(Icons.add), label: const Text('Create video'),
      ),
    ]),
  ));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Align(alignment: Alignment.centerRight, child: Icon(Icons.settings_outlined)),
      const SizedBox(height: 12),
      const CircleAvatar(radius: 48, backgroundColor: brandPurple, child: Icon(Icons.person, size: 54)),
      const SizedBox(height: 12),
      const Text('@tili_user', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('Dream Big ✨  Create More 🎬  Be Happy 😊', textAlign: TextAlign.center),
      const SizedBox(height: 22),
      const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _Stat(label: 'Following', value: '128'),
        _Stat(label: 'Followers', value: '1.2K'),
        _Stat(label: 'Likes', value: '8.7K'),
      ]),
      const SizedBox(height: 24),
      OutlinedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit profile will be connected to user storage.'))),
        child: const Text('Edit profile'),
      ),
      const SizedBox(height: 18),
      const Text('Your videos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      GridView.count(
        crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 5, mainAxisSpacing: 5,
        children: List.generate(6, (index) => Container(
          color: [brandPurple, brandPink, brandCyan, Colors.deepOrange, Colors.indigo, Colors.teal][index],
          child: const Icon(Icons.play_arrow, size: 32),
        )),
      ),
    ],
  ));
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
    const SizedBox(height: 4),
    Text(label, style: const TextStyle(color: Colors.white70)),
  ]);
}

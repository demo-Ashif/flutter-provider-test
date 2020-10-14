import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/gesture.dart';
import 'onboarding.dart';

const pages = [
  PageViewModel(
    "assets/images/tuto_image_1.jpg",
    "Game",
    """
    Easily organise a game within your group and review information on; game mode, time, cost and location.
    """,
  ),
  PageViewModel(
    "assets/images/tuto_image_2.jpg",
    "Line-Up",
    'Keep an eye on whose "IN" the squad for the game.',
  ),
  PageViewModel(
    "assets/images/tuto_image_3.jpg",
    "Teams",
    "Sort teams and formations on a dynamic formation sheet",
  ),
  PageViewModel(
    "assets/images/tuto_image_4.jpg",
    "Stats",
    "View group stats on a leader board and access match reports of all previous games within your groups.",
  ),
  PageViewModel("assets/images/tuto_image_5.jpg", "Chat",
      "In-built personal direct messenger as well as group chat to continue the banter"),
];

class PageViewModel {
  final String imageAsset;
  final String title;
  final String body;

  const PageViewModel(this.imageAsset, this.title, this.body);
}

class PageViewSlider extends StatelessWidget {
  final PageController pageController;

  const PageViewSlider({Key key, @required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (i) => OnBoardingInherited.of(context).bloc.update(i),
      itemBuilder: (context, index) => Page(viewModel: pages[index]),
      itemCount: pages.length,
    );
  }
}

class Page extends StatefulWidget {
  final PageViewModel viewModel;

  const Page({Key key, this.viewModel}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _translateTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    final Animation curve =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _translateTween = Tween<double>(begin: 100, end: 0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    // Play the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _value = _translateTween.value;
    return Container(
      color: Colors.transparent,
      child: StreamBuilder<Swipe>(
        stream: OnBoardingInherited.of(context).bloc.eventStream,
        builder: (context, snapshot) {
          // var direction = 1.0;

          // if (snapshot.data == Swipe.Right) {
          //   direction = -1.0;
          // }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: (1.0 - (_value / 100.0)),
                child: Transform(
                  transform: Matrix4.translationValues(0.0, _value, 0.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFF121212),
                    child: FadeInImage(
                      image: AssetImage(widget.viewModel.imageAsset),
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 100),
                      fadeOutDuration: const Duration(milliseconds: 100),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

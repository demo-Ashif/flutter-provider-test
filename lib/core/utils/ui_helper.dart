import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:transparent_image/transparent_image.dart';

const messiImage = "assets/images/messi.jpg";

class UIHelper {
  static Widget avatar({
    String url,
    double size = 96,
  }) {
    final _fadeDuration = Duration(milliseconds: 275);
    final _border = Border.all(
      color: Colors.white.withOpacity(0.8),
      width: 2.4,
    );
    if (url == null || url.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            border: _border,
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.5)),
        child: ClipOval(
          child: FadeInImage(
            height: size,
            width: size,
            fadeInDuration: _fadeDuration,
            fadeOutDuration: _fadeDuration,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(messiImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          border: _border,
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.8)),
      child: ClipOval(
        child: FadeInImage.memoryNetwork(
          fadeInDuration: _fadeDuration,
          fadeOutDuration: _fadeDuration,
          placeholder: kTransparentImage,
          image: buildAvatarUrl(url),
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
      ),
    );
  }

  static Widget avatarImage(
    String avatar, {
    String assetImage,
    double width = 96,
    double height = 96,
    BoxBorder border,
  }) {
    if (avatar == null || avatar == "") {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(messiImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(buildAvatarUrl(avatar)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static String buildAvatarUrl(String avatar) => avatar;

  //AVATAR_THUMBNAIL_BASE_URL + avatar;

  static double computeMaxCardHeight(BuildContext context) {
    final double threshold = 700;
    final viewPortHeight = MediaQuery.of(context).size.height;
    if (viewPortHeight >= threshold) {
      return viewPortHeight * 0.85;
    } else {
      return viewPortHeight * 0.90;
    }
  }

  static AppBar createAppBar(BuildContext context,
      {Widget backButton, Widget actionButton}) {
    return AppBar(
      title: Image.asset(
        'images/footsapp-logo-light.png',
        width: MediaQuery.of(context).size.width * 0.42,
        fit: BoxFit.fitHeight,
      ),
      centerTitle: true,
      backgroundColor: FOOTSAPP_THEME_NAVY,
      automaticallyImplyLeading: false,
      leading: backButton ?? _buildBackButton(context),
      actions: [
        if (actionButton != null) actionButton,
      ],
    );
  }

  static Widget _buildBackButton(BuildContext context,
      {void Function() onPressed}) {
    return IconButton(
      onPressed: () {
//        var bloc = BlocProvider.of<GroupBloc>(context);
//        bloc.dispatch(OnInitLoad());
//        bloc.dispatch(GroupsLoadedEvent());

        Navigator.of(context).pop();
      },
      icon: Icon(
        //TODO: change icon?
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  static TextStyle defaultStyleWithProperties(
      {double size = 15,
      Color color = Colors.white,
      double opacity = 1,
      String fontFamily = "ProximaNova",
      FontWeight fontWeight = FontWeight.normal,
      TextAlign align = TextAlign.left}) {
    return TextStyle(
      color: color.withOpacity(opacity),
      fontSize: size,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }

  static Widget buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 7.0, bottom: 0.0),
      color: Colors.transparent,
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: "Montserrat",
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}

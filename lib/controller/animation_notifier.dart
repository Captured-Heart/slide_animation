import 'package:flutter/material.dart';
import 'package:slide_animation/extensions.dart';
import 'package:slide_animation/model/car_model.dart';

class AnimationNotifier extends ChangeNotifier {
  AnimationNotifier() {
    stackedCardList.addAll(cardList);
    stackedCardList.removeAt(0);
  }
  List<CarModel> stackedCardList = [];
  final PageController _pageController = PageController();
  int pageIndex = 0;
  bool onTapToOpen = false;
  double? scale = 1.0;
  bool showStacked = false;
  double overScroll = 0.0;

  PageController get pageController => _pageController;
  double get height => onTapToOpen ? 0.98 : 0.5;
  double get stackedHeight => _stackedHeight();
  List<CarModel> get cardList => carModelList;

  @override
  String toString() {
    return 'pageIndex: $pageIndex, onTapOpen: $onTapToOpen, scale: $scale, showStacked: $showStacked, overScroll: $overScroll';
  }

  double _stackedHeight() {
    if (showStacked && !overScroll.isNegative) {
      return 0.05;
    } else if (showStacked && overScroll.isNegative) {
      //change this 0.0 to 0.1
      return (0.0 + ((overScroll - 0.2333) / -10));
    } else if (!onTapToOpen) {
      return 0.8;
    } else {
      return 0.8;
    }
  }

// on page view changed
  void onPageViewChanged(int index) {
    if (index == cardList.length - 1) {
      showStacked = true;
    } else {
      showStacked = false;
      scale = 1.0;
      overScroll = 14.0;
    }
    pageIndex = index;
    notifyListeners();
  }

// When i tap the first card
  void onTapFirstCard() {
    onTapToOpen = !onTapToOpen;
    showStacked = false;
    notifyListeners();

    toString().defaultLog();
  }

  // on pinch cards
  void onPinchCards(double scaleDetails) {
    if (onTapToOpen) {
      'this is the focal point: $scaleDetails'.defaultLog();
      if (scaleDetails > 1.15 || scaleDetails < 0.9) {
        showStacked = true;
        scale = scaleDetails;
        overScroll = 0.0;
        pageController.jumpToPage(0);
        notifyListeners();
      }
    }
  }

  // SHOW THE STACKED CARDS
  void showStackedCards() {
    showStacked = true;
    notifyListeners();
  }

  void onTapOtherStackedCards(int cardIndex) {
    showStacked = false;
    onTapToOpen = true;
    pageController.jumpToPage(cardIndex + 1);
    notifyListeners();
  }



// listen to scroll notifier
  void listenToScrollNotifier(Object? notification) {
    if (notification is OverscrollNotification) {
      if (notification.overscroll > -4.0) {
        overScroll = notification.overscroll;
        notifyListeners();
      }
    }
  }
}

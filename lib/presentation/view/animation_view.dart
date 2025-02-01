import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:slide_animation/controller/animation_notifier.dart';
import 'package:slide_animation/extensions.dart';
import 'package:slide_animation/presentation/widget/vehicle_animated_widget.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class AnimationView extends StatelessWidget {
  AnimationView({super.key});
  final AnimationNotifier _animationNotifier = AnimationNotifier();

  @override
  Widget build(BuildContext context) {
    // _animationNotifier.toString().defaultLog();
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: ListenableBuilder(
          listenable: _animationNotifier,
          builder: (context, _) {
            var state = _animationNotifier;
            // var height = state.onTapToOpen ? 0.98 : 0.5;
            "'state:'  ${state.toString()}".defaultLog();
            return SafeArea(
              bottom: false,
              top: !state.onTapToOpen,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedPositioned(
                    duration: 700.ms,
                    bottom: context.deviceHeight(state.onTapToOpen ? 0 : 0.2),
                    left: 0,
                    right: 0,
                    child: AnimatedContainer(
                      duration: 800.ms,
                      curve: Curves.linear,
                      height: context.deviceHeight(state.height),
                      child: PageView(
                        controller: state.pageController,
                        pageSnapping: true,
                        physics: state.onTapToOpen ? null : const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          state.onPageViewChanged(value);
                        },
                        scrollDirection: Axis.vertical,
                        children: List.generate(
                          state.cardList.length,
                          (index) {
                            var carDetails = state.cardList[index];

                            return SizedBox(
                              height: context.deviceHeight(1),
                              width: context.deviceWidth(1),
                              child: VehicleAnimatedWidget(
                                carModel: carDetails,
                                onTap: () {
                                  state.onTapFirstCard();
                                },
                                onScaleUpdate: (details) {
                                  state.onPinchCards(details.scale);
                                },
                                onPinch: () {
                                  state.showStackedCards();
                                },
                                showFAB: state.onTapToOpen ? true : false,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // STACKED CARD LIST
                  AnimatedPositioned(
                    duration: 400.ms,
                    bottom: -context.deviceHeight(state.stackedHeight),
                    left: 0,
                    right: 0,
                    child: NotificationListener(
                      onNotification: (notification) {
                        state.listenToScrollNotifier(notification);
                        return false;
                      },
                      child: SizedBox(
                        height: context.deviceHeight(0.8),
                        child: StackedCardCarousel(
                          type: StackedCardCarouselType.cardsStack,
                          initialOffset: 20,
                          spaceBetweenItems: context.deviceHeight(0.2),
                          applyTextScaleFactor: false,
                          onPageChanged: (pageIndex) {
                            'this is $pageIndex'.defaultLog();
                          },
                          items: List.generate(
                            state.stackedCardList.length,
                            (index) {
                              var carModel = state.stackedCardList[index];

                              return SizedBox(
                                height: context.deviceHeight(1),
                                width: context.deviceWidth(1),
                                child: VehicleAnimatedWidget(
                                  carModel: carModel,
                                  onTap: () {
                                    state.onTapOtherStackedCards(index);
                                  },
                                  onPinch: () {},
                                  onScaleUpdate: (details) {},
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!state.onTapToOpen)
                    Positioned(
                      top: 10,
                      left: 10,
                      width: context.deviceWidth(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                style: context.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      "Welcome to J.J Vehicles",
                                      textStyle: context.textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      colors: [
                                        Colors.green,
                                        Colors.blue,
                                        Colors.yellow,
                                        Colors.red,
                                      ],
                                    ),
                                    // TyperAnimatedText(
                                    //   "Welcome to J.J Vehicles",
                                    //   textStyle: context.textTheme.titleLarge!.copyWith(
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Colors.blue[600],
                                    //   ),
                                    // ),
                                  ],
                                  onTap: () {},
                                ),
                              ).fadeInFromTop(delay: 1000.ms, animationDuration: 600.ms),
                              //
                              Text(
                                'See affordable vintage cars',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ).fadeInFromLeft(delay: 1800.ms),
                            ],
                          ),
                          Text(
                            '- We offer only the best, be rest assured, you wouldn not be offered a hamburger instead of a Benz! ',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ).fadeInFromLeft(delay: 2500.ms),
                        ].paddingInColumn(10),
                      ).padOnly(right: 10),
                    ),
                ],
              ).padSymmetric(horizontal: 0, vertical: 5),
            );
          }),
    );
  }
}

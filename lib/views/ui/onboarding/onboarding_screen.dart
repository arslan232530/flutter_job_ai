import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/onboarding/onboarding_provider.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/onboarding/widgets/page_one.dart';
import 'package:job_board/views/ui/onboarding/widgets/page_three.dart';
import 'package:job_board/views/ui/onboarding/widgets/page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: onboardingState.isLastPage
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            onPageChanged: (page) {
              ref.read(onboardingProvider.notifier).onPageChanged(page);
            },
            children: const [PageOne(), PageTwo(), PageThree()],
          ),
          Positioned(
            bottom: height * 0.10,
            left: width * 0,
            right: 0,
            child: onboardingState.isLastPage
                ? const SizedBox.shrink()
                : Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 10,
                        dotColor: kDarkGrey,
                        activeDotColor: kLight,
                      ),
                    ),
                  ),
          ),
          Positioned(
            child: onboardingState.isLastPage
                ? const SizedBox.shrink()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 30.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pageController.jumpToPage(2);
                            },
                            child: ReusableText(
                              text: 'Skip',
                              style: appstyle(16, kLight, FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: ReusableText(
                              text: 'Next',
                              style: appstyle(16, kLight, FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

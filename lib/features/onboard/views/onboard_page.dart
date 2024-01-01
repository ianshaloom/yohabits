import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants.dart';
import '../../../hive/models/onboard/onboard.dart';
import '../../../hive/repo/habit_repo.dart';
import '../../../hive/repo/onboard_repo.dart';
import '../../../hive/repo/userprofile_repo.dart';
import '../widgets/page.three.dart';
import '../widgets/page_one.dart';
import '../widgets/page_two.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final UserProfileRepo _userProfileRepo = UserProfileRepo();
  final OnboardRepo _onboardRepo = OnboardRepo();
  final HabitRepo _habitRepo = HabitRepo();

  final PageController _controller = PageController();
  bool isLastIndex = false;

  @override
  void initState() {
    _userProfileRepo.getUserProfileBool().then((value) {
      if (value) {
        _userProfileRepo.addDefaultUserProfile();
        _habitRepo.addDefaultHabits(defaultHabits);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() => isLastIndex = value == 2);
          },
          children: const [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
      ),
      bottomSheet: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.20,
          maxHeight: size.height * 0.20,
          minWidth: size.width,
        ),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 30),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLastIndex
                  ? FilledButton(
                      onPressed: () async {
                        await onboardDone();
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                      ),
                    )
                  : FilledButton(
                      onPressed: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        'Next',
                      ),
                    ),
              const Expanded(
                child: SizedBox(
                  height: 40,
                ),
              ),
              Expanded(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    radius: 10,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 20,
                    dotColor: Theme.of(context).colorScheme.inversePrimary,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onboardDone() async {
    final Onboard onboard = await _onboardRepo.getOnboardObject();
    onboard.showOnboard = false;
    await onboard.save();
  }
}

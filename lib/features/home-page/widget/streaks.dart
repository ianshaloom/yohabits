import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class StreaksCard extends StatelessWidget {
  const StreaksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    NumberFormat numberFormat = NumberFormat("00");
    double radius = 45;

    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 210,
            width: screenSize.width,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 25, left: 8),
                      child: Text(
                        'Todays Habit Streaks',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Date Added: ${DateFormat.yMMMd().format(DateTime.now())}',
                      style: const TextStyle(
                        color: Color(0xff939191),
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: radius,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset(
                                currentStreakImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    numberFormat.format(00),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Current Streak',
                            style: TextStyle(
                              letterSpacing: 1.5,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: radius,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset(
                                longestStreakImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    numberFormat.format(00),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Longest Streak',
                            style: TextStyle(
                              letterSpacing: 1.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => StockTakePage(),
                  //   ),
                  // );
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size.fromHeight(60),
                  // textStyle: Theme.of(context)
                  //     .textTheme
                  //     .labelLarge!
                  //     .copyWith(
                  //       fontSize: 17,
                  //     ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Open Streaks',
                    ),
                    SizedBox(width: 40),
                    Icon(Icons.arrow_forward_ios)
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

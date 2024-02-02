import 'Helpers/data_helpers.dart';
import 'constants/asset_paths_constants.dart';
import 'hive/models/habit/habit.dart';
import 'hive/models/onboard/onboard.dart';
import 'hive/models/userprofile/userprofile.dart';

// defaults
const String defaultUsername = 'Stranger';
final UserProfile defaultUserProfile = UserProfile(
  username: defaultUsername,
  avatar: defaultAvatar,
);

final Onboard defaultOnboard = Onboard(
  showOnboard: true,
);

final List<Habit> defaultHabits = [
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Drink Water',
    habitDescription: '1. Keep a manageble list of habits, 10 Max',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Exercise',
    habitDescription:
        '2. Let your habit be less that 25 character you dont wanna keep paragraph',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Read',
    habitDescription: '1. Keep a manageble list of habits, 10 Max',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Meditate',
    habitDescription: '3. Tap on habit to manage and view your overall streaks',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
  ),
];
const String tips =
    '''
1. Keep a manageble list of habits, 10 Max

2. Let your habit be less that 25 character you dont wanna keep paragraph of text

3. Tap on habit to manage and view your overall streaks

4. You retain all the habits, the stronger the color becomes on the heatmap

5. Habit heatmap is powerful tool if you've been working on a consistent habit list.

🚫 If you clear all your habits you will lose all the data stored for that list of habits
  ''';

// svg colors
const String svgPrimaryColor = '#FF0057CD';

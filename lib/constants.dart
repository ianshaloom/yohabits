import 'Helpers/data_helpers.dart';
import 'hive/models/habit/habit.dart';
import 'hive/models/onboard/onboard.dart';
import 'hive/models/userprofile/userprofile.dart';

// defaults
const String defaultUsername = 'Stranger';
const String defaultAvatar = 'assets/images/avatar-1.png';
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
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Exercise',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Read',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Meditate',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Eat Healthy',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
  Habit(
    habitId: DataHelpers.generateCode(10),
    habitName: 'Wake Up Early',
    isCompleted: false,
    dateCreated: DateTime.now(),
    daysCompleted: [],
    streak: 0,
  ),
];
const String tips = '''
1. Keep a manageble list of habits, 10 Max

2. Let your habit be less that 25 character you dont wanna keep paragraph of text

3. Tap on habit to manage and view your overall streaks

4. You retain all the habits, the stronger the color becomes on the heatmap

5. Habit heatmap is powerful tool if you've been working on a consistent habit list.

🚫 If you clear all your habits you will lose all the data stored for that list of habits
  ''';
// hive Boxes
const String habitBox = 'habitBox';
const String onboardBox = 'onboardBox';
const String userProfileBox = 'userProfileBox';
const String habitHistoryBox = 'habitHistoryBox';

// onboard images path
const String onboardImage1 = 'assets/images/onboard-svg-1.svg';
const String onboardImage2 = 'assets/images/onboard-svg-2.svg';
const String onboardImage3 = 'assets/images/onboard-svg-3.svg';

// avatar images path
const String femaleAvatar1 = 'assets/images/avatar-1.png';
const String femaleAvatar2 = 'assets/images/avatar-2.png';
const String maleAvatar1 = 'assets/images/avatar-3.png';
const String maleAvatar2 = 'assets/images/avatar-4.png';
const String maleAvatar3 = 'assets/images/avatar-5.png';
const List<String> avatars = [
  femaleAvatar1,
  femaleAvatar2,
  maleAvatar2,
  maleAvatar3
];

// streaks images path
const String currentStreakImage = 'assets/images/currentstreak.svg';
const String longestStreakImage = 'assets/images/longeststreak.svg';

// other svg images path
const String funUnderline = 'assets/images/fun-underline.svg';
const String arrowDown = 'assets/images/arrow.svg';

// svg colors
const String svgPrimaryColor = '#FF0057CD';

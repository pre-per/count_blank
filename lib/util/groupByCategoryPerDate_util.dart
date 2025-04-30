import 'package:count_bath/model/user_model.dart';

Map<String, Map<String, int>> groupByCategoryPerDate(
    Map<String, List<User>> groupedUsers,
    String Function(User) keySelector,
    ) {
  final Map<String, Map<String, int>> result = {};

  groupedUsers.forEach((date, users) {
    final map = <String, int>{};
    for (var user in users) {
      final key = keySelector(user);
      map[key] = (map[key] ?? 0) + 1;
    }
    result[date] = map;
  });

  return result;
}
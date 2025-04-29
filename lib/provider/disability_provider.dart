import 'package:count_bath/provider/userList_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final disabilityTypeProvider = Provider<Map<String, int>>((ref) {
  final userAsync = ref.watch(userListProvider);

  return userAsync.when(
    data: (users) {
      Map<String, int> counts = {};

      for (var user in users) {
        counts[user.disabilityType] = (counts[user.disabilityType] ?? 0) + 1;
      }

      return counts;
    },
    error: (_, _) => {},
    loading: () => {},
  );
});

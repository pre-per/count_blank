import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:count_bath/util/groupByCategoryPerDate_util.dart';
import 'package:count_bath/provider/groupUserByDate_provider.dart';

final disabilityTypeProvider = Provider<Map<String, Map<String, int>>>((ref) {
  final grouped = ref.watch(groupUserByDateProvider);
  return groupByCategoryPerDate(grouped, (user) => user.disabilityType);
});

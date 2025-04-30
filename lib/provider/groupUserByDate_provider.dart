import 'package:count_bath/model/user_model.dart';
import 'package:count_bath/provider/userList_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupUserByDateProvider = Provider<Map<String, List<User>>>((ref) {
  final userAsync = ref.watch(userListProvider);

  return userAsync.when(
    data: (users) {
      final grouped = <String, List<User>>{};

      for (final user in users) {
        grouped[user.date] ??= [];
        grouped[user.date]!.add(user);
      }

      return grouped;
    },
    error: (_, __) => {},
    loading: () => {},
  );
});
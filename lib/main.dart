import 'package:count_bath/provider/disability_provider.dart';
import 'package:count_bath/provider/groupUserByDate_provider.dart';
import 'package:count_bath/provider/severity_provider.dart';
import 'package:count_bath/provider/userList_provider.dart';
import 'package:count_bath/screen/total_oneeye_screen.dart';
import 'package:count_bath/widget/dropzone_widget.dart';
import 'package:count_bath/widget/user_statics_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        textTheme: GoogleFonts.notoSansKrTextTheme(),
      ),
      home: Mainscreen(),
    );
  }
}

class Mainscreen extends ConsumerWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final severityCounts = ref.watch(severityProvider);
    final disabilityCounts = ref.watch(disabilityTypeProvider);
    final userAsync = ref.watch(userListProvider);
    final groupedUsers = ref.watch(groupUserByDateProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          userAsync.when(
            data: (users) {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => TotalOneeyeScreen(severityCounts: severityCounts)));
            },
            error: (error, stk) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('오류 발생: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            loading: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('로딩중', style: TextStyle(color: Colors.black87)),
                backgroundColor: Colors.yellow,
              ),
            ),
          );
        },
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 사각형 버튼 느낌
        ),
        label: Text(
          '한 눈에 통계 보기',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                DropzoneWidget(),
                const SizedBox(height: 20.0),
                userAsync.when(
                  data: (users) {
                    final sortedDates =
                        groupedUsers.keys.toList()
                          ..sort((a, b) => b.compareTo(a));

                    // 전체 통계 계산
                    final totalSeverity = <String, int>{};
                    final totalDisability = <String, int>{};

                    for (final date in sortedDates) {
                      final dailySeverity = severityCounts[date] ?? {};
                      final dailyDisability = disabilityCounts[date] ?? {};

                      dailySeverity.forEach(
                        (k, v) =>
                            totalSeverity[k] = (totalSeverity[k] ?? 0) + v,
                      );
                      dailyDisability.forEach(
                        (k, v) =>
                            totalDisability[k] = (totalDisability[k] ?? 0) + v,
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserStaticsWidget(
                          severityCounts: totalSeverity,
                          disabilityCounts: totalDisability,
                          users: users,
                          date: '전체',
                        ),
                        const SizedBox(height: 30),

                        // ⬇ 날짜별 통계
                        ...sortedDates.map((date) {
                          final usersForDate = groupedUsers[date]!;
                          final severity = severityCounts[date] ?? {};
                          final disability = disabilityCounts[date] ?? {};

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserStaticsWidget(
                                severityCounts: severity,
                                disabilityCounts: disability,
                                users: usersForDate,
                                date: date,
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  },
                  error: (error, _) => Center(child: Text('오류 발생: $error')),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

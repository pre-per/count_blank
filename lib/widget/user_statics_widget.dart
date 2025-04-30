import 'package:count_bath/provider/disability_provider.dart';
import 'package:count_bath/provider/severity_provider.dart';
import 'package:count_bath/provider/userList_provider.dart';
import 'package:count_bath/widget/disabilityType_icon_widget.dart';
import 'package:count_bath/screen/severity_details_screen.dart';
import 'package:count_bath/widget/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStaticsWidget extends ConsumerWidget {
  const UserStaticsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final severityCounts = ref.watch(severityProvider);
    final disabilityCounts = ref.watch(disabilityTypeProvider);
    final userAsync = ref.watch(userListProvider);

    return userAsync.when(
      data: (users) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이용자 정보 통계',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DisabilitytypeIconWidget(
                        title: '중증 장애인',
                        iconData: Icons.accessible,
                        peopleNumber: severityCounts['중증'] ?? -1,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => SeverityDetailsScreen(users: users.where((u) => u.severity == '중증').toList(), title: '중증'),
                            ),
                          );
                        },
                      ),
                      DisabilitytypeIconWidget(
                        title: '경증 장애인',
                        iconData: Icons.directions_walk,
                        peopleNumber: severityCounts['경증'] ?? -1,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => SeverityDetailsScreen(users: users.where((u) => u.severity == '경증').toList(), title: '경증'),
                            ),
                          );
                        },
                      ),
                      DisabilitytypeIconWidget(
                        title: '보호자',
                        iconData: Icons.people,
                        peopleNumber: severityCounts['보호자'] ?? -1,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => SeverityDetailsScreen(users: users.where((u) => u.severity == '보호자').toList(), title: '보호자'),
                            ),
                          );
                        },
                      ),
                      DisabilitytypeIconWidget(
                        title: '기타',
                        iconData: Icons.folder,
                        peopleNumber: severityCounts['기타'] ?? -1,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => SeverityDetailsScreen(users: users.where((u) => u.severity == '기타').toList(), title: '기타'),
                            ),
                          );
                        },
                      ),
                      DisabilitytypeIconWidget(
                        title: '전체',
                        iconData: Icons.functions,
                        peopleNumber: users.length,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => SeverityDetailsScreen(users: users, title: '전체'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    '장애유형별 이용자 수',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  PieChartWidget(counts: disabilityCounts),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) => Center(child: Text('오류 발생: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

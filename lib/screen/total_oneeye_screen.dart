import 'package:count_bath/widget/oneEye_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:count_bath/widget/userDetail_card_widget.dart';

class TotalOneeyeScreen extends StatelessWidget {
  final Map<String, Map<String, int>> severityCounts;

  const TotalOneeyeScreen({required this.severityCounts, super.key});

  @override
  Widget build(BuildContext context) {
    final sortedDates =
        severityCounts.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: Text('한 눈에 보기'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          OneeyeCardWidget(
            date: '날짜',
            content1: '중증',
            content2: '경증',
            content3: '보호자',
            content4: '기타',
            totalNum: '전체',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final counts = severityCounts[date]!;
                final total = counts.values.fold<int>(
                  0,
                  (sum, val) => sum + val,
                );

                return OneeyeCardWidget(
                  date: date,
                  content1: '${counts['중증'] ?? 0}',
                  content2: '${counts['경증'] ?? 0}',
                  content3: '${counts['보호자'] ?? 0}',
                  content4: '${counts['기타'] ?? 0}',
                  totalNum: '$total',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

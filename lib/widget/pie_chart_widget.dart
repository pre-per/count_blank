import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, int> counts;

  const PieChartWidget({required this.counts, super.key});

  static const List<Color> pastelColors = [
    Color(0xFFEF5350), // 빨강
    Color(0xFFAB47BC), // 보라
    Color(0xFF5C6BC0), // 인디고
    Color(0xFF29B6F6), // 하늘
    Color(0xFF26A69A), // 청록
    Color(0xFF66BB6A), // 연두
    Color(0xFFD4E157), // 라임
    Color(0xFFFFCA28), // 노랑
    Color(0xFFFFA726), // 주황
    Color(0xFFFF7043), // 진한 오렌지
    Color(0xFF8D6E63), // 브라운
    Color(0xFF78909C), // 블루그레이
    Color(0xFF7E57C2), // 진보라
    Color(0xFF26C6DA), // 시안
    Color(0xFFEC407A), // 진한 핑크
  ];

  @override
  Widget build(BuildContext context) {
    final sortedEntries = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    final int total = sortedEntries.fold<int>(0, (sum, entry) => sum + entry.value);

    final sections = sortedEntries.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value.value;
      final color = pastelColors[index % pastelColors.length];

      return PieChartSectionData(
        value: value.toDouble(),
        color: color,
        title: '',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      );
    }).toList();

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 300.0,
            child: PieChart(PieChartData(
              centerSpaceRadius: 60.0,
              sectionsSpace: 2,
              sections: sections,
            )),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: sortedEntries.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value.key;
              final value = entry.value.value;
              final percent = ((value / total) * 100).toStringAsFixed(1);
              final color = pastelColors[index % pastelColors.length];

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 12, height: 12, color: color),
                  const SizedBox(width: 6),
                  Text('$label: $percent%($value명)', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

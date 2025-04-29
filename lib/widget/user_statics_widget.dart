import 'package:count_bath/provider/severity_provider.dart';
import 'package:count_bath/widget/disabilityType_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStaticsWidget extends ConsumerWidget {
  const UserStaticsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final severityCounts = ref.watch(severityProvider);
    
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Text('이용자 정보 통계', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10.0),
          Row(
            children: [
              DisabilitytypeIconWidget(title: '중증 장애인', iconData: Icons.accessible, peopleNumber: severityCounts['중증']!),
              const SizedBox(width: 5.0),
              DisabilitytypeIconWidget(title: '경증 장애인', iconData: Icons.directions_walk, peopleNumber: severityCounts['경증']!),
              const SizedBox(width: 5.0),
              DisabilitytypeIconWidget(title: '보호자', iconData: Icons.people, peopleNumber: severityCounts['보호자']!),
              const SizedBox(width: 5.0),
              DisabilitytypeIconWidget(title: '기타', iconData: Icons.folder, peopleNumber: severityCounts['기타']!),
            ],
          ),
          const SizedBox(height: 10.0),
          Text('장애유형별 이용자 수', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10.0),
        ]),
      ),
    );
  }
}

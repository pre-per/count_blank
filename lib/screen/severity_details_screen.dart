import 'package:count_bath/widget/userDetail_card_widget.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class SeverityDetailsScreen extends StatelessWidget {
  final String title;
  final List<User> users;

  const SeverityDetailsScreen({required this.title, required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
          UserdetailCardWidget(name: '이름', severity: '장애정도', disabilityType: '장애유형', rowNumber: '행 번호'),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final User user = users[index];
                return UserdetailCardWidget(name: user.name, severity: user.severity, disabilityType: user.disabilityType, rowNumber: user.rowNumber.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}

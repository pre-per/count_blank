import 'package:flutter/material.dart';

class DisabilitytypeIconWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final int peopleNumber;

  const DisabilitytypeIconWidget({
    required this.title,
    required this.iconData,
    required this.peopleNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        height: 150.0,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 30.0),
              const SizedBox(height: 6.0),
              Text(title, style: TextStyle(fontSize: 15.0)),
              const SizedBox(height: 6.0),
              Text('$peopleNumber명', style: TextStyle(fontSize: 15.0, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DisabilitytypeIconWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final int peopleNumber;
  final Function()? onTap;

  const DisabilitytypeIconWidget({
    required this.title,
    required this.iconData,
    required this.peopleNumber,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.blue.withOpacity(0.2),
      splashColor: Colors.blue.withOpacity(0.2),
      borderRadius: BorderRadius.circular(6.0),
      child: Ink(
        height: 150.0,
        width: MediaQuery.of(context).size.width * 0.18,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50.0, color: Colors.blueGrey),
              const SizedBox(height: 6.0),
              Text(
                title,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6.0),
              Text(
                (peopleNumber <= 0) ? '없음' : '$peopleNumber명',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

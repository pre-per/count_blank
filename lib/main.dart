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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                DropzoneWidget(),
                const SizedBox(height: 15.0),
                UserStaticsWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

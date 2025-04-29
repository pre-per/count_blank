import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileProvider = StateProvider<File?>((ref) => null);

class DropzoneWidget extends ConsumerStatefulWidget {
  const DropzoneWidget({super.key});

  @override
  ConsumerState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends ConsumerState<DropzoneWidget> {
  bool _dragging = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      ref.read(fileProvider.notifier).state = file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final droppedFile = ref.watch(fileProvider);

    return GestureDetector(
      onTap: _pickFile,
      child: DropTarget(
        onDragEntered: (_) {
          setState(() {
            () => _dragging = true;
          });
        },
        onDragExited: (_) {
          setState(() {
            () => _dragging = false;
          });
        },
        onDragDone: (details) {
          if (details.files.isNotEmpty) {
            final file = File(details.files.single.path);
            ref.read(fileProvider.notifier).state = file;
          }
        },
        child: DottedBorder(
          color: Colors.grey,
          strokeWidth: 2,
          dashPattern: [8, 4], // 점선 길이: 8, 간격: 4
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          child: Container(
            height: 300.0,
            width: MediaQuery.of(context).size.height * 0.8,
            color: _dragging ? Colors.green[200] : Colors.white,
            child: Center(
              child:
                  droppedFile == null
                      ? Text(
                        '파일을 드래그하거나 클릭하세요',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ) // 드래그 하기 전 띄워지는 메시지
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task, size: 50.0),
                          const SizedBox(height: 15.0),
                          Text(
                            '선택된 파일: ${droppedFile.path.split(Platform.pathSeparator).last}',
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ), // 드래그 한 후 띄워지는 메시지
            ),
          ),
        ),
      ),
    );
  }
}

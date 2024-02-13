import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';



ScreenshotController screenshotController = ScreenshotController();

convertWidget({required Widget widget ,required void Function(File file,File back)onCreate}) async {


 var capturedImage=await screenshotController.captureFromWidget(widget);

  String filename = "dkjn.png";
  String back = "rakhaa_story.png";
  final tempDir = await getTemporaryDirectory(); // Get temporary directory to store the generated image
  final file = await File('${tempDir.path}/$filename').create(); // Create a file to store the generated image
  final back_file = await File('${tempDir.path}/$back').create(); // Create a file to store the generated image
  await file.writeAsBytes(capturedImage);
  onCreate(file,back_file);
  ImageGallerySaver.saveImage(capturedImage,quality: 100);

 }



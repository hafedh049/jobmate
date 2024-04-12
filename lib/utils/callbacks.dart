import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:jobmate/utils/shared.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String message, {Color color = lightOrangeColor}) {
  toastification.show(
    context: context,
    title: Text("Notification", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: color)),
    description: Text(message, style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: color)),
    autoCloseDuration: 3.seconds,
  );
}

Future<void> init() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  user = await Hive.openBox("user");
  if (!user!.containsKey("favorites")) {
    user!.put("favorites", <Map<String, dynamic>>[]);
  }
}

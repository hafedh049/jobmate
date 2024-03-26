import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmate/utils/shared.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesome.bars_staggered_solid, size: 20, color: greyColor),
                ),
                const Spacer(),
                InkWell(
                  hoverColor: transparentColor,
                  splashColor: transparentColor,
                  highlightColor: transparentColor,
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: blackColor),
                      image: const DecorationImage(image: AssetImage("assets/images/pp.png")),
                    ),
                  ).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true)).shimmer(color: whiteColor.withOpacity(.5), duration: 3.seconds),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text("Hello Mrs. Manar", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 10),
            Text("Find your perfect job", style: GoogleFonts.itim(fontSize: 30, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) _) {
                      return TextField(
                        onChanged: (String value) {
                          if (value.length <= 1) {
                            _(() {});
                          }
                        },
                        controller: _filterController,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

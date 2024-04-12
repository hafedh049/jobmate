import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmate/utils/callbacks.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/shared.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key, required this.job});
  final Map<String, dynamic> job;
  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final List<String> _buttons = const <String>["About", "Qualifications", "Responsabilities"];
  String _button = "About";

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: greyColor),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {},
                  icon: const Icon(FontAwesome.share_solid, size: 20, color: greyColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 3), color: blackColor.withOpacity(.3))],
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(FontAwesome.cubes_stacked_solid, size: 20, color: blueColor),
            ),
            const SizedBox(height: 20),
            Text(widget.job["job_title"], style: GoogleFonts.itim(fontSize: 20, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 10),
            Text(widget.job["job_country"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (final String button in _buttons)
                      InkWell(
                        hoverColor: transparentColor,
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                        onTap: () {
                          _pageController.jumpToPage(_buttons.indexOf(button));
                          _(() => _button = button);
                        },
                        child: AnimatedContainer(
                          duration: 500.ms,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: _button == button ? blackColor : greyColor.withOpacity(.3), borderRadius: BorderRadius.circular(15)),
                          child: Text(button, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: _button == button ? whiteColor : blackColor)),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: .3, color: greyColor),
                ),
                padding: const EdgeInsets.all(16),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("About the JOB", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
                        const SizedBox(height: 10),
                        Text("Overview", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor)),
                        const SizedBox(height: 10),
                        Expanded(child: SingleChildScrollView(child: Text(widget.job["job_description"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor)))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("QUALIFICATIONS", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: widget.job["job_highlights"]["Qualifications"] == null
                              ? Text("N/A", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor))
                              : SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      for (final String item in widget.job["job_highlights"]["Qualifications"]) ...<Widget>[
                                        Text(item, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor)),
                                        const SizedBox(height: 10),
                                      ],
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("BENEFITS", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
                        const SizedBox(height: 10),
                        widget.job["job_highlights"]["Benefits"] == null
                            ? Text("N/A", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor))
                            : Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      for (final String item in widget.job["job_highlights"]["Benefits"]) ...<Widget>[
                                        Text(item, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor)),
                                        const SizedBox(height: 10),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return InkWell(
                      hoverColor: transparentColor,
                      splashColor: transparentColor,
                      highlightColor: transparentColor,
                      onTap: () {
                        if (user!.get("favorites").where((e) => e["job_id"] == widget.job["job_id"]).isEmpty) {
                          user!.put("favorites", user!.get("favorites")..add(widget.job));
                          showToast(context, "Added to favorites");
                          _(() {});
                        } else {
                          showToast(context, "Already added to favorites");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: lightOrangeColor, width: 1.5), borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Icon(user!.get("favorites").where((e) => e["job_id"] == widget.job["job_id"]).isEmpty ? FontAwesome.heart : FontAwesome.heart_solid, size: 20, color: lightOrangeColor),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onTap: () async => await launchUrlString(widget.job["job_google_link"]),
                    child: Container(
                      decoration: BoxDecoration(color: lightOrangeColor, borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text("Apply for a job", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: whiteColor)),
                    ),
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

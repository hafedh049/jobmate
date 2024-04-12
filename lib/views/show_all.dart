import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../utils/shared.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key, required this.jobs});
  final List<Map<String, dynamic>> jobs;
  @override
  State<ShowAll> createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: greyColor)),
            const SizedBox(height: 20),
            Text("Contractor", style: GoogleFonts.itim(fontSize: 20, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 10),
            Text("Job Opportunities", style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: .3, color: greyColor),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 1), color: greyColor.withOpacity(.1))],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 3), color: blackColor.withOpacity(.3))],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(FontAwesome.cubes_stacked_solid, size: 20, color: blueColor),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(widget.jobs[index]["job_title"], style: GoogleFonts.itim(fontSize: 12, fontWeight: FontWeight.w500, color: greyColor)),
                            const SizedBox(height: 10),
                            Text(widget.jobs[index]["employer_company_type"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                itemCount: widget.jobs.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

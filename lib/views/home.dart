import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jobmate/utils/shared.dart';
import 'package:jobmate/views/job_details.dart';
import 'package:jobmate/views/show_all.dart';
import 'package:lottie/lottie.dart';

import '../utils/callbacks.dart';

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

  List<Map<String, dynamic>> _popularJobs = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _nearbyJobs = <Map<String, dynamic>>[];

  final List<String> _jobsTypes = const <String>["Full-time", "Part-time", "Contractor"];
  String _selectedJobType = "Full-time";

  final GlobalKey<State<StatefulWidget>> _popularKey = GlobalKey<State<StatefulWidget>>();
  final GlobalKey<State<StatefulWidget>> _nearbyKey = GlobalKey<State<StatefulWidget>>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Map<String, dynamic>>> _fetchPopularJobs() async {
    const String url = "https://jsearch.p.rapidapi.com/search";
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      "query": _filterController.text.trim().isEmpty ? "Python developer" : _filterController.text.trim(),
      "page": "1",
      "num_pages": "1",
    };

    final Map<String, dynamic> headers = <String, dynamic>{
      "X-RapidAPI-Key": "144c6ec532msh774a6839c2a40b2p1a44eejsna62dcd20790c",
      "X-RapidAPI-Host": "jsearch.p.rapidapi.com",
    };

    final Dio dio = Dio();

    final Response response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return response.data["data"].cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> _fetchNearbyJobs() async {
    const String url = "https://jsearch.p.rapidapi.com/search";
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      "query": _filterController.text.trim().isEmpty ? "Python developer" : _filterController.text.trim(),
      "page": "1",
      "num_pages": "1",
    };

    final Map<String, dynamic> headers = <String, dynamic>{
      "X-RapidAPI-Key": "144c6ec532msh774a6839c2a40b2p1a44eejsna62dcd20790c",
      "X-RapidAPI-Host": "jsearch.p.rapidapi.com",
    };

    final Dio dio = Dio();

    final Response response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return response.data["data"].cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) => user!.get("favorites").isEmpty
                ? Center(child: LottieBuilder.asset("assets/lotties/empty.json"))
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: greyColor.withOpacity(.1)),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(user!.get("favorites")[index]["job_title"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: whiteColor)),
                              const SizedBox(height: 20),
                              Text(user!.get("favorites")[index]["job_publisher"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: whiteColor)),
                              const SizedBox(height: 20),
                              Text(user!.get("favorites")[index]["job_employment_type"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: whiteColor)),
                              const SizedBox(height: 20),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              user!.put("favorites", user!.get("favorites")..removeAt(index));
                              showToast(context, "Job removed from favorites");
                              _(() {});
                            },
                            icon: const Icon(FontAwesome.x_solid, color: redColor, size: 20),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                    itemCount: user!.get("favorites").length,
                  ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    icon: const Icon(FontAwesome.bars_staggered_solid, size: 20, color: greyColor),
                  ),
                  const Spacer(),
                  InkWell(
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
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
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(color: greyColor.withOpacity(.1), borderRadius: BorderRadius.circular(5)),
                      child: StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) _) {
                          return TextField(
                            onChanged: (String value) {
                              if (value.length <= 1) {
                                _(() {});
                              }
                              _popularKey.currentState!.setState(() {});
                              _nearbyKey.currentState!.setState(() {});
                            },
                            controller: _filterController,
                            cursorColor: lightOrangeColor,
                            cursorWidth: 2,
                            style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8),
                              labelText: "Job filter",
                              labelStyle: GoogleFonts.itim(fontSize: 12, fontWeight: FontWeight.w500, color: blackColor),
                              hintText: "Search a specific job",
                              hintStyle: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor),
                              prefixIcon: _filterController.text.isEmpty ? null : const Icon(FontAwesome.check_solid, size: 20, color: lightOrangeColor),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(color: lightOrangeColor, borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      child: const Icon(FontAwesome.magnifying_glass_solid, size: 20, color: whiteColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (final String jobType in _jobsTypes)
                        InkWell(
                          hoverColor: transparentColor,
                          splashColor: transparentColor,
                          highlightColor: transparentColor,
                          onTap: () => _(() => _selectedJobType = jobType),
                          child: AnimatedContainer(
                            duration: 500.ms,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: _selectedJobType == jobType ? blackColor : null, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: blackColor)),
                            child: Text(jobType, style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: _selectedJobType == jobType ? whiteColor : blackColor)),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text("Popular Jobs", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
                  const Spacer(),
                  InkWell(
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onTap: () {
                      if (_popularJobs.isEmpty) {
                        showToast(context, "No jobs found", color: redColor);
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShowAll(jobs: _popularJobs)));
                      }
                    },
                    child: Text("Show all", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 160,
                child: StatefulBuilder(
                  key: _popularKey,
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchPopularJobs(),
                      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          _popularJobs = snapshot.data!.where((Map<String, dynamic> element) => element["job_title"].toLowerCase().contains(_filterController.text.trim().toLowerCase())).toList();
                          return _popularJobs.isEmpty
                              ? LottieBuilder.asset("assets/lotties/empty.json")
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) => InkWell(
                                    hoverColor: transparentColor,
                                    splashColor: transparentColor,
                                    highlightColor: transparentColor,
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetails(job: _popularJobs[index]))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(width: .3, color: greyColor),
                                        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 1), color: greyColor.withOpacity(.1))],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
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
                                          const SizedBox(height: 10),
                                          Flexible(child: Text(_popularJobs[index]["job_title"], style: GoogleFonts.itim(fontSize: 12, fontWeight: FontWeight.w500, color: greyColor))),
                                          const SizedBox(height: 10),
                                          Text(_popularJobs[index]["job_publisher"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor)),
                                          const SizedBox(height: 10),
                                          Text(_popularJobs[index]["job_employment_type"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: greyColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                                  itemCount: _popularJobs.length,
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: lightOrangeColor));
                        } else {
                          return Text(snapshot.error.toString(), style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: blackColor));
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text("Nearby Jobs", style: GoogleFonts.itim(fontSize: 22, fontWeight: FontWeight.w500, color: blackColor)),
                  const Spacer(),
                  InkWell(
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    onTap: () {
                      if (_popularJobs.isEmpty) {
                        showToast(context, "No nearby jobs found", color: redColor);
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShowAll(jobs: _nearbyJobs)));
                      }
                    },
                    child: Text("Show all", style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: greyColor)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StatefulBuilder(
                  key: _nearbyKey,
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchNearbyJobs(),
                      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          _nearbyJobs = snapshot.data!.where((Map<String, dynamic> element) => element["job_title"].toLowerCase().contains(_filterController.text.trim().toLowerCase())).toList();
                          return _nearbyJobs.isEmpty
                              ? LottieBuilder.asset("assets/lotties/empty.json")
                              : ListView.separated(
                                  itemBuilder: (BuildContext context, int index) => InkWell(
                                    hoverColor: transparentColor,
                                    splashColor: transparentColor,
                                    highlightColor: transparentColor,
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetails(job: _nearbyJobs[index]))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(width: .3, color: greyColor),
                                        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 1), color: greyColor.withOpacity(.1))],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: <BoxShadow>[BoxShadow(blurRadius: 25, blurStyle: BlurStyle.outer, offset: const Offset(1, 1), color: greyColor.withOpacity(.1))],
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
                                                Text(_nearbyJobs[index]["job_title"], style: GoogleFonts.itim(fontSize: 12, fontWeight: FontWeight.w500, color: greyColor)),
                                                const SizedBox(height: 10),
                                                Text(_nearbyJobs[index]["job_employment_type"], style: GoogleFonts.itim(fontSize: 16, fontWeight: FontWeight.w500, color: blackColor)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                                  itemCount: _nearbyJobs.length,
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: lightOrangeColor));
                        } else {
                          return Text(snapshot.error.toString(), style: GoogleFonts.itim(fontSize: 14, fontWeight: FontWeight.w500, color: blackColor));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

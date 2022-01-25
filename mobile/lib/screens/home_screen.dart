import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/allPosts.dart';
import 'package:mobile/screens/curated_screen.dart';
import 'package:mobile/screens/vibing_screen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size(double.infinity, kToolbarHeight),
                    child: SafeArea(
                        child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            InkWell(
                                child: const Icon(Icons.refresh_rounded,
                                    color: tualeBlueDark),
                                onTap: () {
                                  Curated.loadPosts(context);
                                  //Vibing.loadPosts(context);
                                }),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TabBar(
                                    unselectedLabelColor: tualeBlueDark,
                                    indicatorColor: tualeOrange,
                                    indicatorWeight: 1.1,
                                    labelColor: tualeOrange,
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1),
                                    tabs: [
                                  Tab(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                        Text("Vibing"),
                                        Icon(TualeIcons.vibing, size: 15)
                                      ])),
                                  const Tab(text: "Curated")
                                ])),
                            const SizedBox(width: 10),
                            InkWell(
                                child: const Icon(TualeIcons.notificationbell,
                                    color: tualeBlueDark),
                                onTap: () {})
                          ])),
                      Container(
                          height: 0.5,
                          width: double.infinity,
                          color: Colors.grey.shade400)
                    ]))),
                body: TabBarView(children: [Vibing(), Curated()]))));
  }
}


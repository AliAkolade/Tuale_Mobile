import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/tuale_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class discoverScreen extends StatefulWidget {
  int? index;

  discoverScreen({this.index});

  @override
  _discoverScreenState createState() => _discoverScreenState();
}

class _discoverScreenState extends State<discoverScreen> {
  final ItemScrollController itemScrollControll = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    Future scrollToIndex(index) async {
      itemScrollControll.jumpTo(
        index: index,
        alignment: 0.5,
      );
    }

    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => scrollToIndex(widget.index));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: ScrollablePositionedList.builder(
            itemCount: 8,
            itemScrollController: itemScrollControll,
            itemPositionsListener: itemPositionsListener,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Container(
                  height: 300,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: AlignmentDirectional(0.5, 0.5),
                        end: AlignmentDirectional(0.5, 1.9),
                        colors: [Colors.transparent, Colors.black87],
                      )),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/demo_profile.png"),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  const Text(
                                    "@Singe",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  const Text(
                                    "1 day ago",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        height: 1),
                                  ),
                                  const Spacer(
                                    flex: 15,
                                  ),
                                ],
                              ),
                              Container(
                                  // color: Colors.white70,
                                  height: 50,
                                  width: 950,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "There is always a light bulb in your head.\n #ideas run the world.",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          // fontFamily: 'Poppins',
                                          fontSize: 15,
                                          height: 1,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      )),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/Demo_Image.jpg"))),
                margin: EdgeInsets.all(12),
                height: 350,
                width: 100,
              );
            },
          ),
        ),
      ),
    );
  }
}

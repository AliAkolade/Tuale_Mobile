import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mobile/screens/Discover/controllers/searchController.dart';
import 'package:mobile/screens/imports.dart';
import 'package:mobile/screens/widgets/verifiedTag.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SearchController searchControl = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 12),
            child: SizedBox(
              height: 45.h,
              width: double.infinity,
              child: TextField(
                onChanged: (value) {
                  if (value.isEmpty || value == "") {
                    //Get.find<SearchController>().isEmpty();
                    Get.find<SearchController>().getSearch('');
                    print('hey${value}');
                  } else {
                    Get.find<SearchController>().getSearch(value);
                    print('heyyy${value}');
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 2),
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: "Search",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.grey.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.grey.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        actions: [
          SizedBox(
            width: 10.w,
          )
        ],
        title: Text(
          "Discover",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: GetBuilder<SearchController>(
          //  autoRemove: false,
          init: SearchController(),
          builder: (searchController) {
            return searchController.isLoading.value
                ? SpinKitFadingCircle(color: tualeOrange.withOpacity(0.75))
                : searchController.onBegin.value
                    ? Container()
                    : searchController.searchresult.isEmpty
                        ? Container(
                            child: Center(
                              child: Text("No result Found"),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: searchController.searchresult.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .topToBottom,
                                              child: userProfile(
                                                isUser: false,
                                                username: searchController
                                                    .searchresult[index]
                                                    .usernames,
                                                //tag: "search"
                                              )));
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 60.h,
                                            width: 60.h,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              child: SizedBox(
                                                height: 57.h,
                                                width: 57.h,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      Image.network(
                                                              searchController
                                                                  .searchresult[
                                                                      index]
                                                                  .avatar!)
                                                          .image,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              //  mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        searchController
                                                            .searchresult[index]
                                                            .name!,
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                tualeBlueDark)),
                                                    SizedBox(width: 5.w),
                                                    searchController
                                                            .searchresult[index]
                                                            .isVerified!
                                                        ? verifiedTag()
                                                        : Container()
                                                  ],
                                                ),
                                                Text(
                                                  '@' +
                                                      searchController
                                                          .searchresult[index]
                                                          .usernames!,
                                                  style: TextStyle(
                                                      color: tualeBlueDark),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.3)))),
                                      height: 100.h,
                                      padding: EdgeInsets.only(
                                        top: 15,
                                        bottom: 5,
                                        left: 15,
                                      ),
                                      width: ScreenUtil().screenWidth,
                                    ),
                                  );
                                }));
          }),
    );
  }
}

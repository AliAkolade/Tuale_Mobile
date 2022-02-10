import 'package:mobile/screens/imports.dart';

class PostTimeline extends StatefulWidget {
  PostTimeline({Key? key}) : super(key: key);

  @override
  _PostTimelineState createState() => _PostTimelineState();
}

class _PostTimelineState extends State<PostTimeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.black,
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Post to timeline",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.9)))),
            child: SizedBox(
              height: 300.h,
              width: 300.h,
              child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/demoPost.png")),
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              height: MediaQuery.of(context).size.height * 0.23,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  //  color: Colors.black,
                  border: Border(
                      //top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.h,
                    width: ScreenUtil().screenWidth,
                    child: TextField(
                      maxLines: 7,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              style: BorderStyle.solid, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              style: BorderStyle.solid, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 32.h,
                        width: 150.w,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          '# Recent Hashtags ',
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Container(
                        height: 32.h,
                        width: 110.w,
                        margin: EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          '@ Tag People',
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(5, 10, 10, 5),
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.5)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Privacy Settings",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              )),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(230, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text('Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        height: 1))),
          )
        ],
      ),
    );
  }
}

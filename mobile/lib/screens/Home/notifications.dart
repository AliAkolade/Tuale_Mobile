import 'package:mobile/screens/imports.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 18,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            //  color: Colors.black,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '@tijani ',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: tualeBlueDark.withOpacity(0.7),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'just gave you a tuale',
                          style:
                              TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 10),
            //  color: Colors.black,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              
              children: [
                RichText(
                  text: TextSpan(
                    text: '@tijani ',
                    style: TextStyle(
                       fontSize: 15.sp,
                        color: tualeBlueDark.withOpacity(0.7),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'is vibing with you',
                          style:
                          
                              TextStyle(
                              
                                color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 10),
            //  color: Colors.black,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '@tijani ',
                    style: TextStyle(
                      fontSize: 15.sp,
                        color: tualeBlueDark.withOpacity(0.7),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'just starred some of your posts',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 8),
            //  color: Colors.black,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: '@tijani ',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: tualeBlueDark.withOpacity(0.7),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'started vibing with you',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8))),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize:  Size(55.w, 37.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Text('Vibe Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1)),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child:
                                      SvgPicture.asset("assets/icon/vibe.svg"))
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

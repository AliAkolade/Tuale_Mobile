import 'package:mobile/screens/imports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                onChanged: (value) {},
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
          Icon(TualeIcons.notificationbell, color: tualeBlueDark),
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
      body: Expanded(
        child: Container(),
      ),
    );
    
  }
}

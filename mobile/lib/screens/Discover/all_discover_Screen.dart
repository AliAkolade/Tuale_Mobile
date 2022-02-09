


import 'package:mobile/screens/imports.dart';
class allScreen extends StatelessWidget {
  const allScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.only(left:11, right:11, top:11,),
      child: GridView.builder(
        itemCount: 15,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        
      ), itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap:  () {
              Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom, child: ViewPost(index: index )));
    

          },
          child: Container(
            child: Container(
            
              height:100.h,
              width: 120.w,
                decoration: BoxDecoration(
                  
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        begin: AlignmentDirectional(0.5, 0.5),
                        end: AlignmentDirectional(0.5, 1.9),
                        colors: [Colors.transparent, Colors.black87],
                      )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text("@marinadiamis", style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp
                    ),),
                    Spacer(flex: 3,),
            
                    Icon(TualeIcons.tualeactive,
                    size: 12.sp,
                    color: tualeOrange,
            
                     ),
                      Spacer(),
                    Text("23", style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp
                    ),),
                  ],
                ),
              ),
            ),
            decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                image: AssetImage("assets/images/demoPost.png"))),
            margin: EdgeInsets.all(2),
          
            height: 100.h,
            width: 120.w,
          ),
        );
      }),
    );
  }
}


import 'package:mobile/screens/imports.dart';

class AllPosts extends StatefulWidget {
  AllPosts({Key? key}) : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
    
      //physics: NeverScrollableScrollPhysics(),
  
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       // mainAxisExtent: 5,
      crossAxisCount: 3,
      
    ), delegate: SliverChildBuilderDelegate(
      
      (BuildContext context, int index){
    
        
      return GestureDetector(
        onTap:  () {
            Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.topToBottom, child: discoverScreen(index: index )));
    
    
        },
        child: Container(
          child: Container(
            height:100,
            width: 100,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: AlignmentDirectional(0.5, 0.5),
                      end: AlignmentDirectional(0.5, 1.9),
                      colors: [Colors.transparent, Colors.black87],
                    )),
            
          ),
          decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                fit: BoxFit.cover,
              image: AssetImage("assets/images/demoPost.png"))),
          margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        
          height: 100,
          width: 100,
        ),
      );
    },
      childCount: 10,
       )
    );
  
  }
}

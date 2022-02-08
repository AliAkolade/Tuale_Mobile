import 'package:mobile/screens/imports.dart';




class TpBalanceScreen extends StatefulWidget {
  const TpBalanceScreen({ Key? key }) : super(key: key);

  @override
  _TpBalanceScreenState createState() => _TpBalanceScreenState();
}

class _TpBalanceScreenState extends State<TpBalanceScreen> {
  List price = [
    {
      6: "500.00"
    },
     {
      12: "500.00"
    },
     {
      26: "500.00"
    },
     {
      60: "500.00"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(

            border: Border(
                 top: BorderSide(color: Colors.grey.withOpacity(0.3)),
              bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
            )
          ),
         // color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tuallet Points",
              style: TextStyle(
                color: tualeBlueDark,
                fontFamily: "Poppins",
                fontSize: 25.sp,
                fontWeight: FontWeight.w600

              ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Icon(TualeIcons.tualeactive,
                    size: 55,
                    color: Color.fromRGBO(244, 211, 94, 1),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("123",
                    style: TextStyle(
                      color: Colors.black,
                         fontFamily: 'Poppins',
                         fontWeight:FontWeight.bold,
                         fontSize: 27,
                    ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
          Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text("Buy Tuale Points",
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 21.sp,
               fontFamily: 'Poppins',
               fontWeight: FontWeight.w500,
          ),
          ),
        ),
        Expanded(child: 
        
        ListView.builder(
          itemCount: price.length,
          itemBuilder: (BuildContext context, int index) {
            Map prices = price[index];

            return Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
             // color: Colors.black,
              height: 70,
              child: Row(
          
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    
                  Container(
                    padding: EdgeInsets.only(left: 0, right: 0, bottom: 10),
                    child: const Icon(TualeIcons.tualeactive,
              
                      size: 30,
                      color: Color.fromRGBO(244, 211, 94, 1),
                      ),
                  ),
           Spacer(flex: 1,),
                  Text("${prices.keys.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => "")} Tuale Points",
                style:  TextStyle(
                  color: Colors.black.withOpacity(0.8),
                 fontWeight: FontWeight.normal,
                  fontSize: 19.sp,
                   fontFamily: 'Poppins',
                ),
                ),
               
                    Spacer(flex: 3,),
                    Center(
                      child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: SignUp()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: tualeBlueDark,
                                minimumSize: const Size(100, 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(nairaSign+prices.values.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => ""),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                   // fontFamily: 'Poppins',
                                    fontSize: 16.sp,
                                   fontWeight: FontWeight.w500,
                                    height: 1))),
                    ),
                                      Spacer(flex: 1,),
                ],
              ),
            );
          },
        ),
        )

      ],
    );
  }
}
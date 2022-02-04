import 'package:mobile/screens/imports.dart';




class TpBalanceScreen extends StatefulWidget {
  const TpBalanceScreen({ Key? key }) : super(key: key);

  @override
  _TpBalanceScreenState createState() => _TpBalanceScreenState();
}

class _TpBalanceScreenState extends State<TpBalanceScreen> {
  List price = [
    {
      6: "#500"
    },
     {
      12: "#500"
    },
     {
      26: "#500"
    },
     {
      60: "#500"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(

            border: Border(
                 top: BorderSide(color: Colors.grey.withOpacity(0.3)),
              bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
            )
          ),
         // color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const  Text("Tuallet Points",
              style: TextStyle(
                color: tualeBlueDark,
                fontFamily: "Poppins",
                fontSize: 20

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
                const Icon(TualeIcons.tualeactive,
              
                    size: 30,
                    color: Color.fromRGBO(244, 211, 94, 1),
                    ),
           Spacer(flex: 1,),
                  Text("${prices.keys.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => "")} Tuale Points",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                ),
                    Spacer(flex: 3,),
                    ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SignUp()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: tualeBlueDark,
                              minimumSize: const Size(100, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(prices.values.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => ""),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                  height: 1))),
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
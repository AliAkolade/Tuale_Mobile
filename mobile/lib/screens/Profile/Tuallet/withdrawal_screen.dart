import 'package:mobile/screens/imports.dart';




class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({ Key? key }) : super(key: key);

  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  List price = [
    {
      6: "#500.00"
    },
     {
      12: "#500.00"
    },
     {
      26: "#500.00"
    },
     {
      60: "#500.00"
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
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
            Text("Balance",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 20

            ),
            ),
              Text("#1,065",
              style: TextStyle(
                color: tualeBlueDark,
                   fontFamily: 'Poppins',
                   fontWeight:FontWeight.bold,
                   fontSize: 30,
              ),
              ),
              SizedBox(height: 30,),
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
                            minimumSize: const Size(120, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text("Withdraw Funds",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                height: 1))),

            ],
          ),
        ),

       const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Transaction History",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
          ),
          ),
        ),
        Expanded(child: 
        
        ListView.builder(
          itemCount: price.length,
          itemBuilder: (BuildContext context, int index) {
            Map prices = price[index];

            return Container(
              decoration: BoxDecoration(

            border: Border(
                
              bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
            )
          ),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
             // color: Colors.black,
              height: 60,
              child: Row(
          
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text("Withdrawal from tuallet",
              style: TextStyle(
                fontSize: 17
              ),
              ),
           Spacer(flex: 5,),
                  Text("${prices.values.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => "")}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
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
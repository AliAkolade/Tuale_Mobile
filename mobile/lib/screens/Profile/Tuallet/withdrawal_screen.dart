import 'package:get/get.dart';
import 'package:mobile/screens/Profile/Tuallet/price_withdrawal_screen.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';

import 'package:mobile/screens/imports.dart';

class WithdrawalScreen extends StatefulWidget {
  String? withdrawalBalance;

  WithdrawalScreen({this.withdrawalBalance});
  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  List price = [
    {6: "500.00"},
    {12: "500.00"},
    {26: "500.00"},
    {60: "500.00"}
  ];

  @override
  Widget build(BuildContext context) {
     ProfileController profileController = Get.put(ProfileController());
  
    UserPostDetails userdetails = profileController.profileInfo.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  //  top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
          // color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Balance",
                style: TextStyle(
                    color: Colors.black, fontFamily: "Poppins", fontSize: 20),
              ),
           
               
                   Text(
                    nairaSign + userdetails.withdrawalBalance!,
                    style: TextStyle(
                      color: tualeBlueDark,
                      // fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                                 ),
                 
              
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: PriceWithdrawalScreen()));
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
                          fontSize: 18.sp,
                          //  fontWeight: FontWeight.bold,
                          height: 1))),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Transaction History",
            style: TextStyle(
                color: Colors.grey, fontSize: 18.sp, fontFamily: 'Poppins'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: price.length,
            itemBuilder: (BuildContext context, int index) {
              Map prices = price[index];

              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.3)))),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                // color: Colors.black,
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Withdrawal from tuallet",
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          fontFamily: 'Poppins',
                          color: Colors.black.withOpacity(0.8)),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Text(
                      nairaSign +
                          "${prices.values.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => "")}",
                      style: TextStyle(
                        color: Colors.black87.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        // fontFamily: 'Poppins'
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
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

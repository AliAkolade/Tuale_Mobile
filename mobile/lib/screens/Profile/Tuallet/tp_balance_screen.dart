import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:mobile/screens/Profile/controllers/paymentRequirementsController.dart';
import 'package:mobile/screens/Profile/controllers/profileController.dart';

import 'package:mobile/screens/imports.dart';

class TpBalanceScreen extends StatefulWidget {


  @override
  _TpBalanceScreenState createState() => _TpBalanceScreenState();
}

class _TpBalanceScreenState extends State<TpBalanceScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  List price = [
    {100: "1000"},
    {300: "3000"},
    {1000: "10000"},
    {4000: "40000"}
  ];
  var publicKey = 'pk_test_77d5e7bc4e812411caf295fe4affe301dfecdff2';
  final plugin = PaystackPlugin();

  _chargeCard(
    String email,
    String accessCode,
    int amount,
    String reference,
  ) async {
    var charge = Charge()
      ..amount = amount *
          100 //the money should be in kobo hence the need to multiply the value by 100

      ..accessCode = accessCode
      ..email = email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.selectable,
      charge: charge,
    );
    if (response.status == true) {
      print(response);
      // final apiref = Provider.of<Api>(context, listen: false);
      Api().verifyTransaction(reference).then((value) =>  profileController.getProfileInfo(currentUsername) );
     

      //you can send some data from the response to an API or use webhook to record the payment on a database
      // print("Payment successful");
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      print('Payment Failed!!!');
    }
  }

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    PaymentReqController paymentReq = Get.put(PaymentReqController());

   
     //profileController.isLoading.value
    //     ? Container():
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.3)))),
                // color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tuallet Points",
                        style: TextStyle(
                            color: tualeBlueDark,
                            fontFamily: "Poppins",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            TualeIcons.tualeactive,
                            size: 55,
                            color: Color.fromRGBO(244, 211, 94, 1),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                         
                             Obx(() => 
                                Text(
                                profileController.profileInfo.value.tcBalance!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                ),
                                                         ),
                             ),
                        
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Buy Tuale Points",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 21.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                            padding:
                                EdgeInsets.only(left: 0, right: 0, bottom: 10),
                            child: const Icon(
                              TualeIcons.tualeactive,
                              size: 30,
                              color: Color.fromRGBO(244, 211, 94, 1),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            "${prices.keys.toString().replaceAllMapped("(", (match) => '').replaceAllMapped(")", (match) => "")} Tuale Points",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.normal,
                              fontSize: 19.sp,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Center(
                            child: 
                               ElevatedButton(
                                  onPressed: () {
                                    paymentReq
                                        .getAccessCode(prices.values
                                            .toString()
                                            .replaceAllMapped("(", (match) => '')
                                            .replaceAllMapped(")", (match) => ""))
                                        .then((value) => _chargeCard(
                                            profileController.profileInfo.value.email!,
                                            value[0]!,
                                            int.parse(prices.values.elementAt(0)),
                                            value[1]!));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: tualeBlueDark,
                                      minimumSize: const Size(100, 35),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                      nairaSign +
                                          prices.values
                                              .toString()
                                              .replaceAllMapped(
                                                  "(", (match) => '')
                                              .replaceAllMapped(
                                                  ")", (match) => "") +
                                          ".00",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          // fontFamily: 'Poppins',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1))),
                            
                          ),
                          Spacer(
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

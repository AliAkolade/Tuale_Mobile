import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:mobile/screens/Profile/profile_screen.dart';
import 'package:mobile/screens/imports.dart';

final Api api = Api();
String? text = '0';

class PriceWithdrawalScreen extends StatefulWidget {
  const PriceWithdrawalScreen({Key? key}) : super(key: key);

  @override
  _PriceWithdrawalScreenState createState() => _PriceWithdrawalScreenState();
}

class _PriceWithdrawalScreenState extends State<PriceWithdrawalScreen> {
  int? amount;
  List bank = ['name', 'age'];
  List price = [
    {6: "500.00"},
    {12: "500.00"},
    {26: "500.00"},
    {60: "500.00"}
  ];

  _onKeyboardTap(String value) {
    setState(() {
      text = text! + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      content: Text('Cant withdraw less than #500'),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(border: Border()),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Wrap(
                      children: [
                        Text(
                          nairaSign,
                          style: TextStyle(
                            color: tualeBlueDark,
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          text!,
                          style: TextStyle(
                            color: tualeBlueDark,
                            // fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              height: 300,
              width: 400,
              child: NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: tualeBlueDark,
                  rightButtonFn: () {
                    setState(() {
                      if (text == '') {
                      } else if (text != '0') {
                        text = text!.substring(0, text!.length - 1);
                      } else if (text == '0') {
                        text = text!.substring(0, text!.length - 1);
                      }
                    });
                  },
                  rightIcon: Icon(
                    Icons.backspace_rounded,
                    color: tualeBlueDark,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ]),
            ),
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ElevatedButton(
                  onPressed: () {
                    if (text == '' || int.parse(text!) < 500) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Loader.show(context,
                          isSafeAreaOverlay: false,
                          isAppbarOverlay: true,
                          isBottomBarOverlay: false,
                          progressIndicator: SpinKitFadingCircle(
                              color: tualeOrange.withOpacity(0.75)),
                          themeData: Theme.of(context)
                              .copyWith(accentColor: Colors.black38),
                          overlayColor: const Color(0x99E8EAF6));
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectBankDialog();
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: tualeBlueDark,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Withdraw",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          // fontFamily: 'Poppins',
                          fontSize: 16.5,
                          //  fontWeight: FontWeight.bold,
                          height: 1))),
            ),
            SizedBox(
              height: 40.h,
            )
          ],
        ),
      ),
    );
  }
}

class SelectBankDialog extends StatefulWidget {
  const SelectBankDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectBankDialog> createState() => _SelectBankDialogState();
}

class _SelectBankDialogState extends State<SelectBankDialog> {
  var res;

  @override
  void initState() {
    loadUserBankAccount();
    super.initState();
  }

  loadUserBankAccount() async {
    res = await api.getWithdraw();
    setState(() {
      res = res;
    });
    print("Fabio : $res");
    if (res != null) {
      Loader.hide();
      print("Fabio_account : ${res["account_number"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> bank = ['name', 'trey'];
    String _verticalGroupValue = 'namee';

    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Container(
            // width: 200,
            height: 250,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    barText: "Withdraw To?",
                  ),
                  res != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AddBankDialog();
                                    //     });
                                  },
                                  child: Text(
                                    res["account_number"].toString() +
                                        '-${res['bank_name']}',
                                    style: TextStyle(
                                      color: tualeBlueDark,
                                      fontFamily: 'Poppins',
                                      fontSize: 19.sp,
                                    ),
                                  )),
                              // SizedBox(width: 55),
                              Icon(
                                Icons.radio_button_checked_rounded,
                                color: Colors.grey,
                                size: 27.sp,
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddBankDialog();
                                        });
                                  },
                                  child: Text(
                                    'Add Account',
                                    style: TextStyle(
                                      color: tualeBlueDark,
                                      fontFamily: 'Poppins',
                                      fontSize: 19.sp,
                                    ),
                                  )),
                              Icon(
                                Icons.add_circle_outline_outlined,
                                color: Colors.grey,
                                size: 27.sp,
                              )
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  // const Padding(
                  //   padding: const EdgeInsets.only(left: 10),
                  //   child: Text(
                  //     "Enter the code sent to your numberl",
                  //     style:
                  //         TextStyle(fontFamily: "Poppins", color: tualeBlueDark),
                  //   ),
                  // ),
                  // BioField(
                  //   infoString: "Account Number",
                  //   fieldHeight: 50,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 22, top: 20, right: 22),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('Bank'),
                  //       TextDropdownFormField(
                  //         options: ["GTbank", "FCMB"],
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           suffixIcon: Icon(Icons.arrow_drop_down),
                  //           // labelText: "Gender"
                  //         ),
                  //         dropdownHeight: 120,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // BioField(
                  //   infoString: "Account Name",
                  //   fieldHeight: 50,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () async {
                      Loader.show(context,
                          isSafeAreaOverlay: false,
                          isAppbarOverlay: true,
                          isBottomBarOverlay: false,
                          progressIndicator: SpinKitFadingCircle(
                              color: tualeOrange.withOpacity(0.75)),
                          themeData: Theme.of(context)
                              .copyWith(accentColor: Colors.black38),
                          overlayColor: const Color(0x99E8EAF6));
                      print("amount : $text");
                      var res = await api.withdraw(double.parse(text!));
                      print("res : $res");
                      if (res[0]) {
                        Loader.hide();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessfullDialog(
                                  message: res[1], success: true);
                            });
                      } else {
                        Loader.hide();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessfullDialog(
                                  message: res[1], success: false);
                            });
                      }

                      /*showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return VerifyNumberDialog();
                          });*/
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(130, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Proceed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                  ))
                ]),
          ),
        ),
      );
    });
  }
}

class AddBankDialog extends StatefulWidget {
  const AddBankDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBankDialog> createState() => _AddBankDialogState();
}

class _AddBankDialogState extends State<AddBankDialog> {
  List bankListRes = [];
  List<String> bankListName = [];
  List bankListCode = [];
  String bankCode = "";
  TextEditingController userAccountName = TextEditingController();
  TextEditingController accountNbr = TextEditingController();

  @override
  void initState() {
    getListOfBanks();
    super.initState();
  }

  getListOfBanks() async {
    bankListRes = await api.getListOfBank();
    print("Fabio : $bankListRes");
    if (bankListRes.isNotEmpty) {
      for (var i = 0; i < bankListRes.length; i++) {
        bankListName.add(bankListRes[i]["name"]);
        bankListCode.add(bankListRes[i]["code"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: const EdgeInsets.only(left: 30, right: 30),
        content: SingleChildScrollView(
          child: Container(
            // width: 200,
            height: 470,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    barText: "Withdraw To?",
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Enter Bank Details",
                      style: TextStyle(
                          fontFamily: "Poppins", color: tualeBlueDark),
                    ),
                  ),
                  BioField(
                    infoString: "Account Number",
                    fieldHeight: 50,
                    txtController: accountNbr,
                    onChanged: (text) async {
                      print("text : $text");
                      if (accountNbr.text.isNotEmpty && bankCode != "") {
                        userAccountName.text = await api.checkAccountNumber(
                            accountNbr.text.trim(), bankCode);
                        print("Account Name : " + userAccountName.text);

                        /// TODO : Dili please add new params
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessfullDialog(
                                message: userAccountName.text,
                              );
                            });
                        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Account Name : "+res),
                          ));*/
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22, top: 20, right: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bank'),
                        TextDropdownFormField(
                          options: bankListName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            // labelText: "Gender"
                          ),
                          dropdownHeight: 120,
                          onChanged: (dynamic text) async {
                            if (text.isNotEmpty) {
                              print("bankListName : $text");
                              print(
                                  "bankListName : ${bankListName.indexOf(text)}");
                              //bankCode = bankListCode[bankListName.indexOf(text)];
                              setState(() {
                                bankCode =
                                    bankListCode[bankListName.indexOf(text)];
                              });
                              print("bankCode : $bankCode");
                              print("accountNbr : ${accountNbr.text}");
                              if (accountNbr.text != "" && bankCode != "") {
                                userAccountName.text =
                                    await api.checkAccountNumber(
                                        accountNbr.text.trim(), bankCode);
                                print("Account Name : " + userAccountName.text);

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SuccessfullDialog(
                                        message: userAccountName.text,
                                      );
                                    });
                                /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Account Name : "+res),
                                  ));*/
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /*BioField(
                      infoString: "Account Name",
                      fieldHeight: 50,
                      txtController: userAccountName,
                    ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () async {
                      var res = await api.createWithdrawalAccount(
                          userAccountName.text, accountNbr.text, bankCode);
                      if (res[0]) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessfullDialog(
                                message: res[1],
                                success: true,
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessfullDialog(
                                  success: false, message: res[1]);
                            });
                      }
                      /**/
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(130, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                  ))
                ]),
          ),
        ),
      );
    });
  }
}

class SuccessfullDialog extends StatelessWidget {
  String? message;
  bool? success;
  SuccessfullDialog({this.message, this.success});

  @override
  Widget build(BuildContext context) {
    print(success);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.only(left: 30, right: 30),
      child: SingleChildScrollView(
        child: Container(
          // width: 200,
          height: 300,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  success!
                      ? Icons.check_circle_outlined
                      : Icons.cancel_outlined,
                  size: 90,
                  color: tualeOrange,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    //BETTER WATCH OUT
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(130, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1)),
                ))
              ]),
        ),
      ),
    );
  }
}

// class VerifyNumberDialog extends StatelessWidget {
//   const VerifyNumberDialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       insetPadding: const EdgeInsets.only(left: 30, right: 30),
//       child: Container(
//         // width: 200,
//         height: 250,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TopBar(
//                 barText: "Verify your account",
//               ),
//               const Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Enter the code sent to your numberl",
//                   style: TextStyle(fontFamily: "Poppins", color: tualeBlueDark),
//                 ),
//               ),
//               BioField(
//                 infoString: "One Time Password",
//                 fieldHeight: 50,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                   child: ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return SuccessfullDialog(
//                           message: "Withdrawn Successfully",
//                         );
//                       });
//                 },
//                 style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(130, 45),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: const Text('Submit',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         fontFamily: 'Poppins',
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         height: 1)),
//               ))
//             ]),
//       ),
//     );
//   }
// }

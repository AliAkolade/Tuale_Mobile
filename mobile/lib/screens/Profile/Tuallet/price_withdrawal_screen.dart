import 'package:mobile/screens/Profile/profile_screen.dart';
import 'package:mobile/screens/imports.dart';

class PriceWithdrawalScreen extends StatefulWidget {
  const PriceWithdrawalScreen({Key? key}) : super(key: key);

  @override
  _PriceWithdrawalScreenState createState() => _PriceWithdrawalScreenState();
}

class _PriceWithdrawalScreenState extends State<PriceWithdrawalScreen> {
  String? text = '';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
         leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_rounded,
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
              decoration: BoxDecoration(

                border: Border()),
            
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
                      if (text != '') {
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
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            insetPadding:
                                const EdgeInsets.only(left: 30, right: 30),
                            child: Container(
                              // width: 200,
                              height: 250,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TopBar(
                                      barText: "Email Verification",
                                    ),
                                    const Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Enter the code sent to your email",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: tualeBlueDark),
                                      ),
                                    ),
                                    BioField(
                                      infoString: "Email verification code",
                                      fieldHeight: 50,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(130, 45),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text('Submit',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Poppins',
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              height: 1)),
                                    ))
                                  ]),
                            ),
                          );
                        });
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
          ],
        ),
      ),
    );
  }
}

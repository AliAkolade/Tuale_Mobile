import 'package:mobile/screens/imports.dart';

class TualletHome extends StatefulWidget {
  String? tcBalance;
  String? withdrawalBalance;
  String? email;

  TualletHome({this.tcBalance, this.withdrawalBalance, this.email});

  @override
  _TualletHomeState createState() => _TualletHomeState();
}

class _TualletHomeState extends State<TualletHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          actions: const [
            Icon(
              Icons.more_vert_rounded,
              color: Colors.black,
            )
          ],
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            "Tuallet",
            style: TextStyle(
                color: tualeBlueDark,
                fontFamily: 'Poppins',
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                height: 1),
          ),
          bottom: const TabBar(
              unselectedLabelColor: tualeBlueDark,
              indicatorColor: tualeOrange,
              indicatorWeight: 1.1,
              labelColor: tualeOrange,
              labelStyle:
                  TextStyle(fontFamily: 'Poppins', fontSize: 15, height: 1),
              tabs: [Tab(text: "TP Balance"), Tab(text: "Withdrawal")]),
        ),
        body: TabBarView(children: [TpBalanceScreen(
          tcBalance: widget.tcBalance,
          email: widget.email
        ), WithdrawalScreen(
          withdrawalBalance: widget.withdrawalBalance
        )]),
      ),
    );
  }
}

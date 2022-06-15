import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezos/src/constants/color_const.dart';
import 'package:tezos/src/constants/path_const.dart';
import 'package:tezos/src/screens/wallet_screen.dart';

class HomeScreenHandler extends StatelessWidget {
  int index = 0;

  List<Widget> screens = [
    WalletScreen(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Container(
        height: 68,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: Color(0xff252525),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            navBarItemWidget(
              0,
              "Wallet",
              Icons.account_balance_wallet_outlined,
            ),
            navBarItemWidget(
              1,
              "Gallery",
              Icons.image,
            ),
            Spacer(),
            navBarItemWidget(
              2,
              "Favourites",
              Icons.star_border_outlined,
            ),
            navBarItemWidget(
              3,
              "Settins",
              Icons.settings,
            )
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 26,
        backgroundColor: Color(0xff252525),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: ColorConst.YELLOW_PRIMARY,
            onPressed: () {},
            child: SvgPicture.asset(PathConst.SVG + "sort_large.svg",
                fit: BoxFit.fitHeight),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  SizedBox navBarItemWidget(int itemindex, String label, IconData icondata) {
    return SizedBox(
      width: 68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icondata,
                color: itemindex == index
                    ? ColorConst.YELLOW_PRIMARY
                    : Colors.white,
              ) // SvgPicture.asset(PathConst.SVG + "scan.svg"),
              ),
          Text(
            label,
            style: TextStyle(
                color: itemindex == index
                    ? ColorConst.YELLOW_PRIMARY
                    : Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tezos/src/constants/color_const.dart';
import 'package:tezos/src/constants/dimension_const.dart';
import 'package:tezos/src/controllers/wallet_screen_controller.dart';

class SortBottomSheet extends StatefulWidget {
  sorting sortype;
  SortBottomSheet(this.sortype);

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int selectedindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedindex = widget.sortype == sorting.ascending ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DimensionConst.WIDTH,
      decoration: BoxDecoration(
        color: Color(0xff252525),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
                color: Color.fromRGBO(155, 155, 155, 1),
              )),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text(
                  'Sort By',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, widget.sortype);
                    },
                    child: Text(
                      'Done',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color.fromRGBO(247, 222, 0, 1),
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Column(
            children: [
              sortTypeWidget(0, 'Price : Lowest to high'),
              sortTypeWidget(1, 'Price : Highest to low'),
            ],
          )
        ],
      ),
    );
  }

  Widget sortTypeWidget(int index, String label) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedindex = index;
          });
          widget.sortype =
              selectedindex == 0 ? sorting.ascending : sorting.descending;
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: DimensionConst.WIDTH,
          alignment: Alignment.centerLeft,
          color: selectedindex == index
              ? ColorConst.YELLOW_PRIMARY
              : Color(0xff252525),
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: selectedindex == index ? Colors.black : Colors.white,
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
      ),
    );
  }
}

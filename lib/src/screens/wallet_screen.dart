import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tezos/src/components/SortBottomSheet.dart';
import 'package:tezos/src/constants/dimension_const.dart';
import 'package:tezos/src/constants/path_const.dart';
import 'package:tezos/src/controllers/wallet_screen_controller.dart';
import 'dart:math' as math;

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Dismissing Items';

    return ChangeNotifierProvider<WalletScreenProvider>(
      create: (_) => WalletScreenProvider(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xff252525),
            body: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      bottom: 0,
                    ),
                    Column(
                      children: [
                        PortofolioCardWidget(),
                        cardsStack(context),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                    color: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'All Tokens',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            Spacer(),
                            sortButton(context)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: context
                                .watch<WalletScreenProvider>()
                                .portfolio
                                .length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Color(0xff616161),
                                height: 1,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return TokenChipWidget(context
                                  .watch<WalletScreenProvider>()
                                  .portfolio[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  SizedBox TokenChipWidget(CardModel item) {
    return SizedBox(
      height: 66,
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              child: Image(
                image: NetworkImage(item.imageLink ?? ""),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.tokenName ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Spacer(),
                Text(
                  item.tokenId ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(183, 183, 183, 1),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            height: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.tokenValue.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(247, 222, 0, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Spacer(),
                Text(
                  '\$' + item.tokenQuantity.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Material sortButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => Wrap(
              children: [
                SortBottomSheet(
                    context.watch<WalletScreenProvider>().currentSortingtype),
              ],
            ),
          ).then((value) {
            if (value != null) {
              context
                  .read<WalletScreenProvider>()
                  .sortCarditems(value as sorting);
            }
          });
        },
        child: Container(
          height: 26,
          width: 82,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Color.fromRGBO(247, 222, 0, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(PathConst.SVG + "sort_small.svg"),
              SizedBox(
                width: 4,
              ),
              Text(
                'Sort By',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container PortofolioCardWidget() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0),
              offset: Offset(6, 6),
              blurRadius: 12)
        ],
        color: const Color.fromRGBO(0, 0, 0, 1),
        border: Border.all(
          color: const Color.fromRGBO(183, 183, 183, 1),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portfolio Balance',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                    Spacer(),
                    Text(
                      '\$46.78',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(247, 222, 0, 1),
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  color: Color.fromRGBO(247, 222, 0, 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 12,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Image(
                                image: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/53181084?s=64&v=4"),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Jon Ben',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(37, 37, 37, 1),
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          SizedBox(width: 8),
                          SvgPicture.asset(PathConst.SVG + "down_arrow.svg",
                              semanticsLabel: 'vector'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    SvgPicture.asset(PathConst.SVG + "send.svg"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Send',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 24,
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    SvgPicture.asset(PathConst.SVG + "recieve.svg"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Recieve',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    SvgPicture.asset(PathConst.SVG + "scan.svg"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Scan',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cardsStack(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: context.watch<WalletScreenProvider>().carditems.isNotEmpty
            ? 112 + 9 + 9
            : 0,
        width: 327 + 9 + 9,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: context.watch<WalletScreenProvider>().carditems.isNotEmpty
            ? Stack(
                children: List.generate(
                context.watch<WalletScreenProvider>().carditems.length,
                (index) => Positioned(
                  bottom: index * 9,
                  left: index * 9,
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: Key(
                        context.watch<WalletScreenProvider>().carditems[index]),
                    onDismissed: (direction) {
                      context.read<WalletScreenProvider>().removeCardItem();
                    },
                    background: Container(color: Colors.transparent),
                    child: Container(
                        height: 112,
                        width: 327,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Color(0xffB8B8B8)),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/card${index + 1}.png")))),
                  ),
                ),
              ))
            : null,
      ),
    );
  }
}

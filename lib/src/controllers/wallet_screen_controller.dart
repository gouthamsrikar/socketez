import 'package:flutter/cupertino.dart';

class WalletScreenProvider with ChangeNotifier {
  List<CardModel> portfolio = [
    CardModel(
      imageLink: "https://s2.coinmarketcap.com/static/img/coins/64x64/2011.png",
      tokenId: "TZS",
      tokenName: "TEZOS",
      tokenQuantity: 2,
      tokenValue: 78,
    ),
    CardModel(
      imageLink: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png",
      tokenId: "BTS",
      tokenName: "BITCOIN",
      tokenQuantity: 28,
      tokenValue: 90,
    ),
    CardModel(
      imageLink: "https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png",
      tokenId: "ETH",
      tokenName: "ETHERIUM",
      tokenQuantity: 63,
      tokenValue: 670,
    ),
  ];

  List<String> carditems = ["1", "2", "3"];

  removeCardItem() {
    carditems.removeAt(0);
    notifyListeners();
  }

  reRender() {
    notifyListeners();
  }

  sorting currentSortingtype = sorting.ascending;

  sortCarditems(sorting ordertype) {
    if (ordertype == sorting.ascending) {
      portfolio.sort(
        (a, b) => Comparable.compare(a.tokenValue!, b.tokenValue!),
      );
      currentSortingtype = sorting.ascending;
      print("Ascend");
    } else {
      portfolio.sort(
        (a, b) => Comparable.compare(b.tokenValue!, a.tokenValue!),
      );
      currentSortingtype = sorting.descending;
      print("desend");

    }
    notifyListeners();
  }
}

enum sorting {
  ascending,
  descending,
}

class CardModel {
  String? tokenName;
  String? tokenId;
  double? tokenQuantity;
  double? tokenValue;
  String? imageLink;
  CardModel({
    this.imageLink,
    this.tokenId,
    this.tokenName,
    this.tokenQuantity,
    this.tokenValue,
  });
}

class HomeModel {
  late final bool status;
  late final DataOfHome data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataOfHome.fromJson(json['data']);
  }
}

class DataOfHome {
  late final List<Banners> banners;
  late final List<Products> products;
  late final String ad;

  DataOfHome.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    ad = json['ad'];
  }
}

class Banners {
  late final num id;
  late final String image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  late final int id;
  late final num price;
  late final num oldPrice;
  late final num discount;
  late final String image;
  late final String name;
  late final String description;
  late final List<String> images;
  late final bool inFavorites;
  late final bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = List.castFrom<dynamic, String>(json['images']);
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

/*class HomeModel
{
  late final bool status;
  late final String message;

  late final Data data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json["status"];
    message = json["message"];

    data = json["data"];


  }

}

class Data
{

  late final List<Banners> banners = [];
  late final List<Products> products= [];

  late final String ad;


  Data.fromJson(Map<String ,dynamic>json)
  {

    json["banners"].forEach((element)
    {
      banners.add(Banners.fomJson(element));
    }
    );

    json["products"].forEach((element)
    {
      products.add(Products.fromJson(element));
    }
    );

    ad = json["ad"];
  }

}

class Banners
{
  late final int id;
  late final String image;

  Banners.fomJson(Map<String, dynamic> json)
  {
    id = json["id"];
    image = json["image"];
  }
}

class Products
{
  late final int id;
  late final int price;
  late final int oldPrice;
  late final String image;
  late final bool inCart;
  late final bool inFavorites;

  Products.fromJson(Map<String, dynamic> json)
  {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    image = json["image"];
    inCart = json["in_cart"];
    inFavorites = json["in_favorites"];
  }

}*/

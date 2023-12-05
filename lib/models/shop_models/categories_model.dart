class CategoriesModel {
  late final bool status;
  late final DataOfCategories data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataOfCategories.fromJson(json['data']);
  }
}

class DataOfCategories {
  late final int currentPage;
  late final List<OneCategoryData> dataOfAllCategories;


  DataOfCategories.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    dataOfAllCategories = List.from(json['data'])
        .map((e) => OneCategoryData.fromJson(e))
        .toList();
 }
}

class OneCategoryData {
  late final int id;
  late final String name;
  late final String image;

  OneCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

import 'package:mobx/mobx.dart';
import 'package:onestop_dev/models/restaurant_model.dart';

part 'restaurant_store.g.dart';

class RestaurantStore = _RestaurantStore with _$RestaurantStore;

abstract class _RestaurantStore with Store {
  @observable
  RestaurantModel _selectedRestaurant = RestaurantModel(
      name: "NA",
      caption: "NA",
      closing_time: "NA",
      waiting_time: "NA",
      phone_number: "NA",
      latitude: 0,
      longitude: 0,
      tags: []);

  @observable
  String _searchString = "";

  @observable
  String _searchPageHeader =
      ""; // Use this only when user clicks on Your Favourite Dishes

  RestaurantModel get getSelectedRestaurant => _selectedRestaurant;
  String get getSearchString => _searchString;
  String get getSearchHeader => _searchPageHeader;

  @action
  void setSelectedRestaurant(RestaurantModel r) {
    _selectedRestaurant = r;
  }

  @action
  void setSearchString(String str) {
    print("Search String set to $str");
    _searchString = str;
  }

  @action
  void setSearchHeader(String str) {
    _searchPageHeader = str;
  }
}
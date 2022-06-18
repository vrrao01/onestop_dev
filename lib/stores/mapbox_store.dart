import 'package:mobx/mobx.dart';
part 'mapbox_store.g.dart';

class MapBoxStore = _MapBoxStore with _$MapBoxStore;

abstract class _MapBoxStore with Store {
  @observable
  int index = 0;
  double userlat=0;
  double userlong=0;
  int selectedCarouselIndex=-1;
  bool isTravelPage=false;

  @action
  void setIndexMapBox(int i) {
    index = i;
  }

  @action
  void setUserLatLng(double lat,double long){
    userlat=lat;
    userlong=long;
  }
  @action
  void selectedCarousel(int i){
    selectedCarouselIndex= i;
  }
  @action
  void checkTravelPage(bool i){
    isTravelPage=i ;
  }


}

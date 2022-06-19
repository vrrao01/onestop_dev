// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapBoxStore on _MapBoxStore, Store {
  Computed<List<Widget>>? _$buses_carouselComputed;

  @override
  List<Widget> get buses_carousel => (_$buses_carouselComputed ??=
          Computed<List<Widget>>(() => super.buses_carousel,
              name: '_MapBoxStore.buses_carousel'))
      .value;
  Computed<List<CameraPosition>>? _$bus_camera_positionsComputed;

  @override
  List<CameraPosition> get bus_camera_positions =>
      (_$bus_camera_positionsComputed ??= Computed<List<CameraPosition>>(
              () => super.bus_camera_positions,
              name: '_MapBoxStore.bus_camera_positions'))
          .value;

  late final _$indexAtom = Atom(name: '_MapBoxStore.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$_MapBoxStoreActionController =
      ActionController(name: '_MapBoxStore', context: context);

  @override
  void setIndexMapBox(int i) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.setIndexMapBox');
    try {
      return super.setIndexMapBox(i);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserLatLng(double lat, double long) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.setUserLatLng');
    try {
      return super.setUserLatLng(lat, long);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedCarousel(int i) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.selectedCarousel');
    try {
      return super.selectedCarousel(i);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkTravelPage(bool i) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.checkTravelPage');
    try {
      return super.checkTravelPage(i);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void set_distance_buses(int i, int distance) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.set_distance_buses');
    try {
      return super.set_distance_buses(i, distance);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void set_duration_buses(int i, int time) {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.set_duration_buses');
    try {
      return super.set_duration_buses(i, time);
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialiseCarouselforBuses() {
    final _$actionInfo = _$_MapBoxStoreActionController.startAction(
        name: '_MapBoxStore.initialiseCarouselforBuses');
    try {
      return super.initialiseCarouselforBuses();
    } finally {
      _$_MapBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
index: ${index},
buses_carousel: ${buses_carousel},
bus_camera_positions: ${bus_camera_positions}
    ''';
  }
}

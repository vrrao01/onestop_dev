// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapBoxStore on _MapBoxStore, Store {
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
  String toString() {
    return '''
index: ${index}
    ''';
  }
}

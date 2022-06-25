// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimetableStore on _TimetableStore, Store {
  Computed<bool>? _$coursesLoadedComputed;

  @override
  bool get coursesLoaded =>
      (_$coursesLoadedComputed ??= Computed<bool>(() => super.coursesLoaded,
              name: '_TimetableStore.coursesLoaded'))
          .value;
  Computed<bool>? _$coursesLoadingComputed;

  @override
  bool get coursesLoading =>
      (_$coursesLoadingComputed ??= Computed<bool>(() => super.coursesLoading,
              name: '_TimetableStore.coursesLoading'))
          .value;
  Computed<bool>? _$coursesErrorComputed;

  @override
  bool get coursesError =>
      (_$coursesErrorComputed ??= Computed<bool>(() => super.coursesError,
              name: '_TimetableStore.coursesError'))
          .value;
  Computed<List<Widget>>? _$todayTimeTableComputed;

  @override
  List<Widget> get todayTimeTable => (_$todayTimeTableComputed ??=
          Computed<List<Widget>>(() => super.todayTimeTable,
              name: '_TimetableStore.todayTimeTable'))
      .value;
  Computed<CourseModel>? _$selectedCourseforHomeComputed;

  @override
  CourseModel get selectedCourseforHome => (_$selectedCourseforHomeComputed ??=
          Computed<CourseModel>(() => super.selectedCourseforHome,
              name: '_TimetableStore.selectedCourseforHome'))
      .value;
  Computed<List<Widget>>? _$todayTimeTableMorningComputed;

  @override
  List<Widget> get todayTimeTableMorning => (_$todayTimeTableMorningComputed ??=
          Computed<List<Widget>>(() => super.todayTimeTableMorning,
              name: '_TimetableStore.todayTimeTableMorning'))
      .value;
  Computed<List<Widget>>? _$todayTimeTableAfternoonComputed;

  @override
  List<Widget> get todayTimeTableAfternoon =>
      (_$todayTimeTableAfternoonComputed ??= Computed<List<Widget>>(
              () => super.todayTimeTableAfternoon,
              name: '_TimetableStore.todayTimeTableAfternoon'))
          .value;

  late final _$loadOperationAtom =
      Atom(name: '_TimetableStore.loadOperation', context: context);

  @override
  ObservableFuture<RegisteredCourses?> get loadOperation {
    _$loadOperationAtom.reportRead();
    return super.loadOperation;
  }

  @override
  set loadOperation(ObservableFuture<RegisteredCourses?> value) {
    _$loadOperationAtom.reportWrite(value, super.loadOperation, () {
      super.loadOperation = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_TimetableStore.selectedDate', context: context);

  @override
  int get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(int value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$isHomePageAtom =
      Atom(name: '_TimetableStore.isHomePage', context: context);

  @override
  bool get isHomePage {
    _$isHomePageAtom.reportRead();
    return super.isHomePage;
  }

  @override
  set isHomePage(bool value) {
    _$isHomePageAtom.reportWrite(value, super.isHomePage, () {
      super.isHomePage = value;
    });
  }

  late final _$setTimetableAsyncAction =
      AsyncAction('_TimetableStore.setTimetable', context: context);

  @override
  Future<void> setTimetable(String rollNumber) {
    return _$setTimetableAsyncAction.run(() => super.setTimetable(rollNumber));
  }

  late final _$_TimetableStoreActionController =
      ActionController(name: '_TimetableStore', context: context);

  @override
  void setDate(int i) {
    final _$actionInfo = _$_TimetableStoreActionController.startAction(
        name: '_TimetableStore.setDate');
    try {
      return super.setDate(i);
    } finally {
      _$_TimetableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void processTimetable() {
    final _$actionInfo = _$_TimetableStoreActionController.startAction(
        name: '_TimetableStore.processTimetable');
    try {
      return super.processTimetable();
    } finally {
      _$_TimetableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePage(bool i) {
    final _$actionInfo = _$_TimetableStoreActionController.startAction(
        name: '_TimetableStore.changePage');
    try {
      return super.changePage(i);
    } finally {
      _$_TimetableStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadOperation: ${loadOperation},
selectedDate: ${selectedDate},
isHomePage: ${isHomePage},
coursesLoaded: ${coursesLoaded},
coursesLoading: ${coursesLoading},
coursesError: ${coursesError},
todayTimeTable: ${todayTimeTable},
selectedCourseforHome: ${selectedCourseforHome},
todayTimeTableMorning: ${todayTimeTableMorning},
todayTimeTableAfternoon: ${todayTimeTableAfternoon}
    ''';
  }
}

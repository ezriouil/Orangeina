part of 'index_cubit.dart';

@immutable
sealed class IndexState {}

 final class IndexMainState extends IndexState {
  final int? currentPageIndex;
  IndexMainState({ this.currentPageIndex = 0 });

  IndexMainState copyWith({final int? currentPageIndex}) {
    return IndexMainState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

final class IndexLocationPermissionState extends IndexState {}
final class IndexPhotosPermissionState extends IndexState {}
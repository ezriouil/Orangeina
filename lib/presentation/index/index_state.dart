part of 'index_cubit.dart';

@immutable
sealed class IndexState {}

 final class IndexCurrentState extends IndexState {
  final int? currentPageIndex;
  IndexCurrentState({ this.currentPageIndex = 0 });

  IndexCurrentState copyWith({final int? currentPageIndex}) {
    return IndexCurrentState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

final class IndexPermissionState extends IndexState {}
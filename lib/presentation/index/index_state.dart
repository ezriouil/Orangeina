part of 'index_cubit.dart';

@immutable
sealed class IndexState {}

 class IndexCurrentState extends IndexState {
  final int? currentPageIndex;
  IndexCurrentState({ this.currentPageIndex });

  IndexCurrentState copyWith({
    final int? currentPageIndex
  }) {
    return IndexCurrentState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}
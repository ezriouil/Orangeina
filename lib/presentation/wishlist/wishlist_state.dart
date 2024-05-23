part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistMainState extends WishlistState {
  final List<WishListEntity>? wishLists;

  WishlistMainState({ this.wishLists });

  WishlistMainState copyWith({ List<WishListEntity>? wishLists}) => WishlistMainState(wishLists: wishLists ?? this.wishLists);
}

final class WishlistLoadingState extends WishlistState {}

final class WishlistErrorState extends WishlistState {}

final class WishListEmptyState extends WishlistState {}

part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistCurrentState extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistErrorState extends WishlistState {
  final String message;
  WishlistErrorState({required this.message});
}

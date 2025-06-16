part of 'favorities_bloc.dart';

@immutable
sealed class FavoritiesEvent {}

final class TriggerAddToFavoritiesEvent extends FavoritiesEvent {
  final MovieEntityModel movie;

  TriggerAddToFavoritiesEvent(this.movie);
}

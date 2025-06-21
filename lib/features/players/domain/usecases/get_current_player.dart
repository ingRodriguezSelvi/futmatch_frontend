import '../entities/player.dart';
import '../repositories/players_repository.dart';

class GetCurrentPlayer {
  final PlayersRepository repository;
  GetCurrentPlayer(this.repository);

  Future<Player> call() => repository.getCurrentPlayer();
}

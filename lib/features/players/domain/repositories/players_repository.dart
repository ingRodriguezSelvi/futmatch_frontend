import '../entities/player.dart';

abstract class PlayersRepository {
  Future<Player> getCurrentPlayer();
}

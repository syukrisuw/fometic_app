class PlayerModel {
  int playerNumber;
  String playerName;
  String playerPosition;
  String playerStatus;

  PlayerModel(
      {required this.playerNumber,
      required this.playerName,
      this.playerPosition = "",
      this.playerStatus = "Playing"});


  @override
  String toString() {
    return "${this.playerNumber},${this.playerName},${this.playerPosition},${this.playerStatus}";
    }

}

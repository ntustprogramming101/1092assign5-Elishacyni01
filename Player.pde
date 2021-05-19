class Player{
  // Properties
  float playerX, playerY;
  int playerCol, playerRow;
  final float PLAYER_INIT_X = 4 * SOIL_SIZE;
  final float PLAYER_INIT_Y = - SOIL_SIZE;
  boolean leftState = false;
  boolean rightState = false;
  boolean downState = false;
  int playerHealth = 2;
  final int PLAYER_MAX_HEALTH = 5;
  int playerMoveDirection = 0;
  int playerMoveTimer = 0;
  int playerMoveDuration = 15;
  
  
  // Methods
  void initPlayer(){
    playerX = PLAYER_INIT_X;
    playerY = PLAYER_INIT_Y;
    playerCol = (int) playerX / SOIL_SIZE;
    playerRow = (int) playerY / SOIL_SIZE;
    playerMoveTimer = 0;
    playerHealth = 2;
  }
  // constructor
}

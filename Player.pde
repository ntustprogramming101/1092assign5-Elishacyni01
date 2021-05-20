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
  // Init Player
  void initPlayer(){
    playerX = PLAYER_INIT_X;
    playerY = PLAYER_INIT_Y;
    playerCol = (int) playerX / SOIL_SIZE;
    playerRow = (int) playerY / SOIL_SIZE;
    playerMoveTimer = 0;
    playerHealth = 2;
  }
  
  PImage groundhogDisplay = groundhogIdle;

    // If player is not moving, we have to decide what player has to do next
    if(playerMoveTimer == 0){

      if((playerRow + 1 < SOIL_ROW_COUNT && soilHealth[playerCol][playerRow + 1] == 0) || playerRow + 1 >= SOIL_ROW_COUNT){

        groundhogDisplay = groundhogDown;
        playerMoveDirection = DOWN;
        playerMoveTimer = playerMoveDuration;

      }else{

        if(leftState){

          groundhogDisplay = groundhogLeft;

          // Check left boundary
          if(playerCol > 0){

            if(playerRow >= 0 && soilHealth[playerCol - 1][playerRow] > 0){
              soilHealth[playerCol - 1][playerRow] --;
            }else{
              playerMoveDirection = LEFT;
              playerMoveTimer = playerMoveDuration;
            }

          }

        }else if(rightState){

          groundhogDisplay = groundhogRight;

          // Check right boundary
          if(playerCol < SOIL_COL_COUNT - 1){

            if(playerRow >= 0 && soilHealth[playerCol + 1][playerRow] > 0){
              soilHealth[playerCol + 1][playerRow] --;
            }else{
              playerMoveDirection = RIGHT;
              playerMoveTimer = playerMoveDuration;
            }

          }

        }else if(downState){

          groundhogDisplay = groundhogDown;

          // Check bottom boundary
          if(playerRow < SOIL_ROW_COUNT - 1){

            soilHealth[playerCol][playerRow + 1] --;

          }
        }
      }

    }else{
      // Draw image before moving to prevent offset
      switch(playerMoveDirection){
        case LEFT:  groundhogDisplay = groundhogLeft;  break;
        case RIGHT:  groundhogDisplay = groundhogRight;  break;
        case DOWN:  groundhogDisplay = groundhogDown;  break;
      }
    }

    image(groundhogDisplay, playerX, playerY);

    // If player is now moving?

    if(playerMoveTimer > 0){

      playerMoveTimer --;
      switch(playerMoveDirection){

        case LEFT:
        if(playerMoveTimer == 0){
          playerCol--;
          playerX = SOIL_SIZE * playerCol;
        }else{
          playerX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SOIL_SIZE;
        }
        break;

        case RIGHT:
        if(playerMoveTimer == 0){
          playerCol++;
          playerX = SOIL_SIZE * playerCol;
        }else{
          playerX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SOIL_SIZE;
        }
        break;

        case DOWN:
        if(playerMoveTimer == 0){
          playerRow++;
          playerY = SOIL_SIZE * playerRow;
          if(playerRow >= SOIL_ROW_COUNT + 3) gameState = GAME_WIN;
        }else{
          playerY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SOIL_SIZE;
        }
        break;
      }

    }
  
  
  
  
  void keyPressed(){
    if(key==CODED){
      switch(keyCode){
        case LEFT:
        leftState = true;
        break;
        case RIGHT:
        rightState = true;
        break;
        case DOWN:
        downState = true;
        break;
      }
    }else{
      if(key=='t'){
        gameTimer -= 180;
      }
    }
  }
  
  void keyReleased(){
    if(key==CODED){
      switch(keyCode){
        case LEFT:
        leftState = false;
        break;
        case RIGHT:
        rightState = false;
        break;
        case DOWN:
        downState = false;
        break;
      }
    }
  }
  
  
  // constructor
}

PImage title, gameover, gamewin, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogLeft, groundhogRight, groundhogDown;
PImage bg, life, cabbageImg, soilEmpty, clock, caution, sweethome;
PImage soldierImg;
PImage[][] soils, stones;
PFont font;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2, GAME_WIN = 3;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int SOIL_COL_COUNT = 8;
final int SOIL_ROW_COUNT = 24;
final int SOIL_SIZE = 80;

final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;








boolean demoMode = false;

Soil soil;
Stone stone;
Player player;
Soldier soldiers;

void setup() {
	size(640, 480, P2D);
	frameRate(60);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	gamewin = loadImage("img/gamewin.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle = loadImage("img/groundhogIdle.png");
	groundhogLeft = loadImage("img/groundhogLeft.png");
	groundhogRight = loadImage("img/groundhogRight.png");
	groundhogDown = loadImage("img/groundhogDown.png");
	life = loadImage("img/life.png");
	soldierImg = loadImage("img/soldier.png");
	cabbageImg = loadImage("img/cabbage.png");
	clock = loadImage("img/clock.png");
	caution = loadImage("img/caution.png");
	sweethome = loadImage("img/sweethome.png");
	soilEmpty = loadImage("img/soils/soilEmpty.png");

	font = createFont("font/font.ttf", 56);
	textFont(font);

	// Load PImage[][] soils
	soil.load();

	// Load PImage[][] stones
	stone.load();
  


	initGame();
}

void initGame(){

	// Initialize gameTimer
	gameTimer = GAME_INIT_TIMER;

	// Initialize player
	player.initPlayer();

	// Initialize soilHealth
	soil.initSoils();

	// Initialize soidiers and their position
	soldiers.initSoldiers();

	// Initialize cabbages and their position
	initCabbages();

	// Requirement #2: Initialize clocks and their position

}









void initClocks(){
	// Requirement #1: Complete this method based on initCabbages()
	// - Remember to reroll if the randomized position has a cabbage on the same soil!
}

void draw() {

	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}

		break;

		case GAME_RUN: // In-Game
		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

	    // CAREFUL!
	    // Because of how this translate value is calculated, the Y value of the ground level is actually 0
		pushMatrix();
		translate(0, max(SOIL_SIZE * -22, SOIL_SIZE * 1 - playerY));

		// Ground

		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil
    soil.display();
		

		

		// Cabbages

		for(int i = 0; i < cabbageX.length; i++){

			image(cabbageImg, cabbageX[i], cabbageY[i]);

			// Requirement #3: Use boolean isHit(...) to detect collision
			if(playerHealth < PLAYER_MAX_HEALTH
			&& cabbageX[i] + SOIL_SIZE > playerX    // r1 right edge past r2 left
		    && cabbageX[i] < playerX + SOIL_SIZE    // r1 left edge past r2 right
		    && cabbageY[i] + SOIL_SIZE > playerY    // r1 top edge past r2 bottom
		    && cabbageY[i] < playerY + SOIL_SIZE) { // r1 bottom edge past r2 top

				playerHealth ++;
				cabbageX[i] = cabbageY[i] = -1000;

			}

		}

		// Requirement #1: Clocks
		// --- Requirement #3: Use boolean isHit(...) to detect clock <-> player collision

		// Groundhog

		

		// Soldiers

		for(int i = 0; i < soldierX.length; i++){

			soldierX[i] += soldierSpeed;
			if(soldierX[i] >= width) soldierX[i] = -SOIL_SIZE;

			image(soldierImg, soldierX[i], soldierY[i]);

			// Requirement #3: Use boolean isHit(...) to detect collision
			if(soldierX[i] + SOIL_SIZE > playerX    // r1 right edge past r2 left
		    && soldierX[i] < playerX + SOIL_SIZE    // r1 left edge past r2 right
		    && soldierY[i] + SOIL_SIZE > playerY    // r1 top edge past r2 bottom
		    && soldierY[i] < playerY + SOIL_SIZE) { // r1 bottom edge past r2 top

				playerHealth --;

				if(playerHealth == 0){

					gameState = GAME_OVER;

				}else{

					playerX = PLAYER_INIT_X;
					playerY = PLAYER_INIT_Y;
					playerCol = (int) playerX / SOIL_SIZE;
					playerRow = (int) playerY / SOIL_SIZE;
					soilHealth[playerCol][playerRow + 1] = 15;
					playerMoveTimer = 0;

				}

			}
		}

		// Requirement #6:
		//   Call drawCaution() to draw caution sign

		popMatrix();

		// Depth UI
		drawDepthUI();

		// Timer
		gameTimer --;
		if(gameTimer <= 0) gameState = GAME_OVER;

		// Time UI - Requirement #4
		drawTimerUI();

		// Health UI
		for(int i = 0; i < playerHealth; i++){
			image(life, 10 + i * 70, 10);
		}

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				initGame();
			}

		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_WIN: // Gameover Screen
		image(gamewin, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				initGame();
			}

		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}
}

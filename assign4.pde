PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogLeft, groundhogRight, groundhogDown;
PImage bg, life, cabbage, stone1, stone2, soilEmpty;
PImage soldier;
PImage soil0, soil1, soil2, soil3, soil4, soil5;
PImage[][] soils, stones;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int SOIL_COL_COUNT = 8;
final int SOIL_ROW_COUNT = 24;
final int SOIL_SIZE = 80;

int[][] soilHealth;

final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float[] cabbageX, cabbageY, soldierX, soldierY;
float soldierSpeed = 2f;

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

float stoneX=0,stoneY=0;
int STONE1COUNT=8;
float stoneSpacingX=640/STONE1COUNT;
float stoneSpacingY=640/STONE1COUNT;


boolean demoMode = false;

int soilEmptyX1=int(random(8))*SOIL_SIZE;
int soilEmptyX2=int(random(8))*SOIL_SIZE;
int soilEmptyX3=int(random(8))*SOIL_SIZE;
int soilEmptyX4=int(random(8))*SOIL_SIZE;
int soilEmptyX5=int(random(8))*SOIL_SIZE;
int soilEmptyX6=int(random(8))*SOIL_SIZE;
int soilEmptyX7=int(random(8))*SOIL_SIZE;
int soilEmptyX8=int(random(8))*SOIL_SIZE;
int soilEmptyX9=int(random(8))*SOIL_SIZE;
int soilEmptyX10=int(random(8))*SOIL_SIZE;
int soilEmptyX11=int(random(8))*SOIL_SIZE;
int soilEmptyX12=int(random(8))*SOIL_SIZE;
int soilEmptyX13=int(random(8))*SOIL_SIZE;
int soilEmptyX14=int(random(8))*SOIL_SIZE;
int soilEmptyX15=int(random(8))*SOIL_SIZE;
int soilEmptyX16=int(random(8))*SOIL_SIZE;
int soilEmptyX17=int(random(8))*SOIL_SIZE;
int soilEmptyX18=int(random(8))*SOIL_SIZE;
int soilEmptyX19=int(random(8))*SOIL_SIZE;
int soilEmptyX20=int(random(8))*SOIL_SIZE;
int soilEmptyX21=int(random(8))*SOIL_SIZE;
int soilEmptyX22=int(random(8))*SOIL_SIZE;
int soilEmptyX23=int(random(8))*SOIL_SIZE;

int soilEmptyY;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle = loadImage("img/groundhogIdle.png");
	groundhogLeft = loadImage("img/groundhogLeft.png");
	groundhogRight = loadImage("img/groundhogRight.png");
	groundhogDown = loadImage("img/groundhogDown.png");
	life = loadImage("img/life.png");
	soldier = loadImage("img/soldier.png");
	cabbage = loadImage("img/cabbage.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
	soilEmpty = loadImage("img/soils/soilEmpty.png");

	// Load soil images used in assign3 if you don't plan to finish requirement #6
	soil0 = loadImage("img/soil0.png");
	soil1 = loadImage("img/soil1.png");
	soil2 = loadImage("img/soil2.png");
	soil3 = loadImage("img/soil3.png");
	soil4 = loadImage("img/soil4.png");
	soil5 = loadImage("img/soil5.png");

	// Load PImage[][] soils
	soils = new PImage[6][5];
	for(int i = 0; i < soils.length; i++){
		for(int j = 0; j < soils[i].length; j++){
			soils[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".png");
		}
	}

	// Load PImage[][] stones
	stones = new PImage[2][5];
	for(int i = 0; i < stones.length; i++){
		for(int j = 0; j < stones[i].length; j++){
			stones[i][j] = loadImage("img/stones/stone" + i + "/stone" + i + "_" + j + ".png");
		}
	}

	// Initialize player
	playerX = PLAYER_INIT_X;
	playerY = PLAYER_INIT_Y;
	playerCol = (int) (playerX / SOIL_SIZE);
	playerRow = (int) (playerY / SOIL_SIZE);
	playerMoveTimer = 0;
	playerHealth = 2;

	// Initialize soilHealth
	soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
	for(int i = 0; i < soilHealth.length; i++){
		for (int j = 0; j < soilHealth[i].length; j++) {
			 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
			soilHealth[i][j] = 15;
      if(i==j){
      soilHealth[i][j] = 30;            
    }
    if(i==0 && j==10 || i==1 && j==11 ||i==2 && j==12 ||i==3 && j==13 ||i==4 && j==14 ||i==5 && j==15||
       i==2 && j==8 || i==3 && j==9 ||i==4 && j==10 ||i==5 && j==11 ||i==6 && j==12 ||i==7 && j==13 ||
       i==6 && j==8 || i==7 && j==9 ||i==0 && j==14 ||i==1 && j==15||
       i==6 && j==8 || i==7 && j==9 ||i==0 && j==14 ||i==1 && j==15||
       i==0 && j==9 || i==1 && j==8 ||i==7 && j==14 ||i==6 && j==15||
       i==5 && j==8 || i==4 && j==9 ||i==3 && j==10 ||i==2 && j==11 ||i==1 && j==12 ||i==0 && j==13||
       i==7 && j==10 || i==6 && j==11 ||i==5 && j==12 ||i==4 && j==13 || i==3 && j==14 ||i==2 && j==15||
       i==7 && j==10 || i==6 && j==11 ||i==5 && j==12 ||i==4 && j==13 || i==3 && j==14 ||i==2 && j==15){      
      soilHealth[i][j] = 30;
      }
      
      if(i==7 && j==10 || i==6 && j==11 ||i==5 && j==12 ||i==4 && j==13 || i==3 && j==14 ||i==2 && j==15){
      soilHealth[i][j] = 30;
      }    
      
      if(i==1 && j==16|| i==0 && j==17 ||
          i==4 &&j==16|| i==3 &&j==17||i==2 &&j==18||i==1 &&j==19||i==0 &&j==20||
          i==7 &&j==16|| i==6 &&j==17||i==5 &&j==18||i==4 &&j==19||i==3 &&j==20||i==2 &&j==21|| i==1 &&j==22||  i==0 &&j==23|| 
          i==7 &&j==19|| i==6 &&j==20||i==5 &&j==21||i==4 &&j==22||i==3 &&j==23||
          i==7 && j==22|| i==6 && j==23){
          soilHealth[i][j] = 30;
       }      
       
      if(i==2 && j==16|| i==1 && j==17 || i==0 &&j==18||
          i==5 &&j==16|| i==4 &&j==17||i==3 &&j==18||i==2 &&j==19||i==1 &&j==20||i==0 &&j==21||
          i==7 &&j==17|| i==6 &&j==18||i==5 &&j==19||i==4 &&j==20||i==3 &&j==21||i==2 &&j==22|| i==1 &&j==23|| 
          i==7 &&j==20|| i==6 &&j==21||i==5 &&j==22||i==4 &&j==23||i==7 &&j==23){
          soilHealth[i][j] = 45;
         }     
		    }
       }  

    }
     


     
      
	// Initialize soidiers and their position

	// Initialize cabbages and their position



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
		translate(0, max(SOIL_SIZE * -18, SOIL_SIZE * 1 - playerY));

		// Ground

		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil

		for(int i = 0; i < soilHealth.length; i++){
			for (int j = 0; j < soilHealth[i].length; j++) {

				// Change this part to show soil and stone images based on soilHealth value
				// NOTE: To avoid errors on webpage, you can either use floor(j / 4) or (int)(j / 4) to make sure it's an integer.
				int areaIndex = floor(j / 4);
				image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);

        
				
			}
		}

    

    // Stone
       //1to8
      float stone1to8X=0 ,stone1to8Y=0;    
      for(int i=0; i<STONE1COUNT; i++){
        stone1to8X=i*stoneSpacingX;
        image(stone1,stone1to8X,stone1to8Y);
        stone1to8Y += stoneSpacingY;
      }     
                   
       //9tp16       
      for(int y=0 ; y<STONE1COUNT*80 ; y+=320){
        for(int x=80 ; x<width+320; x+=320){
          image(stone1,x, y+640);
          image(stone1,x+80, y+640);
          image(stone1,x-160, y+720);
          image(stone1,x-80, y+720);
          image(stone1,x-160, y+800);
          image(stone1,x-80, y+800);
          image(stone1,x, y+880);
          image(stone1,x+80, y+880);
          }
       }
        //17to24
        for(int y=0 ; y<STONE1COUNT*80 ; y+=240){
        for(int x=80 ; x<width+320; x+=240){
          image(stone1,x, y+1280);
          image(stone1,x+80, y+1280);
          image(stone1,x, y+1360);
          image(stone1,x-80,y+1360);
          image(stone1,x-80, y+1440);
          image(stone1,x-160, y+1440);
          //stone2
          image(stone2,x+80, y+1280);
          image(stone2,x, y+1360);
          image(stone2,x-80, y+1440);
          }
       }
      

      image(soilEmpty,soilEmptyX1,SOIL_SIZE);
      image(soilEmpty,soilEmptyX2,SOIL_SIZE*2);
      image(soilEmpty,soilEmptyX3,SOIL_SIZE*3);
      image(soilEmpty,soilEmptyX4,SOIL_SIZE*4);
      image(soilEmpty,soilEmptyX5,SOIL_SIZE*5);
      image(soilEmpty,soilEmptyX6,SOIL_SIZE*6);
      image(soilEmpty,soilEmptyX7,SOIL_SIZE*7);
      image(soilEmpty,soilEmptyX8,SOIL_SIZE*8);
      image(soilEmpty,soilEmptyX9,SOIL_SIZE*9);
      image(soilEmpty,soilEmptyX10,SOIL_SIZE*10);
      image(soilEmpty,soilEmptyX11,SOIL_SIZE*11);
      image(soilEmpty,soilEmptyX12,SOIL_SIZE*12);
      image(soilEmpty,soilEmptyX13,SOIL_SIZE*13);
      image(soilEmpty,soilEmptyX14,SOIL_SIZE*14);
      image(soilEmpty,soilEmptyX15,SOIL_SIZE*15);
      image(soilEmpty,soilEmptyX16,SOIL_SIZE*16);
      image(soilEmpty,soilEmptyX17,SOIL_SIZE*17);
      image(soilEmpty,soilEmptyX18,SOIL_SIZE*18);
      image(soilEmpty,soilEmptyX19,SOIL_SIZE*19);
      image(soilEmpty,soilEmptyX20,SOIL_SIZE*20);
      image(soilEmpty,soilEmptyX21,SOIL_SIZE*21);
      image(soilEmpty,soilEmptyX22,SOIL_SIZE*22);
      image(soilEmpty,soilEmptyX23,SOIL_SIZE*23);


     
    
      

		// Cabbages
		// > Remember to check if playerHealth is smaller than PLAYER_MAX_HEALTH!

		// Groundhog



		PImage groundhogDisplay = groundhogIdle;

		// If player is not moving, we have to decide what player has to do next
		if(playerMoveTimer == 0){

			// HINT:
			// You can use playerCol and playerRow to get which soil player is currently on

			// Check if "player is NOT at the bottom AND the soil under the player is empty"
			// > If so, then force moving down by setting playerMoveDirection and playerMoveTimer (see downState part below for example)
			// > Else then determine player's action based on input state

			if(leftState){

				groundhogDisplay = groundhogLeft;

				// Check left boundary
				if(playerCol > 0){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the left"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = LEFT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(rightState){

				groundhogDisplay = groundhogRight;

				// Check right boundary
				if(playerCol < SOIL_COL_COUNT - 1){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the right"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = RIGHT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(downState){

				groundhogDisplay = groundhogDown;

				// Check bottom boundary

				// HINT:
				// We have already checked "player is NOT at the bottom AND the soil under the player is empty",
				// and since we can only get here when the above statement is false,
				// we only have to check again if "player is NOT at the bottom" to make sure there won't be out-of-bound exception
				if(playerRow < SOIL_ROW_COUNT - 1){

					// > If so, dig it and decrease its health

					// For requirement #3:
					// Note that player never needs to move down as it will always fall automatically,
					// so the following 2 lines can be removed once you finish requirement #3

					playerMoveDirection = DOWN;
					playerMoveTimer = playerMoveDuration;


				}
			}

		}

		// If player is now moving?
		// (Separated if-else so player can actually move as soon as an action starts)
		// (I don't think you have to change any of these)

		if(playerMoveTimer > 0){

			playerMoveTimer --;
			switch(playerMoveDirection){

				case LEFT:
				groundhogDisplay = groundhogLeft;
				if(playerMoveTimer == 0){
					playerCol--;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SOIL_SIZE;
				}
				break;

				case RIGHT:
				groundhogDisplay = groundhogRight;
				if(playerMoveTimer == 0){
					playerCol++;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SOIL_SIZE;
				}
				break;

				case DOWN:
				groundhogDisplay = groundhogDown;
				if(playerMoveTimer == 0){
					playerRow++;
					playerY = SOIL_SIZE * playerRow;
				}else{
					playerY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SOIL_SIZE;
				}
				break;
			}

		}

		image(groundhogDisplay, playerX, playerY);

		// Soldiers
		// > Remember to stop player's moving! (reset playerMoveTimer)
		// > Remember to recalculate playerCol/playerRow when you reset playerX/playerY!
		// > Remember to reset the soil under player's original position!

		// Demo mode: Show the value of soilHealth on each soil
		// (DO NOT CHANGE THE CODE HERE!)

		if(demoMode){	

			fill(255);
			textSize(26);
			textAlign(LEFT, TOP);

			for(int i = 0; i < soilHealth.length; i++){
				for(int j = 0; j < soilHealth[i].length; j++){
					text(soilHealth[i][j], i * SOIL_SIZE, j * SOIL_SIZE);
				}
			}

		}

		popMatrix();

		// Health UI

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

				// Initialize player
				playerX = PLAYER_INIT_X;
				playerY = PLAYER_INIT_Y;
				playerCol = (int) (playerX / SOIL_SIZE);
				playerRow = (int) (playerY / SOIL_SIZE);
				playerMoveTimer = 0;
				playerHealth = 2;

				// Initialize soilHealth
				soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
				for(int i = 0; i < soilHealth.length; i++){
					for (int j = 0; j < soilHealth[i].length; j++) {
						 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
						soilHealth[i][j] = 15;
           
}
}
				

				// Initialize soidiers and their position

				// Initialize cabbages and their position
				
			}

		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

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
		if(key=='b'){
			// Press B to toggle demo mode
			demoMode = !demoMode;
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

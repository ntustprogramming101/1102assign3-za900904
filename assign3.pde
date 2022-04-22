final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int STAY = 10;
final int GO_DOWN = 11;
final int GO_LEFT = 12;
final int GO_RIGHT = 13;

int groundhogX = 320;
int groundhogY = 80;
int walk = STAY;
float walkY = 0;
float walkX = 0;
int frame = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int SOIL_SIZE = 80;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage soil0, soil1,soil2, soil3, soil4, soil5;
PImage stone1, stone2;
PImage life;
PImage groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
  frameRate(60);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life = loadImage("img/life.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
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

    pushMatrix();
    if(cameraOffsetY>-1600){    //cameraOffsetY
      
      switch(walk){
        case GO_DOWN:
          if(frame<=15){
          cameraOffsetY = cameraOffsetY-round(80/15);
          translate(0, cameraOffsetY);
          }
          else{
          translate(0, cameraOffsetY);
          }
        break;
        
        case STAY:
          translate(0, cameraOffsetY);
        break;
        
        case GO_LEFT:
          translate(0, cameraOffsetY);
        break;
        
        case GO_RIGHT:
          translate(0, cameraOffsetY);
        break;
      }
    }
    
    else{
      cameraOffsetY = -1600;
      switch(walk){
        case GO_DOWN:
          if(frame<15){
            translate(0, cameraOffsetY);
          }
          
          else{
            translate(0, cameraOffsetY);
          }
        break;
        
        case STAY:
          translate(0, cameraOffsetY);
        break;
        
        case GO_LEFT:
          translate(0, cameraOffsetY);
        break;
        
        case GO_RIGHT:
          translate(0, cameraOffsetY);
        break;
      }
    }
    
		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    
    //soil0
    for(int i=0; i<=8; i++){  
      for(int j = 0; j<=24;j++){
        int soilX=0;
        int soilY=0;
        soilX = soilX+i*80;
        soilY = soilY+j*80;
      
        if(j<24){
          image(soil5,soilX,160+soilY);
         }
      
        if(j<20){
          image(soil4,soilX,160+soilY);
        }
      
        if(j<16 && j>8){
        image(soil3,soilX,160+soilY);

        }
      
        if(j<12){
        image(soil2,soilX,160+soilY);
        }
        
        if(j<8){
        image(soil1,soilX,160+soilY);
        image(stone1,soilX,160+soilX);
        }
      
        if(j<4){
        image(soil0,soilX,160+soilY);
        }
      }
    }
    
    // row 9~16
    pushMatrix();
    translate(0,2*SOIL_SIZE);
    for(int i=0;i<9;i++){
        for(int j=8;j<16;j++){
          if(i%4==0){
            if(j%4>0 && j%4<3){
          image(stone1,i* SOIL_SIZE,j* SOIL_SIZE);
          image(stone1,(i+3)* SOIL_SIZE,j* SOIL_SIZE);
          } 
          else{
          image(stone1,(i+1)* SOIL_SIZE,j* SOIL_SIZE);
          image(stone1,(i+2)* SOIL_SIZE,j* SOIL_SIZE);
          }
          }
      }
    }
    popMatrix();
    //row 17~24
    
    pushMatrix();
    translate(0,18*SOIL_SIZE);
    for(int j=0;j<16;j++){
      for(int i=0;i<8;i++){
        int stoneX = width*2-SOIL_SIZE;
        stoneX = stoneX-SOIL_SIZE*j;
        if(j%3>0){
          image(stone1,stoneX-SOIL_SIZE*i,i*SOIL_SIZE);
        }
        if(j%3==2){
          image(stone2,stoneX-SOIL_SIZE*i,i*SOIL_SIZE);
        }
      }
    }
    popMatrix();
    
		// Player
        
        if(frame<=15){
          frame++;
          switch(walk){
            case GO_DOWN:
              if(walkY <1920){
              walkY= walkY + round(80/15);
              }
              else{walkY=1920;
            }
            break;
            
            case GO_LEFT:
              walkX = walkX - round(80/15);
            break;
            
            case GO_RIGHT:
              walkX = walkX + round(80/15);
            break;
          }
         }
         else{
          walk=STAY;
         }
          
        
        switch(walk){
          
        case STAY:
        image(groundhogIdle,groundhogX + walkX,groundhogY + walkY); //groundhog
        break;
        
        case GO_DOWN:
        image(groundhogDown,groundhogX + walkX,groundhogY + walkY);
        break;
        
        case GO_RIGHT:
        image(groundhogRight,groundhogX + walkX,groundhogY + walkY);
        break;
        
        case GO_LEFT:
        image(groundhogLeft,groundhogX + walkX,groundhogY + walkY);
        break;
        }

        if(groundhogY + walkY > 2000){
          walkY = 320;
        }
        if(groundhogY + walkY < 80){
          walkY = 0;
        }
        if(groundhogX + walkX > 560){
          walkX = 240;
        }
        if(groundhogX + walkX < 0){
          walkX = -320;
        }
        popMatrix(); //cameraOffsetY
        
		// Health UI
    
    for(int i = 0; i<playerHealth; i++){
      int lifeX = 10;
      lifeX = lifeX+i*70;
      image(life,lifeX,10);
    }
    
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
    
  if(walk == STAY){
    frame = 0;
  switch(keyCode){
    
    case DOWN:
    walk = GO_DOWN;
    

    break;
    
    
    case LEFT:
    walk = GO_LEFT;
    break;
    
    case RIGHT:
    walk =GO_RIGHT;
    break;
    
    
  }
}
}

void keyReleased(){
}

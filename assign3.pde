final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

int soilWidth[]=new int[8];
int soilHeight[]=new int[24];

int lifeX;
int lifeY=10;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24,life;
PImage stone1,stone2;
PImage soilImage[]=new PImage[6];


// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soilImage[0]=loadImage("img/soil0.png");
  soilImage[1]=loadImage("img/soil1.png");
  soilImage[2]=loadImage("img/soil2.png");
  soilImage[3]=loadImage("img/soil3.png");
  soilImage[4]=loadImage("img/soil4.png");
  soilImage[5]=loadImage("img/soil5.png");
  life=loadImage("img/life.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
  

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
		for(int i=0 ; i<soilWidth.length ; i++){
      for(int a=0 ; a<soilHeight.length ; a++){
        if(a>3 && a<8){
          image(soilImage[1],i*80,(a+2)*80);
        }else if(a>7 && a<12){
          image(soilImage[2],i*80,(a+2)*80);
        }else if(a>11 && a<16){
          image(soilImage[3],i*80,(a+2)*80);
        }else if(a>15 && a<20){
          image(soilImage[4],i*80,(a+2)*80);
        }else if(a>19 && a<24){
          image(soilImage[5],i*80,(a+2)*80);
        }else{image(soilImage[0],i*80,(a+2)*80);}
      }
    }
    

    //stone
    //level1
    for(int i=0 ; i<8 ; i++){
      image(stone1,i*80,(i+2)*80);
    }
    //level2
    for(int i=-1 ; i<8 ; i+=4){
      for(int a=0 ; a<7 ; a+=4){
        for(int b=0 ; b<2 ; b++){
          image(stone1,(i+b)*80,(a+11)*80);
          image(stone1,(i+b)*80,(a+12)*80);
        }
      } 
    }
    for(int i=1 ; i<7 ; i+=4){
      for(int a=0 ; a<8 ; a+=4){
        for(int b=0 ; b<2 ; b++){
          image(stone1,(i+b)*80,(a+10)*80);
          image(stone1,(i+b)*80,(a+13)*80);
        }
      } 
    }
    //level3
    for(int i=0 ; i<8 ; i++){
      for(int a=0 ; a<2 ; a++){
        for(int b=-6 ; b<7 ; b+=3){
          image(stone1,(i+a+b)*80,height-(i-19)*80);
        }
      }
    }
    for(int i=0 ; i<8 ; i++){
      for(int b=-5 ; b<8 ; b+=3){
        image(stone2,(i+b)*80,height-(i-19)*80);
      }
    }
		// Player

		// Health UI
    
    for(int i=0 ; i<playerHealth ; i++ ){ 
      image(life,i*70+10,lifeY);
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
}

void keyReleased(){
}

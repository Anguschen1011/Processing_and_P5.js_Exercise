// 基本：請完成本周課程內的太空船遊戲，需達到1) 點擊滑鼠，才顯示太空船和敵機且開始遊戲; 2)可使用鍵盤上下左右移動太空船; 
// 3) 顯示血條和隨機顯示寶物; 4) 敵機由左至右移動，超出邊界後，再從左邊出現，出現的列可一開始隨機選定；5) 出現背景音樂
import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioSample heal, over;

PImage BackGroundImage1, BackGroundImage2, ShipImage, enemyImage, heartImage;

int x, y; //ship (x,y)
int x_e = 0, y_e = int(floor(random(50,350))); //enemy ship (x,y)
int heartX = int(floor(random(0,450))), heartY = int(floor(random(100,500))); // heart (x,y)

float y1, y2; //background (y)

int barLength = 100; //blood length
int barHeight = 20; //blood height
int decreaseAmount = 2, diamondHeal = 20; //blood decrease

int shipSpeed = 3;
int enemySpeed = 2;
float backgroundSpeed = 1.5; //background

int xDirection = 0;
int yDirection = 0;

boolean gameStarted = false, gameover = false, keyIsPressed;

void setup() {
  size(500, 700);
  x = 226;
  y = 600;
  BackGroundImage1 = BackGroundImage2 = loadImage("space.png");
  y1 = 0;
  y2 = -BackGroundImage1.height;
  ShipImage = loadImage("ship.png");
  ShipImage.resize(50, 50);
  enemyImage = loadImage("enemy.png");
  enemyImage.resize(50, 50);
  heartImage = loadImage("heart.png");
  heartImage.resize(40, 40);
  minim = new Minim(this);
  song = minim.loadFile("backgroundSound.wav");
  over = minim.loadSample("gameover.wav");
  heal = minim.loadSample("heal.wav");
}

void draw() {
  //rolling background
  image(BackGroundImage1, 0, y1);
  image(BackGroundImage2, 0, y2);
  y1 += backgroundSpeed;
  y2 += backgroundSpeed;
  if (y1 > height) {
    y1 = y2 - BackGroundImage1.height;
  }
  if (y2 > height) {
    y2 = y1 - BackGroundImage2.height;
  }
  
  //game started
  if (gameStarted == true && gameover == false) {
    song.play();
    if ((song.length() - song.position())<100){
      song.rewind();
      song.play();
      
    }
    image(ShipImage, x, y);
    //y_e = floor(random(50,350));
    image(enemyImage, x_e, y_e);
    image(heartImage, heartX, heartY);
    if(x_e <= 500){x_e += enemySpeed;}
    else if (x_e > 500) {
      x_e = 0;
      y_e = int(floor(random(50,350)));
    }
    //blood
    stroke(211, 211, 211);
    strokeWeight(3);
    fill(255, 0, 0);
    rect(20, 20, barLength, barHeight);
    noFill();
    strokeWeight(4);
    rect(20, 20, 100, 20);
    // left, right
    x += xDirection * shipSpeed;
    y += yDirection * shipSpeed;
    if (x < 0) {
      x = 0;
    } 
    else if (x > 452) {
      x = 452;
    }
    if (y < 0) {
      y = 0;
    } 
    else if (y > 650) {
      y = 650;
    }
    // if collision coin
    if (x + 50 > heartX && x < heartX + 50 && y + 50 > heartY && y < heartY + 50){
      heal.trigger();
      if (barLength+diamondHeal >= 100) {
        barLength = 100;
      }
      else {
        barLength += diamondHeal;
      }
      resetPositions_heart();
    }
    // if collision with enemy
    if (x + 50 > x_e && x < x_e + 50 && y + 50 > y_e && y < y_e + 50) {
      barLength -= decreaseAmount;
    }
    //if game is over
    if (barLength <= 0) {
      song.pause();
      over.trigger();
      gameover = true;
    }
  }
  else if(gameover){
    textSize(30);
    textAlign(CENTER);
    fill(255);
    text("Game Over !", width / 2, 200);
  }
  else if(gameStarted == false && gameover == false){
    textSize(30);
    textAlign(CENTER);
    fill(255);
    text("Click to start the game !", width / 2, height/2);
  }
}

void keyPressed() {
  keyIsPressed = true;
  if (gameStarted) {
    if (key == 'a' || key == 'A') {
      xDirection = -1; // left
    } else if (key == 'd' || key == 'D') {
      xDirection = 1; // right
    } else if (key == 'w' || key == 'W') {
      yDirection = -1; // up
    } else if (key == 's' || key == 'S') {
      yDirection = 1; // down
    }
  }
}

void keyReleased() {
  keyIsPressed = false;
  if (gameStarted) {
    if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
      xDirection = 0;
    } else if (key == 'w' || key == 'W' || key == 's' || key == 'S') {
      yDirection = 0;
    }
  }
}

void mousePressed() {
  if (gameover){
    gameStarted = false;
    gameover = false;
    x = 226;
    y = 600;
    barLength = 100;
  }
  else{
    gameStarted = true;
  }
}

void resetPositions_heart() {
  heartX = int(floor(random(width - 50)));
  heartY = int(floor(random(height - 50)));
}

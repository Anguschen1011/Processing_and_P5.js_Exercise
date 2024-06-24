float eyeX1 = 320;
float eyeX2 = 280;
float eyeY = 115;
float eyeSpeed = 0.5;

void setup() {
  size(600, 400);
  background(255, 255, 255, 100);
}

void draw() {
  robot();
  strokeWeight(10);
  point(280, 115);
  point(320, 115);
   if (mousePressed) {
    if (mouseButton == LEFT) {
      background(255);
      robot();
      EyeMove_L();
    } else if (mouseButton == RIGHT) {
      background(255);
      robot();
      EyeMove_R();
    } else if (mouseButton == CENTER) {
      background(255);
      robot();
      EyeBlink();
    }
  } 
  else {
    eyeX1 = 320;
    eyeX2 = 280;
    background(255);
    robot();
    strokeWeight(10);
    point(280, 115);
    point(320, 115);
  }
}

void robot() {
  stroke(79, 82, 80);
  // Arms
  float armRadius = 60;
  float armStartAngle_R = 0;
  float armEndAngle_R = PI*0.5;
  float armStartAngle_L = PI;
  float armEndAngle_L = PI*1.5;
  float armX_R = 360;
  float armY_R = 140 - armRadius + 30;
  float armX_L = 240;
  float armY_L = 140 + (armRadius+10) + 30;
  strokeWeight(5);
  noFill();
  arc(armX_R, armY_R+1, (armRadius+10) * 2, (armRadius+10) * 2, armStartAngle_R, armEndAngle_R);
  arc(armX_R, armY_R, armRadius * 2, armRadius * 2, armStartAngle_R, armEndAngle_R);
  arc(armX_L, armY_L, (armRadius+10) * 2, (armRadius+10) * 2, armStartAngle_L, armEndAngle_L);
  arc(armX_L, armY_L+1, armRadius * 2, armRadius * 2, armStartAngle_L, armEndAngle_L);
  strokeWeight(8);
  arc(425, 96, 30, 30, 0, PI); //right hand
  arc(175, 254, 30, 30, PI, TWO_PI); //left hand
  // Head
  float radius = 50;
  float centerX = 300;
  float centerY = 100;
  float rectWidth = radius * 2;
  float rectHeight = 30;
  float rectX = centerX - radius;
  float rectY = centerY;
  strokeWeight(5);
  arc(centerX, centerY, radius*2, radius*2, PI, TWO_PI);
  quad(rectX, rectY, rectX + rectWidth, rectY, rectX + rectWidth, rectY + rectHeight, rectX, rectY + rectHeight);
  quad(rectX, rectY + rectHeight, rectX + rectWidth, rectY + rectHeight, rectX + rectWidth, rectY + rectHeight + 10, rectX, rectY + rectHeight + 10);
  float squareSize = 15;
  float squareX_1 = rectX + rectWidth;
  float squareX_2 = rectX - squareSize;
  float squareY = rectY + squareSize/2;
  rect(squareX_1, squareY, squareSize, squareSize); //rect_Right
  rect(squareX_2, squareY, squareSize, squareSize); //rect_Left
  // Body
  strokeWeight(5);
  float bodyWidth = 120;
  float bodyHeight = 80;
  float bodyX = centerX - radius - 10;
  float bodyY = centerY + 40;
  quad(bodyX, bodyY, bodyX + bodyWidth, bodyY, bodyX + bodyWidth, bodyY + bodyHeight, bodyX, bodyY + bodyHeight);
  // Legs
  float legWidth = 35;
  float legHeight = 100;
  float legY = bodyY + bodyHeight;
  float legXOffset = 10;
  quad(bodyX + legXOffset, legY, bodyX + legXOffset + legWidth, legY, bodyX + legXOffset + legWidth, legY + legHeight, bodyX + legXOffset, legY + legHeight);
  line(bodyX + legXOffset, legY + 60, bodyX + legXOffset + legWidth, legY + 60);
  quad(bodyX + bodyWidth - (legWidth + legXOffset), legY, bodyX + bodyWidth - legXOffset, legY, bodyX + bodyWidth - legXOffset, legY + legHeight, bodyX + bodyWidth - (legWidth + legXOffset), legY + legHeight);
  line(bodyX + bodyWidth - (legWidth + legXOffset), legY + 60, bodyX + bodyWidth - legXOffset, legY + 60);
  // Shoes
  float ShoesWidth = 50;
  float ShoesHeight = 20;
  float ShoesX_L = (bodyX + legXOffset) - (ShoesWidth-legWidth)/2;
  float ShoesX_R = bodyX + bodyWidth - (legWidth + legXOffset) - (ShoesWidth-legWidth)/2;
  float ShoesY = legY + legHeight;
  quad(ShoesX_L, ShoesY, ShoesX_L+ShoesWidth, ShoesY, ShoesX_L+ShoesWidth, ShoesY+ShoesHeight, ShoesX_L-5, ShoesY+ShoesHeight);
  quad(ShoesX_R, ShoesY, ShoesX_R+ShoesWidth, ShoesY, ShoesX_R+ShoesWidth+5, ShoesY+ShoesHeight, ShoesX_R, ShoesY+ShoesHeight);
}
 
void EyeBlink(){
  float eyeXOffset = 20;
  float eyeY = 115;
  float blinkDuration = 30;
  float blinkSpeed = 0.5;
  float blinkFrames = blinkDuration / blinkSpeed;
  float blinkInterval = blinkFrames / 2;
  float currentFrame = frameCount % blinkFrames;
  strokeWeight(2);
  stroke(79, 82, 80);
  // Blink
  if (currentFrame < blinkInterval) {
    // closed
    fill(79, 82, 80);
    ellipse(300 - eyeXOffset, eyeY, 14, 2); // 左眼
    ellipse(300 + eyeXOffset, eyeY, 14, 2); // 右眼
  } 
  else {
    // open
    fill(79, 82, 80);
    ellipse(300 - eyeXOffset, eyeY, 14, 14); // 左眼
    ellipse(300 + eyeXOffset, eyeY, 14, 14); // 右眼
  }
}

void EyeMove_L(){
  strokeWeight(6);
  stroke(79, 82, 80);
  ellipse(eyeX1, eyeY, 14, 14); // 左眼
  ellipse(eyeX2, eyeY, 14, 14); // 右眼
  if (eyeX1 >300) {
    eyeX1 -= eyeSpeed;
    eyeX2 -= eyeSpeed;
  }
}

void EyeMove_R(){
  strokeWeight(6);
  stroke(79, 82, 80);
  ellipse(eyeX1, eyeY, 14, 14); // 左眼
  ellipse(eyeX2, eyeY, 14, 14); // 右眼
  if (eyeX1 <343) {
    eyeX1 += eyeSpeed;
    eyeX2 += eyeSpeed;
  }
}

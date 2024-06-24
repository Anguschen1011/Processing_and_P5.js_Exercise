import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

Capture video;
OpenCV opencv;

int center_x, center_y;

void setup() {
  size(1280, 720);  
  video = new Capture(this, 1280, 720);
  opencv = new OpenCV(this, 1280, 720);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void captureEvent(Capture video){
  video.read();
}

void draw() {
  opencv.loadImage(video);
  video.loadPixels();
  image(video, 0 ,0);
  loadPixels();
  video.loadPixels();
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();   //偵測是否有臉
  // Detect faces
  for (int i = 0; i < faces.length; i++) {    //根據臉孔數目來跑迴圈
    println("x:",faces[i].x, ", y:", faces[i].y);
    println("width:",faces[i].width,", heught:", faces[i].height);
    center_x = faces[i].x + (faces[i].width/2);   //起始點x + 0.5*寬
    center_y = faces[i].y + (faces[i].height /2);
    for (int x=0; x<1280; x++) {
      for (int y=0; y<720; y++) {
        int loc = x + y*1280;
        float r, g, b;
        float d = dist(x, y, center_x, center_y);
        float distance = (faces[i].width+faces[i].height)/2;
        float adjustbrightness = map(d, 0, distance - 50, 1.5, 0.5);
        r = red  (video.pixels[loc]);
        g = green(video.pixels[loc]);
        b = blue (video.pixels[loc]);
        r *= adjustbrightness;
        g *= adjustbrightness;
        b *= adjustbrightness;
        r = constrain(r, 0, 255);
        g = constrain(g, 0, 255);
        b = constrain(b, 0, 255);
        color c = color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
        pixels[loc] = c;
      }
    }
    updatePixels();
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

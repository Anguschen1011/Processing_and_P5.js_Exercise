let video;
let poseNet;
let pose;
let skeleton;

function setup() {
  createCanvas(640, 480);
  video = createCapture(VIDEO);
  video.hide();
  poseNet = ml5.poseNet(video, modelLoaded);
  poseNet.on('pose', gotPoses);
}

function gotPoses(poses) {
  if (poses.length > 0) {
    pose = poses[0].pose;
  }
}


function modelLoaded() {
  console.log('PoseNet Ready');
}

function draw() {
  image(video, 0, 0);

  if (pose) {
    let handR = pose.rightWrist;
    let handL = pose.leftWrist;
    let shoulderR = pose.rightShoulder;
    let shoulderL = pose.leftShoulder;
    
    fill(128,128,128);
    noStroke();
    ellipse(handR.x, handR.y, 16, 16);
    ellipse(handL.x, handL.y, 16, 16);
    ellipse(shoulderR.x, shoulderR.y, 16, 16);
    ellipse(shoulderL.x, shoulderL.y, 16, 16);

    if (handR.y < shoulderR.y && handL.y < shoulderL.y) {
      textSize(30);
      textAlign(CENTER);
      fill(0, 255, 0);
      text('舉起雙手', width/2, height - 20);
    } else {
      if (handR.y < shoulderR.y) {
        textSize(30);
        textAlign(CENTER);
        fill(255, 0, 0);
        text('舉起右手', width/2, height - 20);
      } else if (handL.y < shoulderL.y) {
        textSize(30);
        textAlign(CENTER);
        fill(0, 0, 255);
        text('舉起左手', width/2, height - 20);
      } else {
        // 沒有舉起手
        textSize(30);
        textAlign(CENTER);
        fill(128);
        text('手放下', width/2, height - 20);
      }
    }
  }
}
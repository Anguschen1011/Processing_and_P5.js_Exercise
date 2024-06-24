let video;
let poseNet;
let pose;
let skeleton;
let poses = [];

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
    skeleton = poses[0].skeleton;
  }
}

function modelLoaded() {
  console.log('PoseNet Ready');
}

function calculateVector(pointA, pointB) {
  return {x: pointB.x - pointA.x, y: pointB.y - pointA.y};
}

function draw() {
  image(video, 0, 0);

  if (pose) {
    // Get key points
    let rightShoulder = pose.rightShoulder;
    let leftShoulder = pose.leftShoulder;
    let rightElbow = pose.rightElbow;
    let leftElbow = pose.leftElbow;
    let rightWrist = pose.rightWrist;
    let leftWrist = pose.leftWrist;

    // Define a threshold for y-coordinate difference
    let yThreshold = 50;
    let xThreshold = 50;
    
    // Draw specific key points
    fill(0, 0, 255); // Blue color for specific keypoints
    ellipse(rightShoulder.x, rightShoulder.y, 10, 10);
    ellipse(leftShoulder.x, leftShoulder.y, 10, 10);
    ellipse(rightElbow.x, rightElbow.y, 10, 10);
    ellipse(leftElbow.x, leftElbow.y, 10, 10);
    ellipse(rightWrist.x, rightWrist.y, 10, 10);
    ellipse(leftWrist.x, leftWrist.y, 10, 10);

    // Draw skeleton lines for arms
    stroke(0, 0, 255); // Blue color for arm skeleton
    strokeWeight(2);
    line(rightShoulder.x, rightShoulder.y, leftShoulder.x, leftShoulder.y);
    line(rightShoulder.x, rightShoulder.y, rightElbow.x, rightElbow.y);
    line(rightElbow.x, rightElbow.y, rightWrist.x, rightWrist.y);
    line(leftShoulder.x, leftShoulder.y, leftElbow.x, leftElbow.y);
    line(leftElbow.x, leftElbow.y, leftWrist.x, leftWrist.y);
    
    // Check if the right hand is level with the right shoulder and right elbow
    if (Math.abs(rightElbow.y - rightShoulder.y) < yThreshold &&
        Math.abs(rightWrist.y - rightElbow.y) < yThreshold) {
      // console.log('右手平舉');
      textSize(30);
      stroke(0);
      textAlign(CENTER);
      fill(224, 224, 224);
      text('右手平舉', width-150 , height - 20);
    }

    // Check if the left hand is level with the left shoulder and left elbow
    if (Math.abs(leftElbow.y - leftShoulder.y) < yThreshold &&
        Math.abs(leftWrist.y - leftElbow.y) < yThreshold) {
      // console.log('左手平舉');
      textSize(30);
      stroke(0);
      textAlign(CENTER);
      fill(224, 224, 224);
      text('左手平舉', 150 , height - 20);
    }
    
  }
}

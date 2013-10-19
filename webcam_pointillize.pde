  
import processing.video.*;

Capture cam;
int col, row;
int size = 8;
void setup() {
  
  size(1280, 720);
  
  col = width/size;
  row = height/size;
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  for (int i = 0; i< col; i++) {
    for (int j = 0; j < row; j++) {
      int x = i*size;
      int y = j*size;
      
      noFill();
      stroke(0);
      rect(x,y,size,size); 
      
    }
  
  }
    println(Integer.toString(mouseX) + Integer.toString(mouseY));
  
  
}
void mousePressed() {

}



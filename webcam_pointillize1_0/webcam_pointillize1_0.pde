
import processing.video.*;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Color;
Capture cam;
int col, row;
int size = 10;
int count = 0;
Robot robot;
int temp;
void setup() {

  size(1280, 720);

  col = width/size;
  row = height/size;
  String[] cameras = Capture.list();
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    e.printStackTrace();
  }
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
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
      rect(x, y, size, size);
    }
  }
  //  color c = get(mouseX, mouseY);
  //   println(Integer.toString(mouseX) +","+ Integer.toString(mouseY)+","+c);
  //   for (int i = 0; i< 1280; i = i+20){
  //     for (int j = 0; j<720; j=j+20) {
  //        c = get(i, j);
  //       println(c);
  //     
  //     }
  //   }

  //  loadPixels();
  //  color c = color(0,0,0);
  //  for (int i = 0; i < (1280*720/2)-1280/2; i++) {
  //  temp = pixels[i];
  //  
  //  if (temp[0] > 0 && temp[0] < 36 && temp[1] > 180 && temp[1] < 220 && temp[2] > 0 && temp[2] < 44) {
  //    temp = c;
}

//  }
//}





void mousePressed() {
  loadPixels();
  
  /* int color;
      int temp;
      temp = (Byte)(color & 0xFF) //to get rightmost 8 bits
      color = color >> 8;
      temp = (Byte)color & 0xFF) // to get next 8 bits
     
  String temp = Integer.toHexString(t);
  */
  
  int Red, Blue, Green;
//  int tempx, tempy;
//  int c = 0
//  for (int x = mouseX-5; x < mouseX+5; x++){
//    for (int y = mouseY-5; y < mouseY+5; y++){
//      c = c + pixels[y*1280+x];
//    }
//  
//  }
  color c = pixels[mouseY*1280+mouseX];
  println(c);
  println(Integer.toBinaryString(c));
  Blue =  c & 255;
  Green = (c >> 8) & 255;
  Red =   (c >> 16) & 255;
  println(Red +"," + Green +"," + Blue);
  println(Integer.toString(mouseX) +","+ Integer.toString(mouseY));
  
}
//64 135 107

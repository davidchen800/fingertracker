

import processing.video.*;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Color;
import java.util.List;
import static java.util.Arrays.asList;
import java.awt.event.InputEvent;

Capture cam;
int col, row;
int size = 10;
int old_X, old_Y, old_size;

Robot robot;
int temp;
color green = color(20, 166, 53);
color red = color(143, 35, 68);
int count = 0;
boolean clicked = false;


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
  //  for (int i = 0; i< col; i++) {
  //    for (int j = 0; j < row; j++) {
  //      int x = i*size;
  //      int y = j*size;
  //
  //      noFill();
  //      stroke(0);
  //      rect(x, y, size, size);
  //    }
  //  }
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
  //  robot.mouseMove(mouseX, mouseY+10);

  loadPixels();
  if  (count < 100) {
    println(count);
    count++;
  } 
  else {
    ArrayList temp2 = red_pixels(pixels);
    if (temp2.size()>3000){
      ArrayList center = findCenter(temp2);
      println(temp2.size());
      int new_X = ((Double) center.get(0)).intValue();
      int new_Y = ((Double) center.get(1)).intValue();
      robot.mouseMove(1280-new_X, new_Y);
    }
//   ArrayList temp3 = red_pixels(pixels);
//  if (!clicked && temp3.size()>15000){
//  clicked = true;
//  println("I DID IT");
//  
//  robot.mousePress(InputEvent.BUTTON1_MASK);
//  robot.mouseRelease(InputEvent.BUTTON1_MASK);
  
//  }

  }
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
  //  //  int tempx, tempy;
  //  //  int c = 0
  //  //  for (int x = mouseX-5; x < mouseX+5; x++){
  //  //    for (int y = mouseY-5; y < mouseY+5; y++){
  //  //      c = c + pixels[y*1280+x];
  //  //    }
  //  //  
  //  //  }
    color c = pixels[mouseY*1280+mouseX];
    
    Blue =  c & 255;
    Green = (c >> 8) & 255;
    Red =   (c >> 16) & 255;
    println(Red +"," + Green +"," + Blue);
  //  println(Integer.toString(mouseX) +","+ Integer.toString(mouseY));
//  ArrayList temp2 = green_pixels(pixels);
//  println(temp2);
//  println(temp2.size());
}
Boolean is_green(int colors) {

  if (diffColor(colors, green) < 100.0) {
    return true;
  }
  return false;
}
static double diffColor(color col1, color col2) {
  int Red1, Blue1, Green1, Red2, Blue2, Green2;
  Blue1 =  col1 & 255;
  Green1 = (col1 >> 8) & 255;
  Red1 =   (col1 >> 16) & 255;
  Blue2 =  col2 & 255;
  Green2 = (col2 >> 8) & 255;
  Red2 =   (col2 >> 16) & 255;
  double dist = Math.sqrt(Math.pow(Red1-Red2, 2)+Math.pow(Green1-Green2, 2)+Math.pow(Blue1-Blue2, 2));
  return dist;
}
ArrayList findCenter(ArrayList pixel_loc) {
  int len = pixel_loc.size();
  double x_tot = 0.0;
  double y_tot = 0.0;
  for (int i=0; i<len; i++) {
    if ((i % 2) == 0) {
      x_tot += (double)(Integer) pixel_loc.get(i);
    } 
    else {
      y_tot += (double)(Integer) pixel_loc.get(i);
    }
  }
  double x_c = 2*x_tot/len;
  double y_c = 2*y_tot/len;
  List loc = new ArrayList(asList(x_c, y_c));
  //ArrayList loc = new ArrayList();
  //loc.add(x_c);
  //loc.add(y_c);
  return (ArrayList) loc;
}
ArrayList green_pixels(int[] pixel_list) {
  ArrayList<Integer> green = new ArrayList<Integer>();
  for (int x=0; x < 1280; x++) {
    for (int y=0; y < 720; y++) {
      int temp = pixel_list[y*1280+x];
      if (is_green(temp)) {
        green.add(x);
        green.add(y);
      }
    }
  }


  return green;
}
ArrayList red_pixels(int[] pixel_list) {
  ArrayList<Integer> red = new ArrayList<Integer>();
  for (int x=0; x < 1280; x++) {
    for (int y=0; y < 720; y++) {
      int temp = pixel_list[y*1280+x];
      if (is_red(temp)) {
        red.add(x);
        red.add(y);
      }
    }
  }


  return red;
}
Boolean is_red(int colors) {

  if (diffColor(colors, red) < 50.0) {
    return true;
  }
  return false;
}

//64 135 107


import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import hypermedia.video.*;
import java.awt.Rectangle;

OpenCV opencv;

int capture_width = 320;
int capture_height = 320;
int index_num=0;
int start = 0;
boolean isStart = false;

Minim minim;
AudioPlayer song;

void setup() {

    size( 640, 520 );

    opencv = new OpenCV( this );
    minim = new Minim(this);
    // this loads mysong.wav from the data folder
    song = minim.loadFile("camera.mp3");
    
    opencv.loadImage("nensyu1.png", 320, 320);
    image(loadImage("nensyu1.png"), width-320, height-320);    
    
    opencv.loadImage("nensyu2.png", 640, 200);
    image(loadImage("nensyu2.png"), 0, 0);    
    
    opencv.capture( capture_width, capture_height );                   // open video stream
    opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT_TREE );  // load detection description, here-> front face detection : "haarcascade_frontalface_alt.xml"

    // print usage
    println( "Drag mouse on X-axis inside this sketch window to change contrast" );
    println( "Drag mouse on Y-axis inside this sketch window to change brightness" );

}

public void stop() {
    opencv.stop();
    super.stop();
}

void draw() {
    // grab a new frame
    // and convert to gray
    opencv.read();
    opencv.convert( GRAY );

    // display the image
    image( opencv.image(), 0, height-capture_height );
    
    noFill();
    stroke(0, 255, 0);
    rect(0, height-capture_height, capture_width, capture_height);
        
    if(isStart){
      if(millis() - start > 3000){
        takePhoto();
        isStart = false;
        song.play();
        println("ok");
      }
    }
}

void keyPressed(){
  println("pressed");
  if(!isStart){
    start = millis();
    isStart = true;
  }
}

void takePhoto() {
  String y, m, d, h, mm, s;

  y = String.valueOf(year());
  m = String.valueOf(month());
  d = String.valueOf(day());
  h = String.valueOf(hour());
  mm = String.valueOf(minute());
  s = String.valueOf(second());

  String mystr="images/"+y+m+d+h+mm+s+".jpg";
  save(mystr);
  index_num++;
}

import toxi.geom.*;
import toxi.math.*;
import ddf.minim.*;
import java.lang.System;
import java.util.concurrent.TimeUnit;

Plane myPlane;
ArrayList bullets;
ArrayList missiles;

Minim minim;
AudioInput input;


void setup() {
  size(400, 700);
  smooth();
  myPlane = new Plane();
  bullets = new ArrayList();
  missiles = new ArrayList();
  noCursor();
  thread("voiceControl");
}

void draw() {
  background(0);
  myPlane.show();

  for (int i = 0; i < bullets.size (); i++) {
    Bullet myBullet = (Bullet) bullets.get(i);
    myBullet.show();
  }
  
  for (int j = 0; j < missiles.size (); j++) {
    Missile myMissile = (Missile) missiles.get(j);
    myMissile.show();
  }
}

void voiceControl() {
  minim = new Minim(this);
  input = minim.getLineIn();
  float mean = 0;
  long start = 0;
  long duration = 0;
  
  while (true) {
    mean = 0;
    for (int i = 0; i < input.bufferSize () - 1; i++) {
      mean = mean + abs(input.left.get(i));
    }
    mean /= (input.bufferSize () - 1);
    
    if(mean>0.001){
      if(start == 0){
        duration = 0;
        start = System.currentTimeMillis(); 
      }
      else{
        duration = 0;
      }
    }
    else{
      if(start != 0){
        duration = System.currentTimeMillis() - start;
        start = 0;
      }
      else{
        duration = 0;
      }
    }
    
    if(duration>=50 && duration < 700){
      myPlane.fire();
    }
    else if(duration > 700){
      myPlane.launch();
    }
  }

}



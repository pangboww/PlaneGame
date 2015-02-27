import toxi.geom.*;
import toxi.math.*;

Plane myPlane;
ArrayList bullets;


void setup(){
  size(400,700);
  smooth();
  myPlane = new Plane();
  bullets = new ArrayList();
  noCursor();
}

void draw(){
  background(0);
  myPlane.show();
  
  for(int i = 0; i < bullets.size(); i++){
    Bullet myBullet = (Bullet) bullets.get(i);
    myBullet.show();
  }
}

void mouseClicked(){
  myPlane.fire();
}




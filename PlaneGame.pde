import toxi.geom.*;
import toxi.math.*;

Plane myPlane;
ArrayList bullets;


void setup(){
  size(400,700);
  smooth();
  myPlane = new Plane();
  noCursor();
}

void draw(){
  background();
  myPlane.show();
  
}




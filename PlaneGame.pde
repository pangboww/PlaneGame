import toxi.geom.*;
import toxi.math.*;
import ddf.minim.*;
import java.lang.System;
import java.lang.Math;
import java.util.concurrent.TimeUnit;

PImage background;
Plane myPlane;
ArrayList<Bullet> bullets;
ArrayList<Missile> missiles;
ArrayList<Enemy> enemies;

Minim minim;
AudioInput input;


void setup() {
  size(768, 1024);
  smooth();
  explosion = new ArrayList<PImage>();
  loadAllImage();
  myPlane = new Plane();
  bullets = new ArrayList();
  missiles = new ArrayList();
  enemies = new ArrayList();
  noCursor();
  thread("voiceControl");
  thread("addEnemy");
}

void draw() {
  background(background);
  
  myPlane.show();
  
  for (int k = 0; k < enemies.size (); k++) {
    Enemy myEnemy = (Enemy) enemies.get(k);
    if (isInMap(myEnemy.loc)){
      myEnemy.show();
    }
    else {
      enemies.remove(k);
      print("enemies size: "+ enemies.size()+"\n"); 
    } 
  }
  
  for (int i = 0; i < bullets.size (); i++) {
    Bullet myBullet = (Bullet) bullets.get(i);
    if (isInMap(myBullet.loc)){
      myBullet.show();
    }
    else {
      bullets.remove(i); 
      print("bullets size: "+ bullets.size()+"\n"); 
    }
  }
  
  for (int j = 0; j < missiles.size (); j++) {
    Missile myMissile = (Missile) missiles.get(j);
    if (isInMap(myMissile.loc)){
      myMissile.show();
    }
    else {
      missiles.remove(j);
    }
  }
  
  collide();
}

void addEnemy(){
  while(true){
    enemies.add(new Enemy());
    try {
      Thread.sleep(2000);                 
    } catch(InterruptedException ex) {
      Thread.currentThread().interrupt();
    }
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

  
void collide(){
  for(Enemy e : enemies){
    if (e.isDestroyed) continue;
    for(Bullet b : bullets){
      if (b.isDestroyed) continue;
      float dis = e.loc.distanceTo(b.loc);
      if (dis < 40){
          e.destroy();
          b.destroy();
          continue;
      }
    }
    for(Missile m : missiles){
      if (m.isDestroyed) continue;
      float dis = e.loc.distanceTo(m.loc);
      if (dis < 40){
          e.destroy();
          m.destroy();
          continue;
      }
    }
  }
}



boolean isInMap(Vec2D loc){
  if (loc.x > width) return false;
  if (loc.y > height) return false;
  if (loc.x < 0) return false;
  if (loc.y < 0) return false;
  return true;
}

void loadAllImage(){
  background = loadImage("airPlanesBackground.png");
  planeM = loadImage("PLANE 8 N.png");
  planeL = loadImage("PLANE 8 L.png");
  planeR = loadImage("PLANE 8 R.png");
  bullet = loadImage("bullet.png");
  missile = loadImage("missile.png");
  enemy = loadImage("aerolite01.png");
  for(int i = 1; i <= 16; i++){
      explosion.add(loadImage("explosion" + i +".png"));
  }
}




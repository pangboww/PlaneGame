PImage planeM, planeL, planeR;
PImage bullet;
PImage missile;
PImage enemy;

class Plane{
  Plane(){
    loadPlaneImage();
  }
  
  void loadPlaneImage(){
    planeM = loadImage("plane_middle.png");
    planeL = loadImage("plane_left.png");
    planeR = loadImage("plane_right.png");
  }
  
  void show(){
    imageMode(CENTER);
    image(choosePlaneImage(), mouseX, mouseY, width/7, width/7);

  }
  
  PImage choosePlaneImage(){
    if(pmouseX > mouseX){
      return planeL;
    } else if(pmouseX < mouseX){
      return planeR;
    } else {
      return planeM;
    }
  }
  
  void fire(){
    bullets.add(new Bullet(new Vec2D(mouseX, mouseY)));
  }
  
  void launch(){
    missiles.add(new Missile(new Vec2D(mouseX, mouseY)));
  }
   
}

class Bullet {
  Vec2D loc;
  Vec2D speed;
  
  Bullet (Vec2D _loc){
    loc = _loc;
    speed = new Vec2D(0, -10);
    loadBulletImage();
  }
  
  void loadBulletImage(){
    bullet = loadImage("bullet.png");
  }
  
  void show(){
    imageMode(CENTER);
    move();
    image(bullet, loc.x, loc.y, width/40, width/10);
  }
  
  void move(){
    loc.addSelf(speed);
  }
}

class Missile {
  Vec2D loc;
  Vec2D speed;
  
  Missile (Vec2D _loc){
    loc = _loc;
    speed = new Vec2D(random(-3,3), random(-5,-10));
    loadMissileImage();
  }
  
  void loadMissileImage(){
    missile = loadImage("missile.png");
  }
  
  void show(){
    imageMode(CENTER);
    move();
    image(missile, loc.x, loc.y, width/30, width/8);
  }
  
  void gravity(){
    speed.addSelf(new Vec2D(random(-1,1), random(-1,1)));
  }
  
  void move(){
    gravity();
    loc.addSelf(speed);
  }
}

class Enemy {
  Vec2D loc;
  Vec2D speed;
  
  Enemy(){
    loc = new Vec2D(random(0, width), 0);
    speed = new Vec2D(random(0,5),random(0,7));
    loadEnemyImage();
  }
  
  void loadEnemyImage(){
    enemy = loadImage("enemy.png");
  }
  
  void show(){
    imageMode(CENTER);
    move();
    image(enemy, loc.x, loc.y, width/7, width/7);
  }
  
  void move(){
    loc.addSelf(speed);
  }
  
}

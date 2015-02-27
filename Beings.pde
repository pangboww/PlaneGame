PImage planeM, planeL, planeR;
PImage bullet;

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

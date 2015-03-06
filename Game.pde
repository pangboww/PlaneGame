class Game{
  int state;
  Plane myPlane;
  ArrayList<Bullet> bullets;
  ArrayList<Missile> missiles;
  ArrayList<Enemy> enemies;
  
  Game(){
    explosion = new ArrayList<PImage>();
    myPlane = new Plane();
    bullets = new ArrayList();
    missiles = new ArrayList();
    enemies = new ArrayList();
  
  }
}

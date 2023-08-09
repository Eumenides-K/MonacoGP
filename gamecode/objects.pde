abstract class objects{
 private float X;
 private float Y;
 private float heightX = 80;
 private float widthY = 40;
 public boolean direction;
    
  objects(){}
  
  // get position of the object
  public void setPositionX(float x){
    this.X = x;
  }
  
  public void setPositionY(float y){
    this.Y = y;
  }
  
  public float getPositionX(){
    return this.X; 
  }
  
  public float getPositionY(){
    return this.Y;
  }
  
  // get size of the object
  public float getWidth(){
    return this.widthY;
  }
  
  public float getHeight(){
    return this.heightX;
  }
  
  public void disappear(){
    this.X=1000;
    this.Y=1000;
  }
  
  // detect crash
  public boolean crashDetector(objects player, objects crashee){
    float playerX = player.getPositionX();
    float playerXPlusWidth = player.getPositionX() + player.getWidth();
    float playerY = player.getPositionY();
    float playerYPlusHeight = player.getPositionY() + player.getHeight();
    float botX = crashee.getPositionX();
    float botXPlusWidth = crashee.getPositionX() + getWidth();
    float botY = crashee.getPositionY();
    float botYPlusHeight = crashee.getPositionY() + getHeight();
    //Compares the co-ordinates of the car and objects, it basically constructs a box around the objects which
    //are then checked to see if there is any overlap
    if(playerX > botX && playerX < botXPlusWidth && playerY > botY && playerY < botYPlusHeight){
      return true;
    } else if(playerXPlusWidth > botX && playerXPlusWidth < botXPlusWidth && playerY > botY && playerY < botYPlusHeight){
      return true;
    } else if(playerX > botX && playerX < botXPlusWidth && playerYPlusHeight > botY && playerYPlusHeight < botYPlusHeight){
      return true;
    } else if(playerXPlusWidth > botX && playerXPlusWidth < botXPlusWidth && playerYPlusHeight > botY && playerYPlusHeight < botYPlusHeight){
      return true;
    }
    return false;
  }
  
  void moveObject(){}
  
  // show explosion animation after crash
  public void showExplosionAnimation(float x, float y) {
    if (game.getExploding() == true) {
        if (game.getExplodingIndex() < game.explosion.length) {
            //image(game.explosion[game.getExplodingIndex()], x, y);    
        }
        if (frameCount%10 == 0){
            int i = game.getExplodingIndex();
            game.setExplodingIndex(i);
        }
    }
  }
}

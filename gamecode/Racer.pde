abstract class Racer extends objects {
  
  //Abstact class to cover both bot and player containing methods and attributes we believe to be relevant to both

  private float speed;
  private final float heightX = 40;
  private final float widthY = 20;


   public float getWidth(){
      return this.widthY;
   }
  
  public float getHeight(){
    return this.heightX;
  }

  public float getSpeed(){
    return this.speed;
  }

  public void setSpeed(float speed){
    this.speed = speed;
  }

  public void moveUp(){
    this.setPositionY(this.getPositionY() - this.getSpeed());
  }

  public void moveDown(){
    this.setPositionY(this.getPositionY() + this.getSpeed());
  }

  public void moveLeft(){
    this.setPositionX(this.getPositionX() - this.getSpeed());
  }

  public void moveRight(){
    this.setPositionX(this.getPositionX() + this.getSpeed());
  }
}

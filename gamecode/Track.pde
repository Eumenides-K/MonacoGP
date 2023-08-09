public class Track{
  int speed;
  int trackPos;
  PImage trackImage;

  Track(PImage trackImage){
    this.trackImage=trackImage;
    this.trackImage.resize(width, 0);
    this.trackPos = 0;
  }
  
  public void setSpeed(int playerSpeed){
    speed = playerSpeed;
  }
  
  public int getSpeed(){
    return speed;
  }

  void moveTrack(){
    trackPos += speed;
    if (trackPos > trackImage.height) {
      trackPos = 0;
    }

    int yTop = (trackImage.height - (trackPos % trackImage.height));
    copy(trackImage, 0, yTop, width, height, 0, 0, width, height);
    int yBot = trackImage.height - yTop;
    if (yBot < height) {
      copy(trackImage, 0, 0, width, height, 0, yBot, width, height);
    }
  }

  void resetTrack(){
    trackPos=0;
  }
}

// This class represents the pause screen of the game
public class PauseGame extends CurrentScreen{
  private int exitButtonX = 100, exitButtonY = 75, backButtonW = 140, backButtonH = 50; 
  private boolean exitOver = false;
  private int buttonWidth = 160, buttonHeight = 40;
  
  PauseGame(){}
  
  
  // Displays the pause screen
  public void display(){
    image(game.pause, 0, 0, width, height);
    //textAlign(CENTER);
    cursor();
    //fill(255);
    //textSize(20);
    //text("Press enter to restart the game", 300, 200);
    //text("or click the exit button to quit", 300, 220);
    
   // Checks if the mouse is over the exit button
   if(overButton(exitButtonX, exitButtonY, backButtonW, backButtonH)){
     exitOver = true;
   }
   else{
     exitOver = false;
   }
    
   textSize(25);
   // Changes the color of the "Back" text if the mouse is over the exit button
   if(exitOver){
     fill(51);
     text("Back", exitButtonX -2, exitButtonY -2);
   } else{
     fill(255);
     text("Back", exitButtonX, exitButtonY);
   }
   
   // If the exit button is clicked, set the game state to 0
   if(mousePressed){
     if(exitOver){
       game.setGameState(0);
       gameOverAudio.pause();
       if(!buttonClickAudio.isPlaying()) { 
            buttonClickAudio.rewind(); 
            buttonClickAudio.play(); 
        }
       game.resetCountdownTime();
       //game.resetPlayersPosition();
       game.setBotPositions();
       game.resetLives();
       game.resetNames();
       game.resetKeyboardType();
       game.setDifficulty(0);
       newPositions();
     }
    }
  }
  
   public void newPositions(){
   game.removeTanks();
   game.removeLandmines();
   game.recreatePlayer();
   game.makeTanks();
   game.makeLandmines();
   game.makeSecondCar();
 }
  
  // Handles key presses
  private void KEYPRESSED(char KEY){
    if(key == ENTER){
      game.setGameState(5);
    }
  }
  
    // Checks if the mouse is over a button
    private boolean overButton(int x, int y, int width, int height){
    if ((sq(mouseX - x))/(sq(width/2)) + (sq(mouseY - y))/(sq(height/2)) <=1) {
      return true;
    } else {
      return false;
    } 
  }
}

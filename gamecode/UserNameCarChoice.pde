public class UserNameCarChoice extends CurrentScreen{
  private int entryX = 300, entryY = 700;
  private boolean backOver = false;
 
  private int backButtonX = 250, backButtonY = 10, backButtonW = 90, backButtonH = 35; 

  UserNameCarChoice(){}
  
  // Render username screen
  public void display(){
    background(173, 216, 230);
    // Render correct screen for single/two player
    if(game.getTwoPlayer() == false){
      displayOnePlayer();
    } else if(game.getTwoPlayer() == true){
       displayTwoPlayer();
    }
    // Check if mouse is over back button
   if(overButton(backButtonX, backButtonY, backButtonW, backButtonH)) {
     backOver = true;
   } else{
     backOver = false;
   }

    // Display back button. If moused over, move image slightly 
    // to provide visual feedback to player
  if (backOver){
      image(game.backText, backButtonX-2, backButtonY-2);
    }
    else {
      image(game.backText, backButtonX, backButtonY);
    }

  // Reset game states if back button pressed
   if(mousePressed){
     if(backOver){
       if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }
       game.setTwoPlayer(false);
       game.resetNames();
       game.setGameState(0);
     }
   }
  }
  
  // Render single player screen and handle name input
  private void displayOnePlayer(){
    game.onePlayerScreen.resize(width, 0);
   image(game.onePlayerScreen, 0, 0, width, height);
    textSize(45);
    textFont(racingFont);
    fill(255);
    textAlign(CENTER);
    text("Player:", 310, 660);
    fill(0);
    text(game.getNames().get(0), entryX + (textWidth("a")/2), entryY + 5);
    textFont(unicodeFont);
    textSize(30);
  }
  
  // Render two player screen and handle name input
    private void displayTwoPlayer(){
       game.twoPlayerScreen.resize(width, 0);
       image(game.twoPlayerScreen, 0, 0, width, height);
       textFont(racingFont);
       fill(255);
       textSize(30);
       textAlign(CENTER);
       text("Player 1:", 220, 670);
       text(game.getNames().get(0), entryX-100 + (textWidth("a")/2), entryY + 5);

       fill(255);
       textSize(30);
       textAlign(CENTER);
       text("Player 2:", 370, 670);
       text(game.getNames().get(1), entryX+50 + (textWidth("a")/2), entryY + 5);
       textFont(unicodeFont);
       textSize(30);
  }
  
  // Check if key has been pressed and
  // carry out changes to game state if needed
  private boolean KEYPRESSED(char KEY){
    if(key == ENTER){
      if(game.getTwoPlayer()){
         if(game.getNames().get(0).length() > 0 && game.getNames().get(1).length() > 0){
            if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
                buttonClickAudio.rewind(); // Rewind the file to the beginning
                buttonClickAudio.play(); // Play the file
            }
            game.wipeEntryScreen();
            game.setGameState(2);
            return true;
         } else if(game.getNames().get(0).length() > 0 && game.enterCount < 1){
            game.enterCount++;
            return true;
         }
      }
      else{
         if(game.getNames().get(0).length() > 0){
            if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
              buttonClickAudio.rewind(); // Rewind the file to the beginning
              buttonClickAudio.play(); // Play the file
            }
            game.wipeEntryScreen();
            game.setGameState(2);
            return true;
         }
      }
    }
    else if(key == BACKSPACE){
      BACKSPACE();
    }
    else{
      if(isUpper(KEY) || isLower(KEY) || isNumber(KEY)){
        addText(KEY);
      }
    }
    return false;
  }
  
  // function to set player names
   private void addText(char text) {
     game.setNames(game.enterCount, text);
   }
  
  // Helper functions
  
   private void BACKSPACE() {
      if (game.getNames().get(game.enterCount).length() - 1 >= 0) {
         game.removeChar(game.enterCount);
      }
   }
   
   private boolean isUpper(char Key){
     if(Key >= 'A' && Key <= 'Z'){
       return true;
     }
     return false;
   }
   
   private boolean isLower(char Key){
     if(Key >= 'a' && Key <= 'z'){
       return true;
     }
     return false;
   }
   
   private boolean isNumber(char Key){
     if(Key >= '0' && Key <= '9'){
       return true;
     }
     return false;
   }
   
   private boolean overButton(int x, int y, int bWidth, int bHeight){
    // if ((sq(mouseX - x))/(sq(width/2)) + (sq(mouseY - y))/(sq(height/2)) <=1) {
      if (mouseX >= x && mouseX <= x + bWidth && mouseY >= y && mouseY <= y + bHeight) {
      return true;
    } else {
      return false;
    } 
  }
}

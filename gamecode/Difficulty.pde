public class Difficulty1 extends CurrentScreen{
  // Define button coordinates and dimensions
   private int easyX = 240, easyY = 320, easyW = 145, easyH = 40;
   private int mediumX = 235, mediumY = 395, mediumW = 145, mediumH = 40;
   private int hardX = 250, hardY = 630, hardW = 100, hardH = 40;
   private int insanityX = 240, insanityY = 705, insanityW = 140, insanityH = 40; 
   private int backButtonX = 250, backButtonY = 10, backButtonW = 90, backButtonH = 35; 
   // Define booleans to track which button the mouse is hovering over
   private boolean easyOver = false, mediumOver = false, hardOver = false, backOver = false, insanityOver = false;
   
  Difficulty1(){}
  
  public void display() {
    // resize background image and display it
    game.diffScreenImg.resize(width, 0);
   image(game.diffScreenImg, 0, 0, width, height);
   cursor();
 
   // Check if the mouse is over any of the buttons 
   if(overButton(easyX, easyY, easyW, easyH)) {
     easyOver = true;
     mediumOver = hardOver = backOver = insanityOver = false;
   }
   else if(overButton(mediumX, mediumY, mediumW, mediumH)) {
     mediumOver = true;
     easyOver = hardOver = backOver = insanityOver = false;
   }
   else if(overButton(hardX, hardY, hardW, hardH)) {
     hardOver = true;
     easyOver = mediumOver = backOver = insanityOver = false;
   }
   else if(overButton(backButtonX, backButtonY, backButtonW, backButtonH)) {
     backOver = true;
     easyOver = mediumOver = hardOver = insanityOver = false;
     
   } else if(overButton(insanityX, insanityY, insanityW, insanityH)){
     insanityOver = true;
     easyOver = mediumOver = hardOver = backOver = false;
   }
   else{
     easyOver = mediumOver = hardOver = backOver = insanityOver = false;
   }
 
 
    // Display buttons. If moused over, move image slightly 
    // to provide visual feedback to player
    
    displayButton(easyOver, game.easyText, easyX, easyY);
    displayButton(mediumOver, game.medText, mediumX, mediumY);
    displayButton(hardOver, game.hardText, hardX, hardY);
    displayButton(insanityOver, game.insanityText, insanityX, insanityY);
    displayButton(backOver, game.backText, backButtonX, backButtonY);
   

   // Check if a button has been clicked
   if(mousePressed){
     if(easyOver){
       game.setDifficulty(1);
       changeDiffOnClick();
     }
     if(mediumOver){
       game.setDifficulty(2);
       changeDiffOnClick();
     }
     if(hardOver){
       game.setDifficulty(3);
       changeDiffOnClick();
     }
     if(insanityOver){
       game.setDifficulty(4);
       changeDiffOnClick();
     }
     if(backOver){
        if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }
       game.setGameState(4);
     }
   }
  }
  
  // function to display buttons
  private void displayButton(boolean buttonOver, PImage buttonImg, int buttonX, int buttonY){
    if (buttonOver){
      image(buttonImg, buttonX-2, buttonY-2);
    }
    else {
      image(buttonImg, buttonX, buttonY);
    }
  }

  // Change the difficulty and start the game when a button is clicked
  private void changeDiffOnClick(){
    backgroundAudio.pause();
    game.resetPlayersPosition();
    game.resetCountdownTime();
    game.setGameState(1);
  }
 
  // Check if a key has been pressed 
  private boolean KEYPRESSED(char KEY){
    if(key == ENTER){
        backgroundAudio.pause();
        game.resetPlayersPosition();
        game.resetCountdownTime();
        game.setGameState(1);
        return true;
    }
    return false;
  }

  // check whether mouse is currently over specified button
  private boolean overButton(int x, int y, int bWidth, int bHeight){
    if (mouseX >= x && mouseX <= x + bWidth && mouseY >= y && mouseY <= y + bHeight) {
      return true;
    } else {
      return false;
    } 
  }
}

public class StartScreen extends CurrentScreen{
  //initialize button positions and sizes
  private int singleX = 50, singleY = 460, singleW = 200, singleH = 35;
  private int twoX = 350, twoY = 460, twoW = 200, twoH = 35;
  private int lbX = 200, lbY = 520, lbW = 200, lbH = 35;
  //initialize button hover states
  private boolean singleOver = false, twoOver = false, leaderboardOver = false;
  //initialize button dimensions
  private int buttonWidth = 160, buttonHeight = 40;


  StartScreen(){}

  public void display(){
    //display cursor
    cursor();
    //set text properties
    fill(0);
    textFont(racingFont);
    textAlign(CENTER);
    textSize(25);

    //set background color and display images
    background(173, 216, 230);
    image(game.StartImage, 75, 50, 450, 350);
    PImage racingCar = loadImage("Data/racing car1.png");
    image(racingCar,50,570,450,200);

    //set difficulty to 1 if it is 0
    if (game.getDifficulty()==0){
      game.setDifficulty(1);
    }

    //check if mouse is hovering over buttons
    if(overButton(singleX, singleY, singleW, singleH)){
      singleOver = true;
    } else if(overButton(twoX, twoY, twoW, twoH)){
      twoOver = true;
    } else if(overButton(lbX, lbY, lbW, lbH)){
      leaderboardOver = true;
    }
    else{
      singleOver = twoOver = leaderboardOver = false;
    }

    //display start button
    if(singleOver){
      fill(51);
      image(game.button, 50, 455);
      //rect(120, 455, buttonWidth, buttonHeight, 20);
      fill(200);
      text("Single player", 150, 484);
    } else{
      noFill();
      stroke(255);
      image(game.button, 50, 455);
      //rect(120, 455, buttonWidth, buttonHeight, 20);
      fill(255);
      text("Single player", 150, 484);
    }

    //display difficulty button
    if(twoOver){
      fill(51);
      image(game.button, 350, 455);
      //rect(320, 455, buttonWidth, buttonHeight, 20);
      fill(200);
      text("Two player", 450, 484);
    } else{
      noFill();
      stroke(255);
      image(game.button, 350, 455);
      //rect(320, 455, buttonWidth, buttonHeight, 20);
      fill(255);
      text("Two player", 450, 484);
    }

    if(leaderboardOver){
      fill(51);
      image(game.button, 200, 515);
      //rect(120, 455, buttonWidth, buttonHeight, 20);
      fill(200);
      text("Leaderboard", 300, 544);
    } else{
      noFill();
      stroke(255);
      image(game.button, 200, 515);
      //rect(120, 455, buttonWidth, buttonHeight, 20);
      fill(255);
      text("Leaderboard", 300, 544);
    }

    //check if mouse is pressed and which button is pressed
    if(mousePressed){
      if(singleOver){
         if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }

        text("Single player", 202, 486);
        game.removePlayer(game.getPlayer().get(1));
        game.setTwoPlayer(false);
        backgroundAudio.play();
        backgroundAudio.loop();
        game.setGameState(4);
      }
      if(twoOver){
        if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }
        text("Two player", 402, 486);
        game.setTwoPlayer(true);
        game.resetPlayersPosition();
        backgroundAudio.play();
        backgroundAudio.loop();
        game.setGameState(4);
      }
    
      if(leaderboardOver){
        if(!buttonClickAudio.isPlaying()) { // Check if the audio file is already playing
            buttonClickAudio.rewind(); // Rewind the file to the beginning
            buttonClickAudio.play(); // Play the file
        }
        text("Leaderboard", 302, 426);
        game.setGameState(7);

      }
    }
  }

  //check if mouse is hovering over button
  private boolean overButton(int x, int y, int width, int height){
    if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }
}

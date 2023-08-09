// This class extends the abstract class CurrentScreen and implements a countdown screen for the game
public class CountDown extends CurrentScreen{
  
  CountDown(){}
  
  // Displays the countdown screen
  public void display(){
    textFont(unicodeFont);
    // Calls the countdown method to update the game screen
    countDown();
  }
  
  // Updates the game screen to display the countdown
  private void countDown(){
    
    // Play sound effect of engine
    if(!engineAudio.isPlaying()) { // Check if the audio file is already playing
          engineAudio.rewind(); // Rewind the file to the beginning
          engineAudio.play(); // Play the file
    }
    
    // Gets the players and bots from the game object
    ArrayList<Player> players = game.getPlayer();
    ArrayList<bot> bots = game.getBots();
    
    // Sets the countdown wait time
    int wait = 3;
    
    // Hides the cursor and sets the background to white
    noCursor();
    background(255);
    fill(0);
    textSize(200);
    
    // Displays the start track image as the background for the countdown screen
    image(game.startTrack, 0, 0, width, height);
    
    // If the countdown hasn't reached zero yet, display the countdown numbers
    if(wait - game.getCountdownTime() > 0){
      text((wait - game.getCountdownTime()), 300, 400); 
    }
    
    // Otherwise, display the "Race!" message
    if(wait - game.getCountdownTime() == 0){
      text("RACE!", 300, 400); 
    }
    
    // Displays the player and bot images on the screen
    Player player1 = players.get(0);
    image(game.playerImg, player1.getPositionX(), player1.getPositionY(), player1.getWidth(), player1.getHeight());  
    
    // If there are two players, display the second player's image
    if(game.getTwoPlayer()){
      Player player2 = players.get(1);
      image(game.pinkBotImg, player2.getPositionX(), player2.getPositionY(), player2.getWidth(), player2.getHeight());  
    }

    // Display the bot images
    for (bot bot: bots){
      image(game.blueBotImg, bot.getPositionX(), bot.getPositionY(), bot.getWidth(), bot.getHeight());
    }

    // If the countdown time is greater than the wait time, stop the countdown and reset the game state
    if(game.getCountdownTime() > wait){
      game.stopCountdown();
      game.resetTime();
      game.setGameState(5);
    }
  }
}

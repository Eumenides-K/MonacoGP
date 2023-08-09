# Use Case Specifications for Monaco GP 1979

Please also note the [use case diagram](https://github.com/UoB-COMSM0110/2023-group-11/blob/main/RequirementsDocs/UseCaseDiagram-MonacoGP.pdf).

### Use Case: Selects single player or two player

This use case is where the main player (player 1) selects the number of players in the system.

#### Basic Flow:

1.  On the first boot up page there will be two options of single player or multiplayer. The player must select one of them with the cursor to continue.

#### Alternative flows:

None, the player will not be able to proceed without selecting an option.


### Use Case: Enters Name

This use case step is where the player enters their name into the program to allow the score to be recorded and eventually entered into the leaderboard. Duplicate names are allowed. The player will also find out which car they are at this stage.

#### Basic Flow:

1.  On the user name entry page the user will start typing their name (it will be automatically entered as the name box will be pre-selected by the system so ready for the user to start typing).
    
2.  The user will press enter to save their name into the system and proceed to the next page.

#### Alternative flows:

None, a name must be entered to proceed.
In two player mode steps one and two will be repeated
    
  
### Use Case: Selects difficulty

This is where the player (or one of the multiplayers) selects the difficulty level they wish to play.

#### Basic flow:

1.  The player will be presented with at least three options for difficulty
    
2.  The player will select one of these options by clicking the option with the cursor
    
3.  The player will then be able to proceed by pressing enter key.
 
#### Alternative flows:

1.  If the player attempts to proceed without selecting a difficulty level the difficulty will be set to easy/beginner (the lowest level).
    
2.  The player will be able to proceed by pressing enter key.
    

### Use Case: Starts new game

On the difficulty menu the player will press enter to proceed to the countdown page.

#### Basic flow:

1.  The player press enter on the difficulty page to start a new game and go to the countdown page.
   
#### Alternative flows:

None.


### Use Case: View countdown page

Before the game starts the countdown page will give the player a chance to work out their position.

#### Basic flow:

1.  The player will have a brief moment in the countdown to prepare for the start of the game.
    
2.  After three seconds the race will start.

#### Alternative flows:

None.
 

### Use Case: Plays the game

This is the use case for actual game play.

#### Basic flow:

1.  The player will avoid the bots, other player (if there is one), landmines and tanks by driving forward, back, left and right. If the player stops driving the car will move back at the speed of the track.
 
#### Alternative flows:

1a. Press enter key to pause the game.

1b. At the hard difficulty level and not in multiplayer the keys will change at 10 second intervals.


### Use Case: Views score

Included in plays game use case

#### Basic flow:

1.  During game play the score(s) of the player(s) will be displayed in the top left hand corner of the screen.

#### Alternative flows:

None.


### Use Case: Views lives left

Included in plays game use case

#### Basic flow:

1. During the game play the player will be able to view the number of lives left by looking in the top right hand corner.

#### Alternative flows:

None.


### Use Case: Hits other object

Included in plays game

#### Basic flow:

1.  If the player car hits another object (being a landmine, tank, bot car or player car in two player mode) then the player

#### Alternative flows:

None.


### Use Case: Loses life

Included in hits other object

#### Basic flow:

1.  If the player has more than one life left then hitting another object will remove a life.

#### Alternative flows:

None.


### Use Case: Dies (if no lives left)

Included in hits other object

#### Basic flow:

1.  If the player has just one life left then hitting another object will end their game.

#### Alternative flows:

1.  If in two player mode and one player dies then the game ends as well with the survigin player declared the winner.


### Use Case: Game Over page

After the player (or players) has run out of lives the game will end and the game over screen will appear.

#### Basic flow:

1.  The scores will be automatically entered into the global leaderboard.
    
2.  The game over screen will present the player(s) scores and the top three from the global leaderboard.
    
3.  If the player (or one of the players) has beaten a score in the top three this will be immediately reflected in the top three leaderboard.

#### Alternative flows:

1. In two player mode the score will not be entered into the leaderboard and the leaderboard will not be displayed but the winning player (that still alive) will be shown on screen.
  

### Use Case: Start new game

Included in the game over page. The player(s) can start a new game with the same setting as the previous game.

#### Basic flow:

1.  Select “new game” to start a new game with the same settings as before. The countdown page will appear immediately.

#### Alternative flows:

None.
  

### Use case: Return to start screen.

Included in the game over page. The player(s) can decide to return to the start screen where the single or two player options are displayed.

#### Basic flow:

1.  Select “menu” button and return to the start screen. The system settings (names, difficulty) will be wiped.

#### Alternative flows:

None.

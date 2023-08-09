# Monaco GP game

# Table of contents
1. [Preface](#1-preface)
2. [Introduction](#2-introduction)
3. [Requirements](#3-requirements)
4. [Design](#4-design)
5. [Implemetation](#5-implementation)
6. [Evaluation](#6-evaluation)
7. [Process](#7-process)
8. [Conclusion](#8-conclusion)

## 1. Preface
This is a five-student group project for a course in University of Bristol MSc Computer Science. I was the lead designer of the game (while two other students are the git master and the lead HCI evaluator). I designd the overall framework and made UML diagrams. I also contributed around 30% of code, implementing key features such as the real-time timer, leaderboard, gameplay logic and sound effects.

Following is the original group report. To protect personal privacy, any content related to personal information has been deleted.


## 2. Introduction

Our game is based on the classic SEGA arcade game, Monaco GP 1979. The original game was a top-down 2D racing game where players drove a car up an infinite track dodging other cars and trucks whilst avoiding the sides of the track. Our game has adapted the original with several added twists to make the game more engaging and challenging. In addition to dodging other cars, the player must avoid landmines and tanks, which appear at random intervals on the track.  

![single player game play](/reportDocs/onePlayerIntro.gif)

There is also a keyboard control change for higher difficulty levels to add a further challenge for the player. Finally, we have provided three lives for the players to extend gameplay for a novel game. We have also added a battle mode allowing the user to play the game with a friend; battle mode is a twist on a traditional two-player racing game where the car that survives the longest wins and instead requires both players to stay alive to continue the game.

![two player game play](/reportDocs/twoPlayerIntro.gif)

This change to the two-player mode will make the game more enjoyable by creating a battle mode for the players.


## 3. Requirements

#### Creativity process

To begin with, each of us came up with several game ideas (with or without twists) for consideration in the workshop on 30 January ([long list](/reportDocs/RequirementsDocs/LongListOfGames.pdf)).  At this point, we agreed on a shortlist of Doodle Jump and Monaco GP 1979. To assist our later decision process, we developed paper prototypes of each game  ([Monaco GP 1979](https://www.youtube.com/shorts/g2PBC5isGMA), [Doodle Jump](https://www.youtube.com/watch?v=AVdVxuHUMBE)) to clearly show how the game would progress and how the twists would be applied in gameplay. Then, at a meeting on 8 February, we discussed each of the shortlisted ideas and attempted to consider the potential challenges that would arise in development.

#### Doodle Jump considerations

The chief considerations for Doodle Jump related to the twist suggestion where the gravity would change at certain points through the game. After some discussion, we agreed that whilst the twist would be amusing, we decided this would be overly challenging from both a user's and the developers' perspective.  The user would be playing this game on a laptop or desktop and would need to twist their head to continue playing it after a gravity change or have excellent coordination. For us as developers, the gravity change, where the gravity direction would switch to make the character jump across or down the screen instead of up the screen, was viewed as a considerable challenge to code and wouldn't offer much value to the game in terms of enjoyment.

#### Monaco GP 1979 considerations

Our concerns with Monaco GP were mainly about ensuring the game was fun and exciting to play. We believed that the planned twists for Monaco of other unexpected objects appearing on the track to kill the player, combined with a keyboard change at higher difficulty levels, should elevate the game above its original inspiration and make it more interesting. Therefore, early in the design process, we decided that the challenges for coding Monaco GP would be a persistent leaderboard, two-player mode, and an infinite track.

#### User stories, use case diagram and use case specification

Before developing the use case diagram and use case specification, we considered the [user stories](/reportDocs/RequirementsDocs/UserStories.md) for the different types of players. With several included below:

<em>As a player in multiplayer mode, I want to play a fun, exciting, and new game to enjoy my free time with others.</em>

<em>As a player, I want to enter a username so that my score is linked to me so that I can show off my abilities to my friends.</em>

<em>As a player, I want a persistent leaderboard so that my high score will persist between program exits.</em>

<em>As a player, I want to play a game that looks retro and stylish so that I can dive into it.</em>

<em>As a player, I want to try several difficulty levels so that I can have different experiences and be further challenged by the game.</em>

![Use case diagram](/reportDocs/RequirementsDocs/useCaseDiagram.png)

Figure 1: Use case diagram for our version of Monaco GP 1979

The final stage of the requirements process that we completed was the [use case diagram](/reportDocs/RequirementsDocs/useCaseDiagram.png) and [use case specifications](/reportDocs/RequirementsDocs/UseCaseSpecification.md) for our selected game, Monaco GP 1979. From the development of the use cases and the user specification, we developed the functional requirements for the system.

#### Functional requirements

##### Statement of services
The game should provide one or two players with a top-down 2D racing game where the players drive a car along a rolling road track dodging tanks, landmines, and other cars whilst remaining on the track. The game aims to stay alive as long as possible. The player will be able to select one or two player options on loading the game and view the leaderboard on the Gameover page.

##### System response to inputs

The user can use the mouse to interact with the menu pages of the game and the keyboard to interact with the game itself. The arrow keys and WASD keys are used for single-player and two-player modes. The up arrow (W) accelerates the car, the down arrow (S) decelerates the car, and the left (A) and right (D) arrows move the car across the screen.

##### System behaviour in particular situations

The players each have three lives, which are lost by hitting an object or another car. If the player stops driving forward, the car moves backwards at the track's speed, and if the player tries to drive off the track, they will slow down and rebound back onto the track. The game does not have a win state as it is technically infinite, with the aim of the game being to survive as long as possible. When the player has died, a game over screen is displayed, allowing the player to view the leaderboard and their score, choose to start again with the same settings, or return to the main menu. In two-player mode, the player who has survived the longest will be declared the winner, but the score will not be entered into the leaderboard.

##### Constraints

We decided to add constraints to where the player cars can move following feedback from evaluations. The evaluators believed that the ability to drive on the track's edges was unrealistic. Therefore, in addition to the restrictions on where the car could drive, we also introduced the rollback if the car was not being driven forward, as the evaluators viewed this as more realistic.


## 4. Design

### Class diagram

After selecting our game, we drafted a rough class diagram similar to the one shown in Figure 2 below, which we tweaked as development progressed and as our initial design estimate met the coding realities. We chose not to follow the typical model-view-controller (MVC) model because of how our design progressed; however, there is a model class and a series of screen classes (all inheriting from one abstract screen class) that act as the Model and View sections of the MVC model.  In addition, the controller part of the MVC model is split between several areas (mouse clicks are received in the screen classes and keyboard entry in the main class).

![Class diagram](/reportDocs/DesignDocs/classDiagramLatestUpdated.png)

Figure 2: Class diagram for Monaco GP 1979.

For the view part, we have an abstract parent class called CurrentScreen which denotes the current screen being displayed by the game model. There are eight child classes of CurrentScreen shown in the figure above. Each corresponds to a different screen shown to the player at a particular time and is replaced by another screen when the game state changes.  All these classes have a basic method called "display()", which draws the corresponding screen. In addition, those screens with buttons on have methods to detect whether the mouse is over the button to enable clicks to be correctly registered. Players can use the keyboard on some screens to interact with the game. For instance, using the enter key, you can pause the game during gameplay or select the default easy difficulty on the difficulty choice page.

The Model class holds all the object instances, representing different types of obstacles and racers in the game and the track. As shown in the abstract Object class, each object instance can move across the screen and detect crashes with the objects.   The Bot, Tank, and Landmine classes are all relatively similar and roughly follow this design with some tweaks for how the objects move across the screen. The Player class, however, has additional attributes, including "name" and "lives", some methods to control the keyboard input and a specialised crash detector method which we will explain below. Every player has three lives; players lose lives in crashes. In addition, two instances of the RealTimeTimer class exist among the Model's attributes. The countdown screen uses one before each gameplay as a countdown, and the other is used during the gameplay to calculate the score and handle the keyboard changes in difficult mode. Finally, there is also a Track class attribute with a running speed which depends on the difficulty level.

### Sequence diagrams

In addition to the class diagrams, which describe the program's structure, we also drafted a series of sequence diagrams showing the order of interactions between the player and the program.

The first sequence diagram shows the menu screens.

![Menus sequence diagrams](/reportDocs/DesignDocs/SequenceDiagramsMenus.png)

Figure 3: Sequence diagrams showing the progress through the menu screens

As seen above, the menu screens do not hold any information for an extended time. They merely provide an interface to provide information to the Model class to set up the parameters for the program and to hold data to be entered into the leaderboard, such as the player name.

![Game play sequence diagram](/reportDocs/DesignDocs/SequenceDiagramsGamePlay.png)

Figure 4: Sequence diagrams for game play mode

As seen above, during the gameplay, the Model class is less frequently used with the objects interacting with each other and only communicating to the Model when the game state needs to change, such as when a player dies. In two-player mode, both player objects detect a crash with each other concurrently, as shown below in the diagram.

![Two player game play sequence diagram](/reportDocs/DesignDocs/SequenceDiagramsGamePlay2player.png)

Figure 5: Sequence diagram for two player mode(note some sections from one player mode have been curt out)

This override of the parent crash detection method is due to the class structure and how the parent crash detector method runs. This method is constantly called, and in the player class, the only inputs to the crash detector method are objects of the Player class. The other difference is the method in the Model class called to shift the positions of the two players in the event of a crash.  For comparison, the crash detector method in the parent class the object crashed into (i.e. the bot, landmine, or tank) is shifted off the screen if the crash occurs. Although an output like that would not be possible in the player class, it is also not possible to have the x and y positions of both players shifted by the same value, as this would maintain the crash. Therefore the method for moving players in the Model class was created to shift each player a different amount and direction in the event of a crash.

![Activity diagram](/reportDocs/DesignDocs/activityDiagramUpdated.png)

Figure 6: Activity diagram for Monaco GP

The activity diagram above shows the route for a player through the program from start to finish. As can be seen, the flow through the program is relatively straightforward, with several exits allowing the user to change previously set settings and exit the program.


## 5. Implementation

During the requirements process, we identified three challenges we intended to implement in our game: two-player mode, an infinite track and a persistent leaderboard. We succesfully implemented all of these challenges.

### Two-player mode

![Two player cars only gif](/reportDocs/ImplementationDocs/twoPlayerCars2.gif)

Figure 7: gif showing the movement of two player cars on the screen

One of our three challenges was implementing the two-player option, which required us to create multiple instances of the player class. We needed to have the ability to move them using separate controls independently, keep track of both player objects in the model class, and keep track of the user entries for the name attribute of the player objects so that on the game over screen, we could correctly display the winning player's name.
During implementation, we encountered a significant challenge in continuing gameplay after one of the players died. Since an ArrayList is used to store the Player objects in the model class, and due to early design decisions affecting how we created the movement and gamePlay methods, there was a significant issue in safely removing one player from the screen whilst continuing to play for the other, live player.  Due to this, we decided to convert the two-player mode into a battle mode and end the game at the first player's death, with the winner being the surviving player. We accept that this is a restriction to the scope of the gameplay. Still, it has been an important learning point for us as a group, as it has helped teach us the necessity of proper planning before jumping into the implementation.

### Infinite Track

![infinite track gif](/reportDocs/ImplementationDocs/trackGif.gif)

Figure 8: gif showing infite scrolling track (note the track image used above is one screen height tall unlike game play which is many of these tracks stitched together)

One of our challenges was smoothly looping the background track image to give the impression of an infinite track. Although the final code was relatively simple in terms of implementation, it took a lot of work to achieve the desired result. During our first evaluation, users noted that the track was moving up the screen instead of down, making it seem like the cars were moving backwards along the track and that the track seemed to jitter and slow down when it reached certain parts of the track image.
To resolve this, we rewrote the code to update the current track position for every frame based on the player's speed. First, we calculated the y-coordinate for the top of the track (yTop) using the modulus of the image height, then copied part of the track image, starting at the yTop value, onto the screen.  Again, we used the modulus to ensure the value remained within the image height bounds. Finally, we implemented a check that copied the remaining part of the image onto the screen portion that would otherwise be blank at specific values. All of this enabled the background to scroll smoothly and infinitely, creating the result we had hoped for during our planning process, as shown in the gif above. The final code is included below; as is clear, it is a relatively straightforward method; however, it took some work for us to figure it out.

![Infinite track code screenshot](/reportDocs/ImplementationDocs/moveTrackSnip.png)

### Persistent leaderboard

![Persistent leaderboard screenshot](/reportDocs/ImplementationDocs/Leaderboardscreenshot.png)

Figure 9: screenshot of the game over screen showing the leaderboard

Our final challenge was a persistent leaderboard that maintained its data across program exits and restarts. To implement this, we knew we would have to read and write to an external file to save the scores and names instead of being deleted when the program stopped.
We use an external CSV file to save player names, scores and dates, accessed and modified using Java's built-in file IO methods. During game setup, the program checks if the results file exists, creating the file if not. If it does exist, the score data is loaded from the CSV file and saved to a table object as part of the game model object. The code implementing this is included below.

![Code snippet for leaderboard creation](/reportDocs/ImplementationDocs/leaderBoardLoadTable.png)

When the game state transitions to the game over screen, the user's name, score, and date are added to the results table. The table is then re-sorted to rank the new score in the table correctly and subsequently saved to the results file. Finally, the screen displays the top three results from the file as the leaderboard. The challenge in coding this was to ensure that the action (making a file, adding to a file etc.) was only performed once per game state change.  The "draw()" method in Processing is continually called, which makes this a challenge. The code to add the latest result to the leaderboard, re-sort and then export the top three to the game over screen is included below.

![Add row, re-sort and extract top three code snippet](/reportDocs/ImplementationDocs/leaderBoardCreateRows.png)

In addition to the three challenges mentioned above, we noticed our program had issues with a slow boot-up time. This slow boot time was confusing as the program is not large, with minimal files and libraries imported. Despite our best efforts, this remains an issue which, given the opportunity, we would work on if developing the game further.


## 6. Evaluation

As part of our software development process, we carried out evaluations at two stages of the development cycle: the minimum viable product (MVP) stage and the mid-development stage. Our goal from these evaluations was to ensure that further game development made the game easier to use and more enjoyable.

### Qualitative evaluations

We used the Think Aloud and Heuristic Evaluation methods in our qualitative evaluations ([raw data](/reportDocs/EvaluationDocs/qualitativeData.docx)).  For the Think Aloud, we arranged the information into the following categories:
* Features people liked.
* Features people did not like.
* Features people wanted.

Due to the number of points received in the qualitative evaluations, only the most salient points have been discussed below, as more trivial issues were raised in both the Think Alouds and the Heuristic Evaluations.

#### Minimum Viable Product stage

At this stage in the development cycle, the feedback we received was quite blunt, with evaluators occasionally becoming overwhelmed with an unusable system which reduced their ability to elucidate their views to such an extent that it was difficult for them to express their opinions.

##### Features evaluators did not like
The most common negative feedback we received was about the unclear menu buttons, with no feedback letting users know if clicking was successful. However, the feedback that was most concerning related to the unclear gameplay and win scenario.
##### Features evaluators liked
On a positive note, we received good feedback regarding the existence of a menu screen and the track graphics. In addition, the evaluators were pleased that they were not immediately launched into gameplay upon starting the program.
##### Features evaluators wanted
The evaluators wanted an explanation of how to play the game and a countdown timer to prevent immediate gameplay from starting the game.

##### Conclusion from first qualitiative evaluation
The first evaluation had some interesting results for us. We were pleased with the positive feedback but also concerned with the usability problems. However, the most significant concern for us came from the heuristic evaluation where a player said, "it is was not clear how to play or win the game and what the purpose was".  This comment was a significant failing and of the utmost concern. The negative usability feedback concerning the buttons was also a considerable concern, with usability and ease of navigation our second priority after more explicit guidance on the gameplay.

#### Mid-development stage

At the mid-stage of development, as the most obvious negative features were removed, we found that the number of comments in the Think Aloud increased compared to the MVP stage as the usability appeared to have passed a minimum threshold allowing evaluators to clearly organise and elucidate their impressions of the program.

##### Features evaluators did not like
The most common negative feedback was related to the background art on the menu screens. The evaluators' initial comments on this pertain to menu buttons needing to be clearer, name entry needing to be clearer, and the leaderboard needing to be clearer.  These were all obscured by a poor choice of background art, with further negative feedback on gameplay. The player and the bots' positions at start-up were assigned by random number generation which led to the cars being placed on top of each other on a not irregular basis. This bot placement issue led to the immediate end of the game.
##### Features evaluators liked
Evaluators like the sound, which was a new feature of the game and the reactiveness of the car. The reactiveness of the car was a new feature where a combination of methods allowed the player to use multiple keys at the same time and for the release of the key to stop the car movement.
##### Features evaluators wanted
An explanation of how to play the game and for the score to be immediately entered into the leaderboard instead of at the end of the next game.

##### Conclusion from second qualitative evaluation
Our second evaluation highlighted the need to regularly test a system with its target audience. As developers, we lost sight of the usability problems from background art, as we knew where the buttons and text would appear and we became immune to the issues that the background art caused.


### Quantitative evaluation

We used the System Usability Scale at the MVP stage and the NASA TLX at the mid-development stage; both evaluations were completed on easy and medium difficulty levels. The raw data from the evaluations are [saved here](/reportDocs/EvaluationDocs/quantitativeData.xlsx).

#### Minimum Viable Product Stage

>| System Usability Scale       | Easy | Medium |
>|:-----------------------------|:----:|-------:|
>| Person 1                     | 55   | 32.5   |
>| Person 2                     | 45   | 35     |
>| Person 3                     | 40   | 27.5   |
>| Person 4                     | 62.5 | 60     |
>| Person 5                     | 42.5 | 35     |
>| Person 6                     | 55   | 40     |
>| Person 7                     | 45   | 37.5   |
>|                              |      |        |
>| Wilcoxon Signed Rank W value | 0    |        |

Table 1: table of summarised data from our SUS evaluation

We conducted our first quantitative analysis with an early version of our game which was similar to that used in the first qualitative analysis. It was clear to see that the average SUS scores are low and below the average score of 68. Whilst this was concerning, it was also not surprising as the game was in a very early stage of development at this point. As is clear from the raw data we had a mix of gamers and non-gamers; the gamers typically gave higher usability scores as although the game had issues, they are more used to gameplay on a PC.

#### Mid-Development Stage

>| NASA TLX | Easy | Medium |
>|:---------|:----:|-------:|
>| Person 1 | 52   | 64     |
>| Person 2 | 41   | 64     |
>| Person 3 | 44   | 52     |
>| Person 4 | 33   | 51     |
>| Person 5 | 41   | 58     |
>| Person 6 | 43   | 56     |
>| Person 7 | 28   | 43     |
>| Person 8 | 31   | 46     |
>| Person 9 | 30   | 47     |
>| Person 10| 30   | 47     |
>|          |      |        |
>| Wilcoxon Signed Rank W value | 0 | |

Table 2: table of summarised data from NASA TLX evaluation

The NASA TLX evaluation was completed later in development when the game was mostly complete. As can be seen, the perceived workload is higher at the higher difficulty level for all players; this was expected. In addition, the low average score on the easy level reflects comments made in the qualitative evaluation that the easy level was too easy; following these comments and the results from the NASA TLX above, we adjusted various settings to make it more challenging. It is interesting to note the variations between testers in the NASA TLX score. Our evaluation included a mix of gamers and non-gamers, with the more regular players having a lower perceived workload than those who do not typically game.

#### Conclusions from quantitative evaluations

For the SUS and NASA TLX quantitative evaluations, the Wilcoxon Signed Rank Test W value is 0, signifying that we can be 95% certain that the significant difference between the results from the easy and medium settings is down to real differences as opposed to chance. This W value is expected as the higher difficulty level is more challenging to use than the lower one.

### Code testing

As the game code was written in Processing, which does not support JUnit testing, our testing process was based on gameplay. Therefore, after each feature was merged into the Develop branch, we played the game extensively to ensure that no bugs had been introduced and that the feature operated as planned.


## 7. Process

Over the term, our requirements constantly evolved after testing, user evaluations and team discussions. In addition, we knew that due to our hectic course schedules, we would have to work in short bursts to fit our time around teaching and assessments in term time and that we would need to develop a minimum viable product by the end of our reading week sprint. These reasons contributed to our choice of an Agile-style development process.
Since we were constantly adapting our code, the structure of our game system reflected this constant change; at times, the codebase became messy and confusing as we made several large-scale overhauls of the system design during the project. In addition, our code documentation during the development process was not always clear or extensive – we focused on delivering working code, meaning our documentation coverage suffered as a result.
The process never had a definite end – we constantly developed new features and improvements. Although this meant the product was continually improving, it sometimes made us feel behind, even though we had shipped more than expected.

As stated in the Agile principles, face-to-face communication is best, and we tried to adhere to this principle as much as possible. However, some of the team were out of Bristol, and those of us here made concerted efforts to meet and discuss difficulties and developments in the project. This in-person collaboration improved the quality of our workflow. In particular, pair programming sessions helped elevate our game's code; sessions were typically held when debugging, after features were completed, to test functionality and spot mistakes teammates may have missed.

We held a full-day game jam during reading week and another at the start of Easter break. Both sessions proved invaluable to our development process; we had a chance to discuss our thoughts and plans for the game in detail and were able to talk over problems and issues that we were facing as a group.

When face-to-face meetings were impossible or when discussing minor issues and fixes that didn't require a full team meeting, we used a combination of WhatsApp and Teams to communicate and share ideas, which generally worked well throughout the project. However, one drawback of our team process was our decision to use Google Docs and Sheets to organise and assign tasks; see an example screenshot below. Although this didn't prove to be a significant problem in the end, we all agreed that we should have used Kanban boards for task organisation and planning, as shown during lectures; this would have made the distribution of tasks much more straightforward as we ran into difficulties when team members were working on the same job concurrently. The use of Kanban boards would have alleviated these issues considerably.

![Screenshot of work assignment](/reportDocs/ProcessDocs/workAssignmentScreenshot.png)

Figure 10: example screenshot of the work assignment spreadsheet we used

As instructed in the brief, we hosted our project on GitHub; however, how we managed our version control evolved as we became more accustomed to using it. At the start of the project, our use was rather primitive, with a single Develop branch where all work took place. However, we soon encountered problems when different team members were working on the same classes or features simultaneously; at first, this created issues with merge conflicts when we needed to communicate more.

After a meeting during reading week, we decided to create a standard approach. We created separate branches for each new feature and prototype branches for new features that could significantly impact our product. When at least two team members had checked each feature branch, we merged to develop, then pushed and resolved merge conflicts. After testing the new version thoroughly to ensure no losses of functionality, we finally pushed to Main, with a different member approving the pull request. A clear separation of completed code and in-progress sections helped when we ran into issues integrating new features - more than once! Without this, at times, it would undoubtedly have been a headache to find and fix the problem areas.

On reflection, our teamwork and team process developed considerably throughout the project. The use of GitHub to manage version control was vital, and our choice of an Agile-style workflow was the correct one, as it meant that we could still make time for our other modules and commitments but still manage to create a quality product. Group development sessions were also instrumental, both in terms of contribution to the codebase as well as improving our overall teamwork and cooperation.


## 8. Conclusion

This process taught us a significant amount about software development and working as a team. However, taking a brief from our idea to a completed product was challenging, and we made several mistakes.

### Lessons learnt for the future and challenges encountered

As highlighted in the report above, there were several topics taught in this module which had the potential to solve or prevent issues that arose during the process.
Planning poker and the wisdom of crowds had the potential to highlight several significant issues in the code design, which led to substantial overhauls and delays in development. Whilst the utility of planning poker at this stage in our coding careers is uncertain, as our experience grows, this will become extremely helpful.

While we tried to follow the Agile process, we tended not to delineate between sprints, meaning our coding process changed from strictly enforced focused sprints to being dragged out and unfocused over several weeks. In future, we would combine clearer sprints with regular in-person meetings with clear goals of story points to implement for the sprint.
Our use of Git left much to be desired, from an initial lack of understanding of branches to how to link a remote repo to the local repo and correctly set the upstream branch of the local repo branch. That being said, by the end of the process, we were more consistent with making new branches for features such as username entry, two-player mode, and racer classes which, combined with a better approach to merging the branches, ensured the develop branch had working code on it <em>nearly</em> all of the time. The final lesson that several of us still need to learn is to commit to Git more regularly. This habit would provide a more accurate indication of work and offer a fallback point if a new feature breaks the program.
Our work assignment process was relatively informal (as discussed in the process section above). Also, it was based on an insecure, unorganised spreadsheet that merely contained all the points currently being worked on instead of an organised Kanban board with clear swimlanes of "necessary features" or "urgent bug fixes" to list two suggestions. This poor choice of organisation led to confusion when a team member started work on a feature but did not list it on the sheet and push it to GitHub. This also led to inefficiency as it was unclear what required new features and what were more trivial points.
In our last team meeting, where we discussed the lessons learnt and what we would do differently, one item we all agreed we would use in future was UML and the class diagrams. This proved incredibly helpful in providing a clear map of the program's structure and, as it grew, was invaluable to us in working out the impact of new changes to the program.

Breakout Game with twist (Milestone3): Thrilling and exciting heroic experience that where players must devise a game strategy to enhance effectiveness of kills against the elemental monsters while protecting their cities. Players will be rewarded with an indescribable sense of accomplishment when you have successfully kill the monsters and defend their planet.  

# README


## Installation

You can install `Elm` by downloading the installer with the links below and run them directly.

[Linux](https://github.com/elm/compiler/blob/master/installers/linux/README.md)/
[Mac](https://github.com/elm/compiler/releases/download/0.19.1/installer-for-mac.pkg)/
[Windows](https://github.com/elm/compiler/releases/download/0.19.1/installer-for-windows.exe)

More information can be found in [Official Guide](https://guide.elm-lang.org/install/elm.html), 
## Detailed Information

### 1. Usage:
- First, please use ``` cd ``` commands to enter folder of the project. 

- Next, run ```elm make src/Main.elm``` to compile it into index.html file.

- Finally, open the index.html file.

### 2. Features:
- Strategic gameplay with Elemental monsters and bullets 
- Elemental attributes create an addictive gameplay
- Neon-themed sci-fic graphics
- Rounded monsters to increase unpredictablity of ball and thrill for players
- Moving monsters to apply both time and scoring pressure on players
- Intricately designed scoring and reward system that will incentivize players to beat their high scores 
- Heroic storyline and fascinating adventure within the game

### 3. Game Operations
- press `space` to shoot one ball
- use `←` `→` to control the paddle to bounce the ball
- press `s` to skip the level
- press `Enter` to skip the Logo animation and narrative scenes

### 4. File Description
#### Main
- Call init, update, view and subscription to run the game

#### Model
- The definitions of Model
- All init functions

#### Update
- Most update functions

#### View
- This file contains the view function for all the game states

#### ViewPlaying
- This file contains the view function for the playing (fighting) states

#### ViewScenes
- This file contains the view function for all the scenes (Logo cover, narratives and clearLevel)

#### Bounce
- Functions related to bounce between balls, monsters and the paddle

#### Paddle
- Functions related to the movement of the paddle
#### Scoreboard
- Functions to get and calculate the score

#### MyElement
- Translate `Element` and `String` from one to the other

#### Message
- All messages that are generated in the game update

#### Data
- Common data types and useful tools

#### Color
- Functions to change colors

# Author team: **ACE Studios**

**Team members:**

Ekkanat Tanchavalit

Jovan Yap

Wang Yijun

Yuan Jiale

# License 
[SilverFocs Incubator Licence](https://focs.ji.sjtu.edu.cn/silverfocs/markdown/license)
Project 1: A modified breakout game with unique interesting features designed by our team.

# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

## [m3.9] -- 2022-06-18

### Added
- Team Logo
- Booklet

### Changed
- More smooth paddle
- Updated contents
- Change the background music
- Reconstruct the viewScene function

### Fixed
- Resize problems
- Restart errors
- Code quality
- Scene Model bugs

## [m3.8] -- 2022-06-17

### Added
- Boss Level
- Boss generating monsters
- Fancy glass-like covers for monsters and the boss
- Fancy appearance of the balls

### Fixed
- clearLevel bugs

## [m3.7] -- 2022-06-16
### Added 
- Bonus score
- Monster hit surface
- Boss features, including data type, moveBoss, updateBoss, viewBoss, viewBossCover
- Type State
- changeOpacity
- Different contents in different scenes
- viewClearLevel
### Changed
- renderbuttons
- view scene1-5 to scene Int
- reset the score and view the score

### Removed
- viewPlaying 2-5

### Fixed
- Shooting the balls


## [m3.6] -- 2022-06-15
### Added 
- Pictures for the cover, background, clearlevel and the scene 
- `update` and `view` functions of the scenes and scene switching
## [m3.5] -- 2022-06-15
### Added 
- Move the monster
- Generate the initial ball list

## [m3.4] -- 2022-06-15
### Added 
- Monster lives
- Vector and matrix operation
- Rounded bounce
- Protection cover

### Changed
- Overall, code simplified
- Types and monster are changed into monster
- 
### Fixed
- Only one ball can change its element

## [m3.3] -- 2022-06-14
### Added 

- Data.elm: store common data types and parameters
- Element system: including union type `Element`, the effective-weak damage between elements and the `changeElement` function implemented on the monster and the ball
- Teleport the paddle to the first landing-point of the ball  

### Changed

- The bounce machanism between balls and the paddle: the ball will change its reflection angle when hitting different positions of the paddle.

### Bugs
- Only one ball can change its element

## [m3.2] -- 2022-06-13

### Added 
- Added assets folder to store images used for our project
- Added cartesian.elm folder to store helper functions 
- Added Starting, Playing1 and Scene Narrative to State type
- Added Playing1 so that we can shift between levels for the state (scalability of codes)
- Added restartModel function in model to trigger a newgame 
- Added viewplaying.elm file to store all the helper functions
- Added Renderbutton, viewPaddle, viewBase, viewBall functions
- Added images into viewPaddle, viewLife, viewBricks and view functions 
- Added viewStarting, viewPlaying, viewGameover functions

### Changed
- Changed brick height to 60 
- Changed pixelheight to 1200
- Number of rows of bricks changed to 3
- Number of lives changed to 5 
- Changed (initModel, cmd.none) to ( restartModel, Task.perform GetViewport getViewport ) to fix bug 
- View.elm only contains major viewStates and view functions
- Improved and optimized all the view functions 
- Changed view model to view based on the states

### To-do 
- Add audio file and size 
- Add different levels to scale up the code
- Add narratives and other levels
- Debug the code and improve the game mechanics


## [m3.1] -- 2022-06-12

### Added

- import Random module
- Ball generator system including `generateBall`, `lowestBricks`, `lowestBrickCol`, and `sameColumn` functions to find the lowest brick of each column and randomly generate a ball under it
- Add second ball and change the name to `ball1` and `ball2`

### Changed
- Modified `bouncePaddle`, `bounceScreen`, `bounceBrick`, and `moveBall` functions to be compatible with two balls
- Modified `view` function to be able to view two balls.

### Removed
- Removed `countBricks` function because it can be simply replaced by `List.length model.list_brick`

## [m2.7] -- 2022-06-11

### Added

- Resize according to the size of the player's windows. In `Update`, `View` and `Main`

## [m2.6] -- 2022-06-07

### Changed

- Move the codes that check the velocity of ball during the bounce into specific `checkBounceXXX` functions to simplify the implementation of `newBounceVelocity` function and make the layer of the structure clearer.

### Fixed

- Bugs of unexpected result of bounce with bricks and the top edge of the screen are fixed.

## [m2.5] -- 2022-06-07

### Added
- getBrick_Score function in Scoreboard.elm 
- This function takes in list brick to acquire the brick_score that player will acquire by destroying brick
- getBrick_Score function will then output the score of the brick
- added Start in type Msg
- added type State including Playing, and Gameover
- added state in Model type alias
- added state = Playing in initModel function
- added case msg: when receive Start -> initModel, _ -> same
- added checkEnd function to reduce player's lives whenever the ball is dropped, and when lives = 0 or there is no brick, win the game.
- added countBrick function to count existed brick
- added brickExist function as a helper function for countBrick function
- in viewLife function SvgAttr.fill random color corresponded to the ball by using functions in Color.elm
- added newGameButton function to draw a button that send Start message.
- added if model.state == Gameover then show new game button, else same.

### Changed
- Edited the bounceBrick function to update the scoreboard in the model 

## [m2.4] -- 2022-06-04

### Added
- Type Bounce with Back
- Check the bounce more in detail
- Color type
- Colorful ball
### Changed
- merge the parts of the paddle and the bounce (ball and bricks)
- Rename `checkBounce` function as `bounceFunc`
- Rename `Kick` into `Hit`
- Split Milestone2.elm into sub .elm files to follow the layer programming

### Fixed
- Make the motion of paddle more smooth
- Sometimes unexpected result appear when the bounce happens, like stuking in the wall or the paddle

## [m2.3] -- 2022-06-04

### Added

- Type Bounce with Horizontal, Vertical and None

- New varient of type `Msg`: `Kick ( Int, Int )`

- Functions `changePos`, `moveBall`, `bounceVelocity` and `checkBounceBrickList`

### Changed

- Use the horizontal and vertical components `v_x` and `v_y` of velocity of the ball rather than its speed `speed` and the angel of its speed `theta` with the horizontal direction.

- Rename `checkBounce` function as `bounceFunc`

- Split `checkBouncePaddle` into `bouncePaddle` and `checkBouncePaddle` and so does `checkBounceScreen` and `checkBounceBrick`.

### Fixed

- Realize the bounce between ball and paddle, ball and brick, as well as ball and the edge of the screen except the bottom.

- Make the move of paddle independent with time

### Bugs

- To make the motion of paddle more smooth, we are going to adjust the `Msg` to detect the press down state of "Key Left" and "Key Right"

- Sometimes unexpected result appear when the bounce happens, "Bounce" part is to be improved in detail later.

## [m2.2] -- 2022-06-01

### Added 

- Type Msg with Key Dir, Key_None and Tick 

- Update, updatePaddle, updatePaddleDir functions

- UpdateBall, checkBounce, checkBouncePaddle, checkBounceScreen functions

- ViewScore, viewLife, viewLives functions

- Subscriptions and key functions 

### Changed 

- Velocity of ball from 1 to 0.3 because it was too fast 

### Bugs

- Did not use tick to update the paddle at first and it was not smooth. Hence we used tick to update the paddle but it keeps moving to one direction continuously 

- Ball cannot bounce off the paddle and other surfaces properly

### Learning Points 

- Based on others' Breakout and Tetris models, they all use type alias as few as possible since it is easier to access model properties (so when writing a function, we can only let the model be an input.)

- Key Left/Right is only used to change the direction of the paddle

- Use onKeyDown and onKeyUp to make the paddle move when holding a key, and make the paddle stop when releasing the key.

- Ball Paddle and Brick position are all (float, float) which is hard to compare the position between these objects (sometime the ball sink into the paddle, then bounces out. It looks weird.)


## [m2.1] -- 2022-05-29

### Added

- Type alias Ball

- Init Ball

- Scoreboard 
## [m1] -- 2022-05-29

### Added

- Functions to initialize the bricks, the paddle, and the ball.

- View functions to draw bricks, the paddle, and the ball.

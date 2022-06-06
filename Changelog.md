Project 1: A modified breakout game with unique interesting features designed by our team.

# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

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

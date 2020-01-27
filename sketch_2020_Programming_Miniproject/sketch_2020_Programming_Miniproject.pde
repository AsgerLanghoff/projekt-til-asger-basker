// ATARI BREAKOUT (made with a lot of help from my best friend processing reference)
//primitive, composite
//sounds&images------------------
color background = #000000;
import processing.sound.*;
SoundFile ping;
PImage heart;
PImage galaxy;
//-------------------------------

//ball & ball-variables----------
ball b; //defines a ball called 'b'
int ball_x = 800; 
int ball_y = 500;
float ball_r = 20; //radius of ball
float speed_x;
float speed_y = 15;
//-------------------------------

//paddle & paddle-variables------
paddle p;
float paddle_y = 900; //position of the paddle
float paddle_w = 200;
float paddle_h = 20;
//float offset = 100; //offset from the bottom of the screen. This is no longer used
//------------------------------

// brick stuff------------------
//tutorial used to make the 2D-array https://processing.org/tutorials/2darray/
brick [][] brick_grid; //defining the brick array
int brick_c = 8; //columns, 
int brick_r = 5; //rows
float brick_x = 200; //x-coordinates of the brick
float brick_y = 75; //y-coordinates of the brick
float brick_w = 195; //width of brick, less than x value to make space
float brick_h = 70; //height of brick, less than y value to make space
float remove = -100; //coordinates where the dead bricks are removed to
//------------------------------

//scoreboard--------------------
int score = 0; //start score
score scoreboard; //decl
score hearts;
score hearts2;
score hearts3;
int hearts_x = 1500;
int hearts_y = 900;
int hearts_o = 70; //offset
int life = 3; //max lives

boolean died = false; //boolean checking if dead or not

String reset = "press space to reset";
int string_x = 300;
int string_y = 450;
int string_o = 250;
int string_size = 100;
String final_score = "score:";
String win = "YOU WIN!";
int max_score = 40; //rows * cols
//------------------------------

//trail ------------------------
//tutorial used: https://processing.org/tutorials/arrays/
int num = 10;
int[]trail_x = new int[num]; //array that stores x-positions
int[]trail_y = new int[num]; //array that stores y-positions
int index_p = 0; //index position


void setup() {
  size(1600, 1000);
  galaxy = loadImage("galaxyimg.jpg");
  ping = new SoundFile(this, "ping.mp3"); //making the sound
  heart = loadImage("heart.png");

  scoreboard = new score();
  b = new ball (ball_x, ball_y, ball_r, speed_x, speed_y); //constructs ball b
  brick_grid = new brick[brick_c][brick_r];
  hearts = new score(hearts_x, hearts_y);
  hearts2 = new score(hearts_x-hearts_o, hearts_y);
  hearts3 = new score(hearts_x-hearts_o*2, hearts_y);

  for (int i = 0; i < brick_c; i++) { //initializing the array values
    for (int j = 0; j < brick_r; j++) {
      brick_grid[i][j] = new brick(brick_x * i, brick_y * j, brick_w, brick_h);
    }
  }
}

void draw() {
  background(background);
  //image(galaxy, 0, 0, width, height); 
  //the image made the game lag
  p = new paddle(paddle_y, paddle_w, paddle_h); //paddle

  scoreboard.display();


  if (life > 0) { //only displays ball if we have more than 0 lives
    b.display(); //displays the ball
  } 
  p.display(); //displays paddle
  b.bounce(p); //makes ball bounce off paddle

  //hearts and lives---------------------------------
  if (life == 3) { //heart is only displayed when 3 lives
    hearts3.lives();
  }
  if (life>1) { //life is displayed when 3 & 2 lives
    hearts2.lives();
  }
  if (life>0) { //is displayed 
    hearts.lives();
    
  }
  if (life < 1) { //when lives is below 1, sets died to true, tells you what to do

    died = true;
    textSize(string_size);
    text(reset, string_x, string_y);
    text(final_score, string_x, string_y + string_o);


    //sets life to 3 if you press spacebar, but only if lives is less than 1 sets died back to false
    if (keyPressed && key == ' ') {
      life = 3;
      died = false;
      score = 0;
    }
  }
  //if (score >= max_score) {
  //textSize(string_size);
  //text(win, string_x, string_y);
  //text(final_score, string_x, string_y + string_o);
  // }

  //making the trail---------------------------
  //circular buffer, reads in a new order every frame as opposed to the linear
  trail_x[index_p] = ball_x; //sets the arrays index position to th balls x-coordinate
  trail_y[index_p] = ball_y;
  index_p = (index_p + 1) % num; //cycles the index position 0 and the number of elements (in this case 10) puts them in the array
  for (int i = 0; i < num; i++) {
    int pos = (index_p + i) % num; //accesses the values in the array
    float r = (ball_r-5 + i); //makes the radius smaller and smaller, has magic number, should be changed
    int transparency = (100-i*2);
    noStroke();
    fill(#0000FF, transparency);
    ellipse(trail_x[pos], trail_y[pos], r, r); //makes ellipses that has the x and y coordinates of the ball, just pushed
  }
  //--------------------------------------------

  for (int i = 0; i < brick_c; i++) { //drawing bricks on the array values, could have used array.length
    for (int j = 0; j < brick_r; j++) {
      brick_grid[i][j].display(); //function that displays bricks in the grid
      b.back(brick_grid[i][j]); //function that makes the ball bounce of the bricks
      b.reset(brick_grid[i][j]); //function that resets the widths and heigths of the bricks so they are all displayed
    }
  }
}

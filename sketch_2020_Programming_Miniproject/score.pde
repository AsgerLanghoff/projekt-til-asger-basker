class score {
  float score_x = width/2;
  float score_y = height/2+200;
  int heart_x;
  int heart_y;
  int heart_size = 50;
  int opacity;
  
  score(){ //constructor polymorphism
  }
  
  score(int h_x, int h_y){ //constructor
    heart_x = h_x;
    heart_y = h_y;
  }

  void display() {
    textSize(200); //magic number oh no
    if(died == true){ //sets the opacity of the score to 100% when dead
      opacity = 255;
    }
    if(died == false){
      opacity = 90;
    }
    fill(#FF0000, opacity);
    text(score, score_x, score_y);
    
  }

  void lives() {
    image(heart, heart_x, heart_y, heart_size, heart_size);
  }
}

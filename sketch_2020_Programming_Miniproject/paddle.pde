class paddle {
  float p_x;
  float p_y;
  float p_w;
  float p_h;
  color paddle_color = #FFFFFF;
  float p_m = mouseX;

  paddle(float temp_y, float temp_w, float temp_h) {
    p_y = temp_y;
    p_w = temp_w;
    p_h = temp_h;
  }


  void display() {
    fill(paddle_color);
    rectMode(CENTER);
    p_x = mouseX; //paddles x-value is set to 
    rect(p_x, p_y, p_w, p_h);
  }
}

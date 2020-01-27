class brick {
  float br_x;
  float br_y;
  float br_w;
  float br_h;
  color brick_color = #00C930;
  boolean hit;

  brick(float brx, float bry, float brw, float brh) {
    br_x = brx;
    br_y = bry;
    br_w = brw;
    br_h = brh;
  }

  void display() {
    fill(brick_color);
    rectMode(CORNER);
    rect(br_x, br_y, br_w, br_h);
  }
}

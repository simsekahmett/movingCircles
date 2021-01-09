class movingCircle {
  float x; 
  float y;
  float xSpeed; 
  float ySpeed; 

  float circleSize; 

  float colorR;
  float colorG;
  float colorB;

  movingCircle(float xPos, float yPos, float csize, float _colorR, float _colorG, float  _colorB) {
    x = xPos;
    y = yPos; 
    circleSize = csize;

    colorR = _colorR;
    colorG = _colorG;
    colorB = _colorB;

    xSpeed = random(-10, 10); 
    ySpeed = random(-10, 10);
  }

  void move() {
    x += xSpeed; 
    y += ySpeed;
  }

  void checkCollision() {
    float r = circleSize/2; 

    if ( (x<r) || (x>width-r)) { 
      xSpeed = -xSpeed;
    }  

    if ( (y<r) || (y>height-r)) { 
      ySpeed = -ySpeed;
    }
  }

  void drawCircle() { 
    fill(colorR, colorG, colorB); 
    ellipse(x, y, circleSize, circleSize);
  }

  void moveToCenter() {

    if (x < (width/2))
      x += 3;
    else if (x > (width/2)) {
      x -= 3;
    }

    if (y < (height/2))
      y += 3;
    else if (y > (height/2)) {
      y -= 3;
    }
  }

  boolean isCentered() {
    if (x == (width/2) && y == (height/2))
      return true;
    else
      return false;
  }
}

// create an empty array for 3 movingCircle objects
movingCircle[] myCircleArray = new movingCircle[3]; 
sound ping;

void setup () 
{
  size(1000, 1000);
  smooth();

  ping = new sound();
  // and actually create the objects and populate the 
  // array with them
  myCircleArray[0] = new movingCircle(500, 500, 50, 255, 0, 0);
  myCircleArray[1] = new movingCircle(500, 500, 50, 0, 255, 0);
  myCircleArray[2] = new movingCircle(500, 500, 50, 0, 0, 255);
}

void draw () {  
  blendMode(SCREEN);
  background(0);

  int centeredCircleCount = 0;

  for (int i=0; i<myCircleArray.length; i++) {
    if (mousePressed == true)
    {
      myCircleArray[i].moveToCenter();
      if (myCircleArray[i].isCentered())
        centeredCircleCount++;

      if (centeredCircleCount == 3)
        ping.play();
    } 
    else
      myCircleArray[i].move();
    
    myCircleArray[i].checkCollision();
    myCircleArray[i].drawCircle();
    centeredCircleCount = 0;
  }

  {
    for (int i=0; i<myCircleArray.length; i++) {
    }
  }
}

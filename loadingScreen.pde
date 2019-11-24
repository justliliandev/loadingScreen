PImage ballon;
PImage explosion;
color gray = color(30, 30, 30);
int x = 0;
boolean locked = false;
boolean filled = true;
int pumpPosition;

int pumpLeft;
int pumpRight;
PVector anchorOff;
void setup() {
  fullScreen();
  ballon = loadImage("ballon.png");
  explosion = loadImage("ballon2.png");
}

void draw() {
  background(gray);

  //Ballon
  if (x < 95) {
    PVector ballonSize = getBallonSize(x);
    PVector ballonPos = getBallonPos(ballonSize);
    image(ballon, ballonPos.x, ballonPos.y, ballonSize.x, ballonSize.y);
    textAlign(CENTER,CENTER);
    textSize(40);
    text(x + "%",ballonPos.x+ballonSize.x/2,ballonPos.y+ballonSize.y/2-20);
  }else{
    PVector ballonSize = getBallonSize(x);
    PVector ballonPos = getBallonPos(ballonSize);
    image(explosion, ballonPos.x, ballonPos.y, ballonSize.x, ballonSize.y);
  }
  //Schlauch
  stroke(0, 0, 0);
  noFill();
  strokeWeight(20);
  beginShape();
  anchorOff = getBallonBottomCenter();
  vertex(anchorOff.x, anchorOff.y - 20);
  bezierVertex(anchorOff.x + 4, anchorOff.y + 132, anchorOff.x + 126, anchorOff.y + 46, anchorOff.x + 166, anchorOff.y + 112);
  bezierVertex(anchorOff.x + 213, anchorOff.y + 190, anchorOff.x + 122, anchorOff.y + 217, anchorOff.x + 81, anchorOff.y + 218);
  bezierVertex(anchorOff.x -25, anchorOff.y + 221, anchorOff.x -4, anchorOff.y + 209, anchorOff.x -49, anchorOff.y + 202);
  bezierVertex(anchorOff.x -113, anchorOff.y + 192, anchorOff.x -164, anchorOff.y + 195, anchorOff.x -196, anchorOff.y + 167);
  bezierVertex(anchorOff.x -245, anchorOff.y + 125, anchorOff.x -228, anchorOff.y + 3, anchorOff.x -310, anchorOff.y -13);
  endShape();

  //Pumpe
  stroke(0, 0, 0);
  noFill();
  strokeWeight(20);
  rectMode(CENTER);
  rect(width/2, anchorOff.y -13, ((anchorOff.x - 310) - width/2)*2, 100, 10, 10, 10, 10); 

  pumpLeft = 100;
  pumpRight = width-((int)anchorOff.x-310) - 40;
  pumpPosition = max(pumpLeft, min(pumpRight, pumpPosition));

  line(pumpPosition, anchorOff.y - 63, pumpPosition, anchorOff.y +37);//griff
  line(pumpPosition+1, anchorOff.y - 13, pumpRight +27, anchorOff.y - 13); //stab
  
  saveFrame("line-######.png");
}

PVector getBallonSize(int percentage) {
  PVector p = new PVector();  
  p.x = map(percentage, 0, 100, ballon.width/2, ballon.width);
  p.y = map(percentage, 0, 100, ballon.height/2, ballon.height);
  return p;
}

PVector getBallonPos(PVector ballonSize) {
  PVector p = new PVector();
  PVector base = getBallonBottomCenter();
  p.x = base.x-ballonSize.x/2;
  p.y = base.y-ballonSize.y;
  return p;
}

PVector getBallonBottomCenter() {
  PVector p = new PVector();
  p.x = width-200-ballon.width/2;
  p.y = height-400;
  return p;
}

void mouseDragged() {

  if (locked) {
    pumpPosition = mouseX;
    if (filled) {
      if (pumpPosition > pumpRight-10) {
        filled = false;
        if (x < 96) {
          x+= random(1,2);
        }
      }
    } else {
      if (pumpPosition < pumpLeft+10) {
        filled = true;
      }
    }
  }
}

void mousePressed() {
  if (mouseX > pumpPosition-15 && mouseX < pumpPosition+15) {
    if (mouseY > anchorOff.y - 73 && mouseY < anchorOff.y + 47) {
      locked = true;
    }
  }
}

void mouseReleased() {
  locked = false;
}  

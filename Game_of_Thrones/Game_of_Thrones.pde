class SideJumper
{
  PImage image;
  PVector position;
  float direction;
  PVector velocity;
  float jumpSpeed;
  float walkSpeed;
}



SideJumper jonSnow;
SideJumper whiteWalker;
float left;
float right;
float up;
float down;
int quantity = 300;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;



float gravity = .5;

// Y coordinate of ground for collision
float ground = 650;

void setup()
{
  size(800, 800);
  frameRate(50);
  noStroke();
  smooth();

  for(int i = 0; i < quantity; i++) {
    flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
    xPosition[i] = random(0, width);
    yPosition[i] = random(0, height);
    direction[i] = round(random(0, 1));
  }
  
  jonSnow = new SideJumper();
  jonSnow.image = loadImage("jonsnow.jpg");
for (int i = 0; i < jonSnow.image.width *  jonSnow.image.height; i++)
{
  if (( jonSnow.image.pixels[i] & 0x00FFFFFF) == 0x00FFFFFF)
  {
     jonSnow.image.pixels[i] = 0;
  }
}
 jonSnow.image.format = ARGB;
 jonSnow.image.updatePixels();

image( jonSnow.image, 200, 350, 200, 200);

  jonSnow.position = new PVector(400, ground);
  jonSnow.direction = 1;
  jonSnow.velocity = new PVector(0, 0);
  jonSnow.jumpSpeed = 10;
  jonSnow.walkSpeed = 4;



whiteWalker = new SideJumper();
 whiteWalker.image = loadImage("white walker.jpg");
  for (int i = 0; i < whiteWalker.image.width *  whiteWalker.image.height; i++)
{
  if (( whiteWalker.image.pixels[i] & 0x00FFFFFF) == 0x00FFFFFF)
  {
     whiteWalker.image.pixels[i] = 0;
  }
}
whiteWalker.image.format = ARGB;
 whiteWalker.image.updatePixels();
 

     
//image(whiteWalker.image, 50,650);

}

void draw()
{
  background(185,255,255);
   for(int i = 0; i < xPosition.length; i++) {
    
    ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    
    if(direction[i] == 0) {
      xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    } else {
      xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    }
    
    yPosition[i] += flakeSize[i] + direction[i]; 
    
    if(xPosition[i] > width + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > height + flakeSize[i]) {
      xPosition[i] = random(0, width);
      yPosition[i] = -flakeSize[i];
    }
    
  }
  fill(255);
  rect(0,650,800,150);
  updatejonSnow();
 
  image(whiteWalker.image, 50,600);

}

void updatejonSnow()
{
  
  if (jonSnow.position.y < ground)
  {
    jonSnow.velocity.y += gravity;
  }
  else
  {
    jonSnow.velocity.y = 0; 
  }
  
 
  if (jonSnow.position.y >= ground && up != 0)
  {
    jonSnow.velocity.y = -jonSnow.jumpSpeed;
  }
  
  jonSnow.velocity.x = jonSnow.walkSpeed * (left + right);
  

  PVector nextPosition = new PVector(jonSnow.position.x, jonSnow.position.y);
  nextPosition.add(jonSnow.velocity);
  

  float offset = 0;
  if (nextPosition.x > offset && nextPosition.x < (width - offset))
  {
    jonSnow.position.x = nextPosition.x;
  } 
  if (nextPosition.y > offset && nextPosition.y < (height - offset))
  {
    jonSnow.position.y = nextPosition.y;
  } 
  
  // See car example for more detail here.
  pushMatrix();
  
  translate(jonSnow.position.x, jonSnow.position.y);
  
 
  scale(jonSnow.direction, 1);
  
  imageMode(CENTER);
  image(jonSnow.image, 0, 0);
  
  popMatrix();
}

void keyPressed()
{
  if (key == CODED){
    if(keyCode==RIGHT)
  {
    right = 1;
    jonSnow.direction = 1;
  }}
  if (key == CODED){
    if(keyCode == LEFT)
  {
    left = -1;
    jonSnow.direction = -1;
  }}
  
    if(key == ' ')
  {
    up = -1;
  }
  if (key == CODED){
    if(keyCode == DOWN)
  {
    down = 1;
  }}
  if(key == CODED){
    if(keyCode == ALT){
      jonSnow.image = loadImage("jonAttacking.jpg");
      
      for (int i = 0; i < jonSnow.image.width *  jonSnow.image.height; i++)
{
  if (( jonSnow.image.pixels[i] & 0x00FFFFFF) == 0x00FFFFFF)
  {
     jonSnow.image.pixels[i] = 0;
  }
}
 jonSnow.image.format = ARGB;
 //jonSnow.image.updatePixels();
//image( jonSnow.image, 200, 350, 100, 100);

  }}
}

void keyReleased()
{
  if (key == CODED){
    if(keyCode==RIGHT)
  {
    right = 0;
  }}
  if (key == CODED){
    if(keyCode == LEFT)
  {
    left = 0;
  }}

    if(key== ' ')
  {
    up = 0;
  }
  if (key == CODED){
    if(keyCode == DOWN)
  {
    down = 0;
  }}
  if(key == CODED){
    if(keyCode == ALT){
     jonSnow.image = loadImage("jonsnow.jpg");
      for (int i = 0; i < jonSnow.image.width *  jonSnow.image.height; i++)
{
  if (( jonSnow.image.pixels[i] & 0x00FFFFFF) == 0x00FFFFFF)
  {
     jonSnow.image.pixels[i] = 0;
  }
}
 jonSnow.image.format = ARGB;
 jonSnow.image.updatePixels();
//image( jonSnow.image, 200, 350, 100, 100);
 
    
    
    }}
}
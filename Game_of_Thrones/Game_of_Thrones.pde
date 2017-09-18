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
float left;
float right;
float up;
float down;

// half a pixel per frame gravity.
float gravity = .5;

// Y coordinate of ground for collision
float ground = 500;

void setup()
{
  size(800, 800);
  
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
}

void draw()
{
  background(210,255,255);
  updatejonSnow();
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
}
//
// pyramid
//
// Darren Kessner
// Marlborough School
//


// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// 


int pyramid_s = 100;
int pyramid_h = 50;

float separation = 0;
float vseparation = 0;

float t = -PI/4;
float vt = 0;


void setup() 
{
    size(600, 600, P3D);
}


void pyramid(float s, float h)
{
    stroke(200);
    strokeWeight(2);

    beginShape();
    vertex(-s/2, -s/2, -h);
    vertex( s/2, -s/2, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex( s/2, -s/2, -h);
    vertex( s/2,  s/2, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex( s/2, s/2, -h);
    vertex(-s/2, s/2, -h);
    vertex(   0,   0,  0);
    endShape();

    beginShape();
    vertex(-s/2,  s/2, -h);
    vertex(-s/2, -s/2, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex(-s/2, -s/2, -h);
    vertex(-s/2, s/2, -h);
    vertex(s/2, s/2, -h);
    vertex(s/2, -s/2, -h);
    endShape();
}


void half_pyramid(float s, float h)
{
    stroke(200);
    strokeWeight(2);

    beginShape();
    vertex(-s/2, 0, -h);
    vertex( s/2, 0, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex( s/2, 0, -h);
    vertex( s/2, s/2, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex( s/2, s/2, -h);
    vertex(-s/2, s/2, -h);
    vertex(   0,   0,  0);
    endShape();

    beginShape();
    vertex(-s/2,  s/2, -h);
    vertex(-s/2, 0, -h);
    vertex(   0,    0,  0);
    endShape();

    beginShape();
    vertex(-s/2, 0, -h);
    vertex(-s/2, s/2, -h);
    vertex(s/2, s/2, -h);
    vertex(s/2, 0, -h);
    endShape();
}


void draw() 
{
    background(0);

    // instructions

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("RIGHT/LEFT: separate", 150, 40);
    text("UP/DOWN: rotate", 450, 40);

    // view

    translate(width/2, height/2, 100);
    rotateX(t);
    rotateY(PI/4);

    // pyramid

    fill(#d8780a, 100);
    pushMatrix();
    rotateX(PI/2);
    pyramid(pyramid_s, pyramid_h);
    popMatrix();

    fill(128, 128, 128, 20);
    pushMatrix();
    rotateX(-PI/2);
    pyramid(pyramid_s, pyramid_h);
    popMatrix();

    // half pyramids

    fill(#d8780a, 100);

    for (int i=0; i<4; i++)
    {
      pushMatrix();
      translate(0, 0, -separation);
      half_pyramid(pyramid_s, pyramid_h);
      popMatrix(); 
      rotateY(PI/2);
    }

    fill(128, 128, 128, 50);
    pushMatrix();
    rotateX(PI);
      for (int i=0; i<4; i++)
      {
        pushMatrix();
        translate(0, 0, -separation);
        half_pyramid(pyramid_s, pyramid_h);
        popMatrix(); 
        rotateY(PI/2);
      }
    popMatrix();

 
    // origin marker

    stroke(255, 255, 255, 100);
    sphere(1);

    // updates

    separation += vseparation;

    if (separation < 0)
    {
        separation = 0;
        vseparation = 0;
    }

    t += vt;
}


void keyPressed()
{
    if (keyCode == RIGHT)
    {
        vseparation = 1;
    }
    else if (keyCode == LEFT)
    {
        vseparation = -1;
    }
    else if (keyCode == UP)
    {
        vt = PI/100;
    }
    else if (keyCode == DOWN)
    {
        vt = -PI/100;
    }
}


void keyReleased()
{
    if (keyCode == UP || keyCode == DOWN)
        vt = 0;
    else if (keyCode == RIGHT || keyCode == LEFT)
    {
        vseparation = 0;
    }
}


//
// unit_circle.pde
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


float theta = 0;
float dtheta = 0;

PVector axes_center_1;
PVector axes_center_2;
float radius;


void setup()
{
    size(800, 400);

    axes_center_1 = new PVector(width/4, height/2);
    axes_center_2 = new PVector(1.1*width/2, height/2);
    radius = .9 * width/4;

    //noCursor();
}


void drawAxes()
{
    strokeWeight(1);
    stroke(0, 255, 0);

    // axes 1, x-axis

    line(axes_center_1.x - radius, axes_center_1.y, 
         axes_center_1.x + radius, axes_center_1.y);

    // axes 1, y-axis

    line(axes_center_1.x, axes_center_1.y - radius, 
         axes_center_1.x, axes_center_1.y + radius);

    // axes 2, x-axis

    line(axes_center_2.x - radius*.1, axes_center_2.y, 
         axes_center_2.x + radius*1.9, axes_center_2.y);

    // axes 2, y-axis

    line(axes_center_2.x, axes_center_2.y - radius, 
         axes_center_2.x, axes_center_2.y + radius);
}


void drawUnitCircle()
{
    strokeWeight(1);
    stroke(128);
    noFill();
    ellipse(axes_center_1.x, axes_center_1.y, radius*2, radius*2);
}


float X(float angle)
{
    angle = angle % (2*PI);
    if (angle < 0) angle += 2*PI;
    float x = axes_center_2.x + angle * radius*1.9/2/PI;
    return x;
}


float Y(float angle)
{
    return axes_center_2.y - radius * sin(angle);
}


void drawSin()
{
    strokeWeight(1);
    beginShape();
    for (float t=0; t<2*PI; t+=.01)
    {
        vertex(X(t), Y(t));
    }
    endShape();
}


void drawClockHand()
{
    strokeWeight(3);
    stroke(255);
    float x = axes_center_1.x + radius * cos(theta);
    float y = axes_center_1.y - radius * sin(theta);
    line(axes_center_1.x, axes_center_1.y, x, y);
    line(axes_center_1.x, axes_center_1.y, axes_center_1.x, y); // shadow
}


void drawVerticalBar()
{
    strokeWeight(3);
    stroke(255);
    float x = X(theta);
    float y = Y(theta);
    line(x, axes_center_2.y, x, y);
}


void draw()
{
    background(0);
    
    drawAxes();

    drawUnitCircle();
    drawClockHand();

    drawSin();
    drawVerticalBar();

    theta += dtheta;
}


void keyPressed()
{
    if (keyCode == UP || keyCode == RIGHT)
        dtheta = .04;
    else if (keyCode == DOWN || keyCode == LEFT)
        dtheta = -.04;
}


void keyReleased()
{
    dtheta = 0;
}



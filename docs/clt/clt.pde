//
// clt.pde
//
// Darren Kessner
// Marlborough School
//


int n = 0;
int max_n = 66;


float binsX;
float binsY;
float binsW;
float binsH;


ArrayList<Bin> bins;
ArrayList<String> binLabels;

long[][] C;
float labelSize = 25;


void setup()
{
    size(800, 600);

    initializeBinomialCache();
    initializeBins();
}


void initializeBinomialCache()
{
    C = new long[max_n+1][];

    for (int n=0; n<=max_n; n++)
    {
        C[n] = new long[n+1];
        C[n][0] = C[n][n] = 1;
        for (int k=1; k<n; k++)
        {
            C[n][k] = C[n-1][k-1] + C[n-1][k];
        }
    }
}


void draw()
{
    background(0);

    textSize(25);
    text("n: " + n, 50, 50);

    final float bw = binsW/(n+1);
    textAlign(CENTER, CENTER);

    for (Bin b : bins)
        b.display();
}


void initializeBins()
{
    binsX = 50;
    binsW = width-binsX*2;
    binsH = height*.5;
    binsY = 100;

    labelSize = min(binsW/n, 25);

    bins = new ArrayList<Bin>();

    final float bw = binsW/(n+1);
    final float scale = binomial(n, (int)(n/2)); // (int) cast necessary for processing.js
    final float margin = bw * .1;

    for (int k=0; k<=n; k++)
    {
        float bx = binsX + bw * k + margin;
        float bh = binsH * binomial(n, k)/scale;
        float by = binsY + binsH - bh;
        String label = "" + C[n][k];
        bins.add(new Bin(bx, by, bw-2*margin, bh, label));
    }
}


long binomial(int n, int k)
{
    if (k<=0 || k>=n) return 1;
    return C[n][k];
    //return binomial(n-1, k-1) + binomial(n-1, k);
}


void increment_n()
{
    if (n<max_n) n++;
    initializeBins(); 
}


void decrement_n()
{
    if (n>0) n--;
    initializeBins(); 
}


void keyPressed()
{
    if (keyCode == UP || keyCode == RIGHT)
      increment_n();
    else if (keyCode == DOWN || keyCode == LEFT)
      decrement_n();
}


class Bin
{
    float x;
    float y;
    float w;
    float h;
    String label;

    Bin(float x, float y, float w, float h, String label)
    {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.label = label;
    }

    void display()
    { 
        fill(255);
        rect(x, y, w, h);

        pushMatrix();
        translate(x+w/2, y + h + 50);
        textAlign(CENTER, CENTER);
        if (n>10) 
        {
            rotate(PI/2);
            textAlign(LEFT, CENTER);
            textSize(labelSize);
        }
        text(label, 0, 0);
        popMatrix();
    }
}




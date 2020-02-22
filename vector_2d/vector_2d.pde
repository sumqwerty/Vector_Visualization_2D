import controlP5.*;
ControlP5 cp5,cp5_2;

PFont fnt;

boolean f = true;
boolean f1 = true; 
boolean pen_use = false;
boolean eraser_use = false;
boolean show_angle = false;
//boolean debug = true;


int t_new_vector = 0;
int t_add = 0;
int t_sub = 0;
int func_sum = 0;
int func_sub = 0;

ArrayList<Vec> vector = new ArrayList<Vec>(2);
ArrayList<Vec> vector_addsel = new ArrayList<Vec>(2);
ArrayList<Vec> vector_subsel = new ArrayList<Vec>(2);
ArrayList<Vec> vector_anglesel = new ArrayList<Vec>();
ArrayList<ControlP5> arry = new ArrayList<ControlP5>(2);
ArrayList<PVector> pencoord = new ArrayList<PVector>();
ArrayList<ArrayList> anglebw = new ArrayList<ArrayList>();

Toggle tpen, teraser, Angle;


PVector UNIV_X = new PVector(100,0);
PVector UNIV_Y = new PVector(0,100);



void setup()
{   
  size(1300,700);
  
  fnt = createFont("Ubuntu_B.ttf",20);
  textFont(fnt);
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("NEW_VECTOR")
     .setValue(0)
     .setCaptionLabel("ADD NEW VECTOR")
     .setPosition(0,10)
     .setSize(100,20)
     ;
  
  cp5.addButton("DELETE")
     .setValue(1)
     .setPosition(120,10)
     .setSize(100,20)
     ;
  
  cp5.addButton("ADD")
     .setValue(2)
     .setPosition(240,10)
     .setSize(100,20)
     ;
  
  cp5.addButton("SUBTRACT")
     .setValue(3)
     .setPosition(360,10)
     .setSize(100,20)
     ;

  Angle = cp5.addToggle("toggle_angle")
         .setPosition(480,10)
         .setSize(100,20)
         .setValue(false)
         .setCaptionLabel("Angle")
         .plugTo("toggle_angle")
         ;
           
  Angle.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingY(-15);

  tpen = cp5.addToggle("toggle_pen")
         .setPosition(600,10)
         .setSize(100,20)
         .setValue(false)
         .setCaptionLabel("PEN")
         .plugTo("toggle_pen")
         ;
  tpen.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingY(-15);
  
  /*teraser = cp5.addToggle("toggle_eraser")
         .setPosition(600,10)
         .setSize(100,20)
         .setValue(false)
         .setCaptionLabel("ERASER")
         .plugTo("toggle_eraser")
         ;
  teraser.getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingY(-15);*/
  
  
}

void draw()
{
  
  background(0);
  for(int i=0; i<vector.size(); ++i)
  {
    
    if(!vector.get(i).single)
    {
        //println(vector.get(i).mag);
        //println(i);
        if(vector.get(i).sumnonsingle)
        {
          vector.get(i).sum();
          //println("add");
        }
          
          
        if(vector.get(i).subnonsingle)
        {
          vector.get(i).subtract();
          //println("sub");
        }
    }
    
    else
    {
      vector.get(i).calculate();
    }
    
    
    vector.get(i).drw();
    
    if(pen_use || eraser_use)
    {
      pen();
    }
    else
    {
      for(int j=0; j<pencoord.size(); ++j)
      {
        pencoord.remove(j);
      }
    }
    
    if(show_angle)
    {
      shw_angle();
    }
    
    //debugging
    //println(vector.size(),vector_addsel.size(),vector_subsel.size());
    //debug = false;
    
    
    if(vector.get(i).move && mousePressed && mouseButton == LEFT && !pen_use && 
      (
      (mouseX > vector.get(i).ex-20) && 
      (mouseX< vector.get(i).ex+20) && 
      (mouseY > vector.get(i).ey-20) && 
      (mouseY < vector.get(i).ey+20)
      )
      )
      vector.get(i).moved();
    
    if(vector.get(i).move && mousePressed && mouseButton == RIGHT && !pen_use && 
      (
      (mouseX > vector.get(i).ex-20) && 
      (mouseX< vector.get(i).ex+20) && 
      (mouseY > vector.get(i).ey-20) && 
      (mouseY < vector.get(i).ey+20)
      )
      )
    {
      
    }
    
  }
  //if(debug)
    //println(vector.size(), vector_addsel.size(), vector_subsel.size());
}


void pen()
{
  
  if(mousePressed && mouseButton == LEFT)
  {
    PVector mcoord = new PVector(mouseX,mouseY);
    pencoord.add(mcoord);
  }
  
  for(int i=0; i<pencoord.size();++i)
  {
    strokeWeight(0);
    if(!eraser_use)
    {
      fill(255,0,0);
      stroke(255,0,0);
    }
    else
    {
      fill(0,0,0);
      stroke(0,0,0);
    }
    circle(pencoord.get(i).x,pencoord.get(i).y,5);
  }
}

void shw_angle()
{
  
  //println(vector_anglesel.size());
  for(int i=0; i<vector_anglesel.size()-1; ++i)
  {
    float ae = 0, ab = 0, aw = 0;
    Vec a1 = vector_anglesel.get(i);
    Vec a2 = vector_anglesel.get(i+1);

    float anglbw = PVector.angleBetween(a1.getVector(),a2.getVector());
    
    aw = abs(a1.getAngleC()-a2.getAngleC());
    
    if(int(aw) == int(anglbw))
    {
      if(a1.getAngleC() > a2.getAngleC())
      {
        ab = TWO_PI - a1.getAngleC();
      }
      else
      {
        ab = TWO_PI - a2.getAngleC();
      }
    }
    else
    {
      if(a1.getAngleC() > a2.getAngleC())
      {
        ab = TWO_PI - a2.getAngleC();
      }
      else
      {
        ab = TWO_PI - a1.getAngleC();
      }
    }
    
    ae = ab + anglbw;
    
    //println(degrees(anglbw),degrees(a1.getAngle()),degrees(a2.getAngle()));
    //println(int(degrees(anglbw)),int(degrees(aw)),int(degrees(a1.getAngle())),int(degrees(a2.getAngle())));
    
    
    fill(a1.getColor());
    stroke(a2.getColor());
    arc(a1.getBase()[0],a1.getBase()[1],100,100,ab,ae);
    fill(255);
    text("Angle between",800,25);
    fill(a1.getColor());
    text("Vector "+str(a1.getVecnumber()),949,25);
    fill(255);
    text("and",1038,25);
    fill(a2.getColor());
    text(" Vector "+ str(a2.getVecnumber()),1075,25);
    fill(255);
    text(" is " +str(int(degrees(anglbw))),1164,25);
    
    //println(mouseX);
    //text("Angle between Vector " + str(a1.getVecnumber())+ " and Vector " + str(a2.getVecnumber())+ " is " +str(int(degrees(anglbw))),800,45);
  }
}

void toggle_pen(boolean theFlag)
{
  if(theFlag)
  {
    pen_use = true;
    eraser_use = false;
    teraser.setValue(false);
  }
  else
  {
    pen_use = false;
  }
}

void toggle_angle(boolean theFlag)
{
  if(theFlag)
  {
    show_angle = true;
  }
  else
  {
    show_angle = false;
  }
  
}


void toggle_eraser(boolean theFlag)
{
  if(theFlag == true)
  {
    eraser_use = true;
    pen_use = false;
    tpen.setValue(false);
  }
  else
  {
    eraser_use = false;
  }
}



void NEW_VECTOR(int theValue)
{
  cp5_2 =  new ControlP5(this);
  arry.add(cp5_2);
  
  int x = vector.size();
  String s = "" + x;
  
  
  Vec v;
  if(t_new_vector==1)
  {
    v = new Vec(50, 0, s, vector.size()*160,40,true, false, false);
    vector.add(v);
  }
  t_new_vector=1;
}



void ADD(int theValue)
{
  
  cp5_2 =  new ControlP5(this);
  arry.add(cp5_2);
  
  int x = vector.size();
  String s = "" + x;
  
  Vec v;
  if(t_add==1)
  {
    func_sum = 1;
    v = new Vec(0, 0, s, vector.size()*160,40,false, true, false);
    vector.add(v);
  }
  t_add=1;
}

void SUBTRACT(int theValue)
{
  
  cp5_2 =  new ControlP5(this);
  arry.add(cp5_2);
  
  int x = vector.size();
  String s = "" + x;
  
  Vec v;
  if(t_sub==1)
  {
    func_sub = 2;
    v = new Vec(0, 0, s, vector.size()*160,40,false, false, true);
    vector.add(v);
  }
  t_sub=1;
}

void DELETE(int theValue)
{ 
  /*for(int i=0; i<vectorsel.size(); ++i)
  {
    if(vectorsel.get(i).sel)
    {
      vectorsel.remove(vectorsel.get(i));
      vector.remove(vector.get(i));
      arry.remove(arry.get(i)).hide();
    }
  }*/
  
  if(vector.size()>=1)
  {
    
    if((vector.get(vector.size()-1).single))
    {
      
      for(int i=0; i<vector_addsel.size();++i)
      {
        if(vector.get(vector.size()-1).colour == vector_addsel.get(i).colour)
        {
          vector_addsel.remove(i);
        }
      }
      
      
      for(int i=0; i<vector_subsel.size();++i)
      {
        if(vector.get(vector.size()-1).colour == vector_subsel.get(i).colour)
        {
          vector_subsel.remove(i);
        }
      }
      
      for(int i=0; i<vector_anglesel.size();++i)
      {
        if(vector.get(vector.size()-1).colour == vector_anglesel.get(i).colour)
        {
          vector_anglesel.remove(i);
        }
      }
      
    
    }
    vector.remove(vector.size()-1);
  }  
  
  if(f)
  {
    arry.remove(arry.size()-1);
    
    f = false;
  }
  
  else
  {
    if(!f1)
      arry.remove(arry.size()-1).hide();
  }
  f1 = false;
  
}

void iso(PVector a)
{
  cp5_2 =  new ControlP5(this);
  arry.add(cp5_2);
  
  int x = vector.size();
  String s = "" + x;
  
  //println(a.x, a.y);
  
  Vec v;
  
  if(t_new_vector==1)
  {
    //println(a.x, " ", a.y);
    v = new Vec(a.x, a.y, s, vector.size()*160,40,true, false, false);
    vector.add(v);
  }
  t_new_vector=1;
  
}

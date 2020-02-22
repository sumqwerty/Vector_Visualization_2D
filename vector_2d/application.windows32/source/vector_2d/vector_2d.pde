import controlP5.*;
ControlP5 cp5,cp5_2;

boolean f = true;
boolean f1 = true; 
boolean pen_use = false;
boolean eraser_use = false;
//boolean debug = true;


int t_new_vector = 0;
int t_add = 0;
int t_sub = 0;
int func = 0;

ArrayList<Vec> vector = new ArrayList<Vec>(2);
ArrayList<Vec> vector_addsel = new ArrayList<Vec>(2);
ArrayList<Vec> vector_subsel = new ArrayList<Vec>(2);
ArrayList<ControlP5> arry = new ArrayList<ControlP5>(2);
ArrayList<PVector> pencoord = new ArrayList<PVector>();
ArrayList<ArrayList> anglebw = new ArrayList<ArrayList>();

Toggle tpen, teraser;

void setup()
{   size(1300,700);
  
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
  
  cp5.addButton("ANGLE")
     .setValue(4)
     .setPosition(480,10)
     .setSize(100,20)
     ;

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
        if(func == 1 || vector.get(i).sumnonsingle)
          vector.get(i).sum();
        else if(func == 2 || vector.get(i).subnonsingle)
          vector.get(i).subtract();
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
    
    //debugging
    //println(vector.size(),vector_addsel.size(),vector_subsel.size());
    //debug = false;
    
    
    if(vector.get(i).move && mousePressed && !pen_use && ((mouseX > vector.get(i).ex-20) && (mouseX< vector.get(i).ex+20) && (mouseY > vector.get(i).ey-20) && (mouseY < vector.get(i).ey+20)))
      vector.get(i).moved();
    
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



void toggle_pen(boolean theFlag)
{
  if(theFlag == true)
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


void ANGLE(int theValue)
{
  ArrayList<Vec> temp = new ArrayList<Vec>();
  
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
    func = 1;
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
    func = 2;
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
  
  
  Vec v;
  if(t_new_vector==1)
  {
    println(a.x, " ", a.y);
    v = new Vec(a.x, a.y, s, vector.size()*160,40,true, false, false);
    vector.add(v);
  }
  t_new_vector=1;
  
}

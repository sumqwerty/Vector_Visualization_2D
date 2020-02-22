import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class vector_2d extends PApplet {


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

public void setup()
{   
  
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

public void draw()
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


public void pen()
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



public void toggle_pen(boolean theFlag)
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

public void toggle_eraser(boolean theFlag)
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



public void NEW_VECTOR(int theValue)
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


public void ANGLE(int theValue)
{
  ArrayList<Vec> temp = new ArrayList<Vec>();
  
}


public void ADD(int theValue)
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

public void SUBTRACT(int theValue)
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

public void DELETE(int theValue)
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

public void iso(PVector a)
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
boolean b = false;
class Vec
{
  PVector c;
  
  boolean chkanglfstime = true;
  boolean single;
  boolean move;
  boolean components;
  boolean sel_add;
  boolean sel_sub;
  boolean sel_rearrange;
  boolean visibility;
  boolean arrowHead = true;
  
  //for components arrow
  boolean xp;
  boolean yp;
  
  
  //for resultnats//
  boolean sumnonsingle;
  boolean subnonsingle;
  boolean lawproof;
  
  
  
  float mag;
  float magnitude;
  float angle;
  float ix;
  float iy;
  float x;
  float y;
  float ex=width/2;
  float ey=height/2;
  
  //for arrowHead
  float alpha = 90;
  float ax;
  float ay;
  
  //for resultant
  float tri_x;
  float tri_y;
  
  
  String colour;
  int col;
  
  PFont f;
  
  
  Textarea setMag, setAngle;
  
  Vec(float xp, float yp, String thePrefix, float xb, float yb, boolean state, boolean statesum, boolean statesub)
  {
    f = createFont("Ubuntu_B.ttf",12);
    if(vector.size()==0)
    {
      col = color(255,0,128);
      colour = "pink";
    }
    else if(vector.size()==1)
    {
      col = color(255,0,0);
      colour = "red";
    }
    else if(vector.size()==2)
    {
      col = color(0,255,0);
      colour = "green";
    }
    else if(vector.size()==3)
    {
      col = color(0,0,255);
      colour = "blue";
    }
    else if(vector.size()==4)
    {
      col = color(255,255,0);
      colour = "yellow";
    }
    else if(vector.size()==5)
    {
      col = color(255);
      colour = "white";
    }
    else if(vector.size()==6)
    {
      col = color(255,127,39);
      colour = "orange";
    }
    else if(vector.size()==7)
    {
      col = color(0,255,255);
      colour = "cyan";
    }
    
    
    sumnonsingle = statesum;
    subnonsingle = statesub;
    move = true;
    components = false;
    visibility = true;
    sel_add = false;
    sel_sub = false;
    sel_rearrange = false;
    lawproof = false;
    
    
    //magnitude = sqrt((xp*xp)+(yp*yp));
    PVector l;
    single = state;
    l = new PVector(xp,yp);
    magnitude = l.mag();
    c = l;
    
    /////////////////
    /////////////////
    
    
    
    if(single)
    {
    cp5_2.addSlider( "value-"+thePrefix )
         .setPosition(xb,yb)
         .setRange( -400, 400 )
         .plugTo( this, "setValue" )
         .setValue( 50 )
         .setSize(100,20)
         .setColorValue(0)
         .setColorForeground(col)
         .setLabel("magnitude")
         .setSliderMode(1)
         ;
         
    cp5_2.addSlider( "value-"+thePrefix+1 )
             .setPosition(xb,yb+30)//yb+30
             .setRange( 0, 360 )//57.42
             .plugTo( this, "setAngle" )
             .setValue( 90 )
             .setSize(100,20)
             .setColorValue(0)
             .setColorForeground(col)
             .setLabel("angle")
             .setSliderMode(1)
             ;
    
    cp5_2.addToggle("toggle4_add")
         .setPosition(xb,yb+135)
         .setSize(20,20)
         .setValue(false)
         .setCaptionLabel("to add")
         .plugTo( this, "toggle4" )
         ;
    cp5_2.addToggle("toggle5_sub")
         .setPosition(xb+40,yb+135)
         .setSize(20,20)
         .setValue(false)
         .setCaptionLabel("to subtract")
         .plugTo( this, "toggle5" )
         ;
         
    }   
    
    
    
    
    cp5_2.addToggle("toggle1")
         .setPosition(xb,yb+60)
         .setSize(50,20)
         .setValue(true)
         .setCaptionLabel("move")
         .plugTo( this, "toggle1" )
         ;
    
    cp5_2.addToggle("toggle2")
         .setPosition(xb+60,yb+60)
         .setSize(50,20)
         .setValue(true)
         .setCaptionLabel("visible")
         .plugTo( this, "toggle2" )
         ;
    
    cp5_2.addToggle("toggle3")
         .setPosition(xb,yb+95)
         .setSize(50,20)
         .setValue(false)
         .setCaptionLabel("components")
         .plugTo( this, "toggle3" )
         ;
    
    /*cp5_2.addToggle("toggle4")
         .setPosition(xb+60,yb+60)
         .setSize(50,20)
         .setValue(false)
         .setCaptionLabel("angle")
         .plugTo( this, "toggle4" )
         ;*/
    
    
    if(!single)
    {
      
      setMag = cp5_2.addTextarea("txt mag")
                    .setPosition(xb,yb)
                    .setFont(f)
                    .setText(""+mag)
                    .setSize(100,20)
                    .setColor(color(255))
                    .setColorBackground(col)
                    .hideScrollbar()
                    .setCaptionLabel("Mag")
                    ;
      
      setAngle = cp5_2.addTextarea("txt angle")
                      .setPosition(xb,yb+30)
                      .setFont(f)
                      .setText(""+angle)
                      .setSize(100,20)
                      .setColor(color(255))
                      .hideScrollbar()
                      .setColorBackground(col)
                      ;
      
      cp5_2.addToggle("toggle6_show")
           .setPosition(xb,yb+135)
           .setSize(20,20)
           .setValue(false)
           .setCaptionLabel("triangle law")
           .plugTo( this, "toggle6" )
           ;
      /*cp5_2.addButton("isolate")
           .setValue(0)
           .setCaptionLabel("ISOLATE")
           .plugTo( this, "isolate" )
           .setPosition(xb+60,yb+95)
           .setSize(50,20)
           ;*/
    }
    
    /////////////////
    /////////////////
    
  }
  
  
  public void updateSliders()
  {
    float ang = degrees(acos(getVector().x/getVector().mag()));
    setAngle.setText(""+ang);
    setMag.setText(""+mag);
  }
  
  
  public void isolate(int theValue)
  {
    iso(c);
  }
  
  public void setValue(int theValue) {
    magnitude = theValue;
  }
  
  public void setAngle(float theValue) {
    angle = (theValue/57.42f);
    alpha = -(theValue);
  }
  
  public void toggle1(boolean theFlag) 
  {
    if(theFlag==true) 
    {
      move = true;
    }
    else
    {
      move = false;
    }
  }
  
  public void toggle2(boolean theFlag)
  {
    if(theFlag==true) 
    {
      visibility = true;
    }
    else 
    {
      visibility = false;
    }
  }
  
  public void toggle3(boolean theFlag) 
  {
    if(theFlag==true) 
    {
      components = true;
    }
    else 
    {
      components = false;
    }
  }
  
  public void toggle4(boolean theFlag) 
  {
    if(theFlag==true) 
    {
      sel_add = true;
      vector_addsel.add(this);
    }
    else
    {
      sel_add = false;
      vector_addsel.remove(this);
    }
  }
  
  public void toggle5(boolean theFlag) 
  {
    if(theFlag==true) 
    {
      sel_sub = true;
      vector_subsel.add(this);
    }
    else 
    {
      sel_sub = false;
      vector_subsel.remove(this);
    }
  }
  
  public void toggle6(boolean theFlag) 
  {
    if(theFlag==true) 
    {
      lawproof = true;
    }
    else 
    {
      lawproof = false;
    }
  }
  
  
  
  public void sum()
  {
    PVector v;
    v = new PVector(0,0);
    for(int i=0; i<vector_addsel.size(); ++i)
    {
      v.add(vector_addsel.get(i).getVector());
    }
    
    c = v;      
    
  }
  
  public void subtract()
  {
    PVector v;
    v = new PVector(0,0);
    for(int i=1; i<vector_subsel.size(); ++i)
    {
      v = PVector.sub(vector_subsel.get(0).getVector(),vector_subsel.get(i).getVector());
    }
    c = v;
  }
  
  public void trianglelaw()
  {
    for(int i=0; i<vector_addsel.size(); ++i)
    {
      tri_x = vector_addsel.get(i).getVector().x;
      tri_y = vector_addsel.get(i).getVector().y;
      //println(tri_x, vector_addsel.get(i).getVector().x);
    }
  }
  
  public PVector getVector()
  {
    return c;
  }
  
  
  
  public void calculate()
  {
    if(chkanglfstime)
    {
      angle = acos(x/c.mag());
      alpha = -90;
      chkanglfstime = false;
    }
    x = cos(angle)*magnitude;
    y = sin(angle)*magnitude;
    
    c.x = x;
    c.y = y;
  }
  
  public void drw()
  {
    fill(col);
    stroke(col);
    strokeWeight(3);
    mag = c.mag();
    if(visibility)
    {
      //drawArrow(int(ex+tri_x),int(ey-tri_y),int(magnitude),alpha);
      drwarrow(ex,ey,((ex)+c.x),((ey)-c.y));
      if(!move)
        ellipse(ex,ey,20,20);
    }
    
    if(lawproof)
    {
      trianglelaw();
      
      drwarrow(ex+tri_x,ey-tri_y,((ex)+c.x),((ey)-c.y));
      //line(ex,((ey)-c.y),((ex)+c.x),((ey)-c.y));
      //line(ex,ey,((ex)+c.x),((ey)-c.y));
      //ellipse(ex,ey,20,20);
    }
    
    if(components)
    {
      
      line(ex,ey,((ex)+c.x),ey);// x-component
      
      translate(((ex)+c.x),ey);
      rotate(radians(135));
      if(((ex)+c.x) > ex)
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(-135));

      rotate(radians(-135));
      if(((ex)+c.x) > ex)
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(135));
      translate(-((ex)+c.x),-ey);
            
      ///////////////////////////////
      
      line(ex,ey,ex,((ey)-c.y));// y-component
      
      translate(ex,((ey)-c.y));
      rotate(radians(45));
      if(((ey)-c.y) < ey)
        line(0,0,8,0);
      else
        line(0,0,-8,0);  
      rotate(radians(-45));
      
      
      rotate(radians(135));
      if(((ey)-c.y) < ey)
        line(0,0,8,0);
      else
        line(0,0,-8,0);  
      rotate(radians(-135));
      translate(-ex,-((ey)-c.y));
      
    }
  }
  
  public void drwarrow(float inx, float iny, float finlx, float finly)
  {
    line(inx,iny,finlx,finly);
    float a;
    float ta, ah=90;
    
    if(single)
    {
      a = angle*57.42f;
      ta = 180-a;
      ah = ta-45;
      
      translate(finlx,finly);
    
      rotate(radians(ah));
      if(magnitude>0)
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(-ah));
    
      rotate(radians(ah+90));
      if(magnitude>0)
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(-(ah+90)));
    
      translate(-finlx,-finly);
    }
    
    if(!single && c.mag() != 0)
    {
      a = atan(c.y/c.x)*57.42f;
      ta = 180-a;
      ah = ta-45;
      
      translate(finlx,finly);
    
      rotate(radians(ah));
      
      if((c.x>0 && c.y>=0) || (c.x>0 && c.y<=0))
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(-ah));
    
      rotate(radians(ah+90));
      if((c.x>0 && c.y>=0) || (c.x>0 && c.y<=0))
        line(0,0,8,0);
      else
        line(0,0,-8,0);
      rotate(radians(-(ah+90)));
      
      translate(-finlx,-finly);
      updateSliders();
      
    }
  }
  
  public void moved()
  {
    ex = mouseX;
    ey = mouseY;
  }
};
  public void settings() {  size(1300,700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vector_2d" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

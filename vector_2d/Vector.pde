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
  //coordinates of foot of the vector
  float ex=width/2;
  float ey=height/2;
  
  //for arrowHead
  //float alpha = 90;
  float ax;
  float ay;
  
  //for resultant
  float tri_x;
  float tri_y;
  
  
  String colour;
  color col;
  
  PFont f;
  
  int vecNo;
  
  //boolean setAngle_slider = false;
  boolean selected;
  
  
  
  Accordion accordion;
  Textarea myTextarea;
  Toggle selAngl;
  //Textarea setMag, setAngle;
  Slider setMag, setAngle;
  Slider angle_control, mag_control;
  
  Vec(float xp, float yp, String thePrefix, float xb, float yb, boolean state, boolean statesum, boolean statesub)
  {
    vecNo = vector.size() + 1;
    selected = false;
    f = createFont("Ubuntu_B.ttf",14);
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
      col = color(136,0,21);
      colour = "mehroon";
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
    //PVector l;
    single = state;
    c = new PVector(xp,yp);
    magnitude = c.mag();
    
    /////////////////
    /////////////////
    
    Group g1 = cp5_2.addGroup("Vector "+str(vecNo))
                .setBackgroundColor(color(255, 64))
                .setBackgroundHeight(173)
                ;
    
    Group g2 = cp5_2.addGroup("Details")
                .setBackgroundColor(color(255, 64))
                .setBackgroundHeight(0)
                ;
    
    if(single)
    {
        
      mag_control = cp5_2.addSlider( "value-"+thePrefix )
                         .setPosition(0,0)
                         .setRange( 0, 800 )
                         .plugTo( this, "setValue" )
                         .setValue( magnitude )
                         .setSize(100,20)
                         .setColorValue(0)
                         .setColorForeground(col)
                         .setLabel("magnitude")
                         .setSliderMode(1)
                         .moveTo(g1)
                         ;
           
      angle_control = cp5_2.addSlider( "value-"+thePrefix+1 )
                           .setPosition(0,30)//yb+30
                           .setRange( 0, 360 )//57.42
                           .plugTo( this, "setAngle" )
                           .setValue( 90 )
                           .setSize(100,20)
                           .setColorValue(0)
                           .setColorForeground(col)
                           .setLabel("angle")
                           .setSliderMode(1)
                           .moveTo(g1)
                           ;
      
      cp5_2.addToggle("toggle4_add")
           .setPosition(0,135)
           .setSize(50,20)
           .setValue(false)
           .setCaptionLabel("to add")
           .plugTo( this, "toggle4_add" )
           .moveTo(g1)
           ;
      cp5_2.addToggle("toggle5_sub")
           .setPosition(60,135)
           .setSize(50,20)
           .setValue(false)
           .setCaptionLabel("to subtract")
           .plugTo( this, "toggle5_sub" )
           .moveTo(g1)
           ;
         
    }
    
    
    
    
    
    myTextarea = cp5_2.addTextarea("txt")
                  .setPosition(0,0)
                  .setSize(145,100)
                  .setFont(f)
                  .setLineHeight(14)
                  .setColor(col)
                  .setColorBackground(color(255))
                  .setColorForeground(color(255,100))
                  .moveTo(g2);
                  ;
    
    cp5_2.addToggle("toggle1")
         .setPosition(0,60)
         .setSize(50,20)
         .setValue(true)
         .setCaptionLabel("move")
         .plugTo( this, "toggle1" )
         .moveTo(g1)
         ;
     
    
    cp5_2.addToggle("toggle2")
         .setPosition(60,60)
         .setSize(50,20)
         .setValue(true)
         .setCaptionLabel("visible")
         .plugTo( this, "toggle2" )
         .moveTo(g1)
         ;
    
    cp5_2.addToggle("toggle3")
         .setPosition(0,95)
         .setSize(50,20)
         .setValue(false)
         .setCaptionLabel("components")
         .plugTo( this, "toggle3" )
         .moveTo(g1)
         ;
    
    selAngl = cp5_2.addToggle("toggle4")
                   .setPosition(60,95)
                   .setSize(50,20)
                   .setValue(false)
                   .setCaptionLabel("select")
                   .plugTo( this, "toggle4" )
                   .moveTo(g1)
                   ;
    
    
    /*cp5_2.addToggle("toggle4")
         .setPosition(xb+60,yb+60)
         .setSize(50,20)
         .setValue(false)
         .setCaptionLabel("angle")
         .plugTo( this, "toggle4" )
         .moveTo(g1)
         ;*/
    
    
    if(!single)
    {
      
      /*setMag = cp5_2.addTextarea("txt mag")
                    .setPosition(xb,yb)
                    .setFont(f)
                    .setText("Mag: "+mag)
                    .setSize(100,20)
                    .setColor(color(0))
                    .setColorBackground(col)
                    .hideScrollbar()
                    .setCaptionLabel("Mag")
                    .moveTo(g1)
                    ;
      
      setAngle = cp5_2.addTextarea("txt angle")
                      .setPosition(xb,yb+30)
                      .setFont(f)
                      .setText("Angle: "+ angle)
                      .setSize(100,20)
                      .setColor(color(0))
                      .hideScrollbar()
                      .setColorBackground(col)
                      .moveTo(g1)
                      ;*/
      
      cp5_2.addToggle("toggle6_show")
           .setPosition(0,135)
           .setSize(20,20)
           .setValue(false)
           .setCaptionLabel("triangle law")
           .plugTo( this, "toggle6" )
           .moveTo(g1)
           ;
      cp5_2.addButton("isolate")
           .setValue(0)
           .setCaptionLabel("ISOLATE")
           .plugTo( this, "isolate" )
           .setPosition(60,135)
           .setSize(50,20)
           .moveTo(g1)
           ;
           
      setMag = cp5_2.addSlider( "value-"+thePrefix )
                       .setPosition(0,0)
                       .setRange( 0, 800 )
                       .setValue( magnitude )
                       .setSize(100,20)
                       .setColorValue(0)
                       .setColorForeground(col)
                       .setLabel("magnitude")
                       .setSliderMode(1)
                       .moveTo(g1)
                       ;
         
      setAngle = cp5_2.addSlider( "value-"+thePrefix+1 )
                         .setPosition(0,30)//yb+30
                         .setRange( 0, 360 )//57.42
                         .setValue( 90 )
                         .setSize(100,20)
                         .setColorValue(0)
                         .setColorForeground(col)
                         .setLabel("angle")
                         .setSliderMode(1)
                         .moveTo(g1)
                         ;
      
       
    }
    
    
    accordion = cp5_2.addAccordion("acc")
                 .setPosition(xb,yb)
                 .setWidth(145)
                 .setHeight(50)
                 .addItem(g1)
                 .addItem(g2)
                 ;
    
    accordion.open(0);
    accordion.setCollapseMode(Accordion.MULTI);
    /////////////////
    /////////////////
    
  }
  
  
  void updateSliders()
  {
    
    float ang = degrees(acos(getVector().x/getVector().mag()));
    
    if(getVector().y < 0)ang = 360 - ang;
    
    setAngle.setValue(ang);
    angle = radians(ang);
    setMag.setValue(mag);
  }
  
  
  void isolate(int theValue)
  {
    iso(c);
  }
  
  void setValue(int theValue) {
    magnitude = theValue;
  }
  
  void setAngle(float theValue) {
    angle = ((theValue)/57.42);
    /*if(magnitude > 0)
    {
      angle = ((theValue)/57.42);
    }
    
    else
    {
      println("pass");
    }*/
    
    /*if(setAngle_slider)
    {
      angle = PI - (theValue/57.42);
    }*/
    
    
  }
  
  void toggle1(boolean theFlag) 
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
  
  void toggle2(boolean theFlag)
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
  
  void toggle3(boolean theFlag) 
  {
    if(theFlag) 
    {
      components = true;
    }
    else 
    {
      components = false;
    }
  }
  
  void toggle4(boolean theFlag) 
  {
    
    if(theFlag) 
    {
      selected = true;
      
      if(vector_anglesel.size() == 2)
      {
        vector_anglesel.add(this);
        println(vector_anglesel.size());
        vector_anglesel.get(0).setSelected(false);
      }
      else
      {
        vector_anglesel.add(this);
        println(vector_anglesel.size());
      }
    }
    else 
    {
      selected = false;
      vector_anglesel.remove(this);
    }
  }
  
  /*void toggle4(boolean theFlag)
  {
    if(theFlag) 
    {
      selected = true;
      vector_anglesel.add(this);
    }
    else 
    {
      selected = false;
      vector_anglesel.remove(this);
    }
  }*/
  
  
  void toggle4_add(boolean theFlag) 
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
  
  void toggle5_sub(boolean theFlag) 
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
  
  void toggle6(boolean theFlag) 
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
  
  
  
  void sum()
  {
    PVector v;
    v = new PVector(0,0);
    for(int i=0; i<vector_addsel.size(); ++i)
    {
      v.add(vector_addsel.get(i).getVector());
    }
    
    c = v;      
    
  }
  
  void subtract()
  {
    PVector v;
    v = new PVector(0,0);
    for(int i=1; i<vector_subsel.size(); ++i)
    {
      v = PVector.sub(vector_subsel.get(0).getVector(),vector_subsel.get(i).getVector());
    }
    c = v;
  }
  
  void trianglelaw()
  {
    if(sumnonsingle)
    {
      //print("asas");
      for(int i=0; i<vector_addsel.size(); ++i)
      {
        tri_x = vector_addsel.get(i).getVector().x;
        tri_y = vector_addsel.get(i).getVector().y;
        //println(tri_x, vector_addsel.get(i).getVector().x);
      }
    }
    
    else
    {
      //print("sub");
      for(int i=0; i<vector_subsel.size(); ++i)
      {
        tri_x = -(vector_subsel.get(i).getVector().x);
        tri_y = -(vector_subsel.get(i).getVector().y);
        //println(tri_x, vector_addsel.get(i).getVector().x);
      }
    }
  }
  
  int getVecnumber()
  {
    return vecNo;
  }
  
  color getColor()
  {
    return col;
  }
  
  PVector getVector()
  {
    return c;
  }
  
  boolean getSelect()
  {
    return selected;
  }
  
  void setSelected(boolean sel)
  {
    selected = sel;
    vector_anglesel.remove(this);
    selAngl.setValue(sel);
  }
  
  
  float[] getBase()
  {
    float[] a = {ex,ey};
    return a;
  }
  
  float getAngle()
  {
    float agl = PVector.angleBetween(c,UNIV_X);
    return agl;
  }
  
  float getAngleC()
  {
    
    return angle;
  }
  
  void calculate()
  {
    if(chkanglfstime)
    {
      //println("in here 1");
      angle = acos(x/c.mag());
      //alpha = -90;
      chkanglfstime = false;
    }
    
    /*if(magnitude>0)
    {
      println("in here 2");
      angle_control.setValue((PI - angle)*57.42);
      setAngle_slider = false;
    }
    
    else if(magnitude<0 && !setAngle_slider)
    {
      println("in here 3");
      angle_control.setValue((PI-angle)*57.42);
      setAngle_slider = true;
    }*/
    
    x = cos(angle)*magnitude;
    y = sin(angle)*magnitude;
    
    c.x = x;
    c.y = y;
  }
  
  
  void updt_details()
  {
    myTextarea.setText("x-Comp= "+int(c.x)+"\n"
                      +"y-Comp= "+int(c.y)+"\n"
                      +"Magnitue= "+int(c.mag())+"\n"
                      +"Angle= "+int(degrees(angle))+"\n"
                      );
  }
  
  
  
  void drw()
  {
    fill(col);
    stroke(col);
    strokeWeight(3);
    mag = c.mag();
    if(visibility)
    {
      //println("in here 4");
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
    
    
    updt_details();
    
    
  }
  
  void drwarrow(float inx, float iny, float finlx, float finly)
  {
    line(inx,iny,finlx,finly);
    float a;
    float ta, ah=90;
    
    if(single)
    {
      a = angle*57.42;
      ta = 180-a;
      ah = ta-45;
      
      translate(finlx,finly);
    
      rotate(radians(ah));
      if(magnitude>0)//print();
        line(0,0,8,0);
      
      else if(magnitude == 0)
        line(0,0,0,0);
      
      else
        line(0,0,-8,0);
        
      rotate(radians(-ah));
    
      
      rotate(radians(ah+90));
      if(magnitude>0)
        line(0,0,8,0);
      
      else if(magnitude == 0)
        line(0,0,0,0);  

      else
        line(0,0,-8,0);
      rotate(radians(-(ah+90)));
    
      translate(-finlx,-finly);
    }
    
    if(!single && c.mag() != 0)
    {
      
      if(!lawproof)
      {
        a = atan(c.y/c.x)*57.42;
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
  }
  
  void moved()
  {
    ex = mouseX;
    ey = mouseY;
  }
};

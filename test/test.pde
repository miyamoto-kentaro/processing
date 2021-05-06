int oldsec;     //1フレーム前の秒を覚えておく
int sepFrame;
int dif_time = 0;
int[] col = new int[3];

float clock_radius;

void setup(){
  size(640, 480);
  clock_radius = height*0.9;
  col[0] = 0;
  col[1] = 0;
  col[2] = 0;
}

void draw(){
  background(col[0],col[1],col[2]);
  float sec, min, hour; //as second
  float[] time = new float[4];
  time = get_time();
//   println(time);
  sec = time[1];
  min = time[2];
  hour = time[3];
  
  float sec_angle, min_angle, hour_angle;
  hour_angle = 2*PI*hour/(12*60*60);
  min_angle = 2*PI*min/(60*60);
  sec_angle = 2*PI*sec/60;
  
  draw_clock(width/2,height/2, sec_angle,min_angle,hour_angle,clock_radius);
  //draw_clock(width/6,height/2, sec_angle,min_angle,hour_angle,clock_radius);
  fill(255,0,255);
  textAlign(CENTER,CENTER);
  textSize(clock_radius*0.05);
  text(year()+","+month()+","+day(), width/36*13,height/5);
}

void draw_clock(float x,float y,float sec_hand,float min_hand,float hour_hand,float clock_radius){
  //draw clocke frames
  translate(x,y);
  fill(255);
  circle(0,0,clock_radius);
  //drawing mem
  for(int count=0; count<60; count++){
    strokeWeight(0.1);
    if(count%5==0){
      strokeWeight(1);
    }
    line(0,-clock_radius*0.4,0,-clock_radius/2);
    rotate(2*PI/60);
  }
  fill(255,0,0);
  
  textAlign(CENTER,CENTER);
  textSize(clock_radius*0.1);
  text(nf(hour()-dif_time, 2)+":"+nf(minute(), 2)+":"+nf(second(), 2), 0, clock_radius*0.05);
  
  draw_hand(sec_hand,0.45*clock_radius,height*0.001);
  draw_hand(min_hand,0.4*clock_radius,height*0.005);
  draw_hand(hour_hand,0.3*clock_radius,height*0.003);
  
  fill(0);
  circle(0,0,clock_radius*0.01);
}

void draw_hand(float angle,float hand_radius,float line_Weight){
  strokeWeight(line_Weight);
  rotate(angle);
  line(0,0,0,-hand_radius);
  rotate(-angle);
}

float[] get_time(){
    int h, m, s;
    float[] time = new float[4];
    h=hour() - dif_time;
    m=minute();
    s=second();
    if(s!=oldsec) sepFrame=frameCount;

    oldsec=s;
    
    // 時刻を表示
    // print(nf(h, 2)+":"+nf(m, 2)+":"+nf(s, 2)+"   ");
    // println(frameCount-sepFrame);
    time[0] = frameCount-sepFrame;
    time[1] = s + time[0]/frameRate;
    time[2] = m*60 + time[1];
    time[3] = h*60*60;
    return time;
}

void keyPressed() {

  if (key == 'a') {// キーコードを判定
    dif_time=13;
  } else if (key == 'f') {// キーの文字を判定
    dif_time=7;
  } else if (key == 'b') {// キーの文字を判定
    dif_time=8;
  }else if (key == 'c') {// キーの文字を判定
    dif_time=1;
  }else if (key == 'j') {
      dif_time=0;
  }
}

void mousePressed(MouseEvent e) {
  switch( e.getButton() ){
      case LEFT:
        col[0] = 255;
        break;
      case CENTER:
        col[1] = 255;
        break;
      case RIGHT:
        col[2] = 255;
        break;
      default:
        break;
    }
}



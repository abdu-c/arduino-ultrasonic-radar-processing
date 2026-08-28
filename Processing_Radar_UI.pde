import processing.serial.*;

Serial myPort;
String angle = "0";
String distance = "0";
String data = "";
float pixsDistance;
int iAngle = 0;
int iDistance = 0;

void setup() {
  size(1200, 700);
  smooth();
  
  try {
    myPort = new Serial(this, "COM9", 9600); // Kendi COM portunuzu girin
    myPort.bufferUntil('.');
  } catch (Exception e) {
    println("Port acilamadi: " + e.getMessage());
  }
}

void draw() {
  fill(98, 245, 31);
  noStroke();
  fill(0, 4); 
  rect(0, 0, width, height - height * 0.065); 
  
  fill(98, 245, 31);
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  try {
    data = myPort.readStringUntil('.');
    if (data != null) {
      data = data.trim();
      if (data.endsWith(".")) {
        data = data.substring(0, data.length() - 1);
      }
      
      int index1 = data.indexOf(",");
      if (index1 > 0) {
        angle = data.substring(0, index1);
        distance = data.substring(index1 + 1, data.length());
        
        iAngle = int(angle.trim());
        iDistance = int(distance.trim());
      }
    }
  } catch(Exception e) {
  }
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);
  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  line((-width / 2) * cos(radians(30)), 0, width / 2, 0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  strokeWeight(9);
  stroke(255, 10, 10); // Algilanan nesne kirmizi renkle isaretlenir
  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);
  if (iDistance < 40 && iDistance > 0) {
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.074);
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  fill(0, 0, 0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);
  
  textSize(40);
  text("Radar Telemetri", width - width * 0.875, height - height * 0.0277);
  text("Aci: " + iAngle + " deg", width - width * 0.48, height - height * 0.0277);
  text("Mesafe: ", width - width * 0.26, height - height * 0.0277);
  if (iDistance < 40) {
    text("        " + iDistance + " cm", width - width * 0.225, height - height * 0.0277);
  }
  popMatrix();
}

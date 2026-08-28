// [TR] Arduino Uno, HC-SR04 & SG90 Servo ile Radar Telemetri Sistemi
// [EN] Radar Telemetry System with Arduino Uno, HC-SR04 & SG90 Servo

#include <Servo.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int trigPin = 9;
const int echoPin = 10;
const int servoPin = 11;
const int ledPin = 12;

Servo radarServo;
long sure;
int mesafe;

int mesafeOlc() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  sure = pulseIn(echoPin, HIGH);
  mesafe = sure * 0.034 / 2;
  return mesafe;
}

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  
  Serial.begin(9600);
  
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("RADAR SISTEMI");
  lcd.setCursor(0, 1);
  lcd.print("BASLATILIYOR...");
  
  radarServo.attach(servoPin);
  delay(1000);
  lcd.clear();
}

void loop() {
  // 15 - 165 derece ileri tarama
  for (int aci = 15; aci <= 165; aci += 2) {
    radarServo.write(aci);
    delay(30);
    mesafe = mesafeOlc();
    
    // Processing GUI Veri Protokolü: "Aci,Mesafe."
    Serial.print(aci);
    Serial.print(",");
    Serial.print(mesafe);
    Serial.print(".");
    
    lcd.setCursor(0, 0);
    lcd.print("Aci: ");
    lcd.print(aci);
    lcd.print(" deg   ");
    
    lcd.setCursor(0, 1);
    lcd.print("Mesafe: ");
    lcd.print(mesafe);
    lcd.print(" cm  ");
    
    if (mesafe > 0 && mesafe < 20) {
      digitalWrite(ledPin, HIGH);
    } else {
      digitalWrite(ledPin, LOW);
    }
  }
  
  // 165 - 15 derece geri tarama
  for (int aci = 165; aci >= 15; aci -= 2) {
    radarServo.write(aci);
    delay(30);
    mesafe = mesafeOlc();
    
    Serial.print(aci);
    Serial.print(",");
    Serial.print(mesafe);
    Serial.print(".");
    
    lcd.setCursor(0, 0);
    lcd.print("Aci: ");
    lcd.print(aci);
    lcd.print(" deg   ");
    
    lcd.setCursor(0, 1);
    lcd.print("Mesafe: ");
    lcd.print(mesafe);
    lcd.print(" cm  ");
    
    if (mesafe > 0 && mesafe < 20) {
      digitalWrite(ledPin, HIGH);
    } else {
      digitalWrite(ledPin, LOW);
    }
  }
}

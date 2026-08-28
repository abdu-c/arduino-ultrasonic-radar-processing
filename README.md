# 2D Ultrasonic Radar & Telemetry GUI with Arduino & Processing

[TR] Bu proje; HC-SR04 ultrasonik mesafe sensörü, SG90 servo motor aktüatörü ve Processing IDE tabanlı Grafiksel Kullanıcı Arayüzü (GUI) kullanarak $15^\circ - 165^\circ$ aralığında 2 boyutlu ortam taraması ve nesne tespiti yapan gerçek zamanlı bir radar sistemidir.
[EN] This project is a real-time 2D radar telemetry and object tracking system utilizing an HC-SR04 ultrasonic sensor mounted on an SG90 servo motor actuator, visualised via a Processing IDE Graphical User Interface (GUI) over serial communication.

---

## Donanım Bileşenleri / Hardware Components
- 1x Arduino Uno
- 1x SG90 Mikro Servo Motor (Aktüatör / Actuator)
- 1x HC-SR04 Ultrasonik Mesafe Sensörü / Ultrasonic Distance Sensor
- 1x 16x2 I2C LCD Ekran Modülü / Character LCD Display
- 1x Durum LED'i & 220 Ohm Direnç / Status LED & Resistor
- Breadboard & Jumper Kablolar / Jumper Wires

## Bağlantı Şeması / Pin Configuration
- **SG90 Servo Sinyal (Turuncu/Sarı):** Dijital Pin `11` | **VCC/GND:** `5V` / `GND`
- **HC-SR04 Trig:** Dijital Pin `9` | **Echo:** Dijital Pin `10` | **VCC/GND:** `5V` / `GND`
- **I2C LCD SDA:** `A4` | **SCL:** `A5` | **VCC/GND:** `5V` / `GND`
- **LED Anot (+):** Dijital Pin `12` | **Katot (-):** `220 ohm` ile `GND`

## Sistem Mimarisi & Çalışma Prensibi / Working Principle
1. **Aktüatör Kontrolü (Servo):** SG90 mikro servo motor, sensörü $15^\circ$ ile $165^\circ$ arasında $2^\circ$ adımlarla tarayacak şekilde yönlendirilir.
2. **Ultrasonik Mesafe Tespiti:** Her açı adımında 10 µs'lik ultrasonik tetikleme sinyali yayılarak ekolokasyon formülü (`mesafe = sure * 0.034 / 2`) ile engel mesafesi hesaplanır.
3. **Seri Telemetri Akışı:** Açı ve mesafe verileri özel bir seri veri paketine (`Açı,Mesafe.`) dönüştürülerek 9600 baud hızında bilgisayara aktarılır.
4. **GUI & Görselleştirme (Processing):** Processing arayüzü gelen paketleri parse ederek polar koordinatları kartezyen düzleme ($X,Y$) dönüştürür. $40\text{ cm}$ menzil içerisindeki engeller radar ekranında kırmızı çizgilerle dinamik olarak çizilir.

## Yazılım Gereksinimleri / Software Dependencies
- Arduino IDE (Dahili `Servo.h`, `Wire.h` ve `LiquidCrystal_I2C.h`)
- Processing 3.5.4 (`processing.serial.*`)

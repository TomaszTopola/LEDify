#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Adafruit_NeoPixel.h>
#include <ArduinoJson.h>

//led variables
const int LED_PIN = D8;
const int LED_AMOUNT = 16;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(LED_AMOUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

//WiFi variables
IPAddress local_ip(192,168,2,1);
IPAddress gateway(192,168,2,1);
IPAddress subnet(255,255,255,0);
const char* ssid = "NodeMCU";
const char* password = "87654321*";

//server variables
ESP8266WebServer server(80);

void setupLED(){
  pinMode(LED_PIN, OUTPUT);
  strip.begin();
  strip.show();
  strip.setBrightness(64);
  strip.fill(strip.Color(255,255,0), 0, 16);
  strip.show();
}

void setupWiFi(){
  WiFi.softAP(ssid, password);
  WiFi.softAPConfig(local_ip, gateway, subnet);
  delay(100);
}

 void setupServer(){
  server.on("/", handle_OnConnect);
  server.on("/set-color", handleSetColor);
  server.on("/multiple-set-color", handleMultipleSetColor);
  server.onNotFound(handle_NotFound);
  server.begin();
}

void setup(){
  Serial.begin(9600);
  setupWiFi();
  setupServer();
  setupLED();
  strip.fill(strip.Color(0,255,0), 0, 16);
  strip.show();
}

void loop() {
  server.handleClient();
}

void handle_OnConnect() {
 server.send(200, "text/plain", "Hello world!");
}

void handleSetColor(){
  if (server.hasArg("plain")== false){
    server.send(401, "text/plain", "Body not received");
    return;
  }
  DynamicJsonDocument doc(1024);
  deserializeJson(doc, server.arg("plain"));

  strip.setPixelColor(doc["INDEX"], strip.Color(doc["R"], doc["G"], doc["B"]));
  strip.show();

  server.send(200, "application/json", server.arg("plain"));
  Serial.println(server.arg("plain")); 
}

void handleMultipleSetColor(){
  if (server.hasArg("plain")== false){
    server.send(401, "text/plain", "Body not received");
    return;
  }
  DynamicJsonDocument doc(1024);
  deserializeJson(doc, server.arg("plain"));

  strip.fill(strip.Color(doc["R"], doc["G"], doc["B"]), doc["START-INDEX"], doc["END-INDEX"]);
  strip.show();

  server.send(200, "application/json", server.arg("plain"));
  Serial.println(server.arg("plain")); 
}

void handle_NotFound(){
  server.send(404, "text/plain", "Not found");
}

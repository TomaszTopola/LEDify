# LEDify

This application is designed to communicate with Arduino-kind board to control LED lamps. All 
arduino scripts were designed for NodeMCU v3. You may need to adjust some parts of the code
for different boards to work. Please keep in mind, that this is a very early version of this 
application. 

## Getting Started

In order to get started you will need an Arduino board with ESP8266 WiFi module and set of LED 
modules compatible with AdaFruit NEOPIXEl library. Signal pin is set to D8 as default. You may
change that later.
1. Install script from `WiFi_LEDs_v2.ino` on your board. If your board is different than NodeMCU v3
you may need to adjust the script.
2. Install this mobile app on your phone
3. Connect to your board's  WiFi. By default SSID is `NodeMCU` and password is `87654321*`

## Project Structure

For you as a developer the most important package is `api`. You can find there classes that are used
to send requests to the board. 

#### LedRange class

This class is used to store http request body with 5 parameters:
- `R`, `G` and `B` for PWM values that are going to be set on LED after sending request. They are set as 
8-bit values by default. In order to use different formats please fill `bit` param for example with 16.
Otherwise the class won't allow using values higher than 255.
- `START-INDEX` and `END-INDEX`: `START-INDEX` is the first module, from which the board will start
filling LEDs. `END-INDEX` is amount of leds that are going to be set. The name is confusing, because
it has been incorrectly assigned while creating server app for arduino. It will be changed in future 
updates.

Methods for `LedRange`:
- `void setValue({int value, String key})` allows you to set specific value on key (one of the above).
- `void setRange({int start, int count})` changes  `START-INDEX` and `END-INDEX`
- `int getValue({String key})` returns value from given key (one of the above)
- `Map<String, dynamic> getValues()` returns whole map. You will use this one
when sending requests to the board via `Lamp` class

#### Lamp class

Lamp clas is the direct connection to the board. With its methods you will send HTTP requests
to the board. There are available several methods:
- `static Future<Response> fill({Map<String, dynamic> data}) async` To use it you'll usually provide
LedRange.getValues(), which is body of HTTP POST request.

# license

Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
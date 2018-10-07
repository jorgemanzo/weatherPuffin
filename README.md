## Weather Puffin
MacOS app that gives you the weather from a zip code. Doesn't look that great currently but hey it works.

Maybe there will be a background or theme that will change depending on the
temperature.

Currently, all this app does is take your zip code and returns the temperature
from the nearest available weather station provided by Open Weather Map.

A refresh will occur every 8 seconds (if I remember correctly) and it should switch weather description and temp as well as enable the related icons to the right.

![](/resources/normalMode.png)
![](/resources/darkMode.png)

### Setup
1.	Clone this repo somewhere.


2.	Install the required pods. First you will need [CocoaPods](https://cocoapods.org), then you will need to install [Alamofire](https://cocoapods.org/pods/Alamofire) for performing the HTTP requests, and [AlamofireObjectMapper](https://cocoapods.org/pods/AlamofireObjectMapper) to turn JSON response into Swift objects. The only thing you really have to install is cocoapods itself, then you can follow [these](https://guides.cocoapods.org/using/using-cocoapods.html) instructions. In the main directory of the repo, you should be able to use the provided Podfile to install Alamofire and AlamofireObjectMapper without too much trouble. If anytihng is missing, please start an issue!


3.	(Maybe) You'll need to allow incoming and outgoing connections in xCode, and maybe a few other small things that xCode can guide you through.
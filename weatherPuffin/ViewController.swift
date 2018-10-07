//
//  ViewController.swift
//  weatherPuffin
//
//  Created by Jorge on 9/6/18.
//  Copyright © 2018 Beep. All rights reserved.
//  Say hi please
//

import Cocoa
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
//structs for mapping response json
class weatherResponse: Mappable {
    required init?(map: Map) {
        
    }
    
    var coord: coordinatePairs?;
    var weather: [weatherInfo]?;
    var base: String?;
    var main: mainInfo?;
    var visibility: Int?;
    var wind: windInfo?;
    var clouds: cloudsInfo?;
    var dt: Int?;
    var sys: sysInfo?;
    var id: Int?;
    var name: String?;
    var cod: Int?;
    
    
    func mapping(map: Map) {
        coord <- map["coord"];
        weather <- map["weather"];
        base <- map["base"];
        main <- map["main"];
        visibility <- map["visibility"];
        wind <- map["wind"];
        clouds <- map["clouds"];
        dt <- map["dt"];
        sys <- map["sys"];
        id <- map["id"];
        name <- map["name"];
        cod <- map["cod"];
    }
    
}

class sysInfo: Mappable{
    required init?(map: Map) {
        
    }
    
    var type: Int?;
    var id: Int?;
    var message: Int?;
    var country: String?;
    var sunrise: Int?;
    var sunset: Int?;
    
    func mapping(map: Map) {
        type <- map["type"];
        id <- map["id"];
        message <- map["message"];
        country <- map["country"];
        sunrise <- map["sunrise"];
        sunset <- map["sunset"];
    }
}


class cloudsInfo: Mappable{
    required init?(map: Map) {
        
    }
    
    var all: Int?;
    
    func mapping(map: Map) {
        all <- map["all"];
    }
}

class windInfo: Mappable {
    required init?(map: Map) {
        
    }
    
    var speed: Int?;
    var deg: Int?;
    
    func mapping(map: Map) {
        speed <- map["speed"];
        deg <- map["deg"];
    }
}

class mainInfo: Mappable {
    required init?(map: Map) {
        
    }
    
    var temp: Int?;
    var pressure: Int?;
    var humidity: Int?;
    var temp_min: Int?;
    var temp_max: Int?;
    
    func mapping(map: Map) {
        temp <- map["temp"];
        pressure <- map["pressure"];
        humidity <- map["humidity"];
        temp_min <- map["temp_min"];
        temp_max <- map["temp_max"];
    }
}

class weatherInfo: Mappable {
    required init?(map: Map) {
        
    }
    
    var id: Int?;
    var main: String?;
    var description: String?;
    var icon: String?;
    
    func mapping(map: Map) {
        id <- map["id"];
        main <- map["main"];
        description <- map["description"];
        icon <- map["icon"];
    }
}

class coordinatePairs: Mappable {
    required init?(map: Map) {
        
    }
    
    var lon: Int?;
    var lat: Int?;
    
    func mapping(map: Map){
        lon <- map["lon"];
        lat <- map["lat"];
    }
}




class ViewController: NSViewController {
    var timer : Timer = Timer();
    
    @IBOutlet weak var zipField: NSTextField!
    
    @IBOutlet weak var tempLabel: NSTextField!
    
    @IBOutlet weak var stationLabel: NSTextField!
    
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    @IBOutlet weak var rainCloud: NSImageView!
    
    @IBOutlet weak var sunIcon: NSImageView!
    
    @IBOutlet weak var cloudIcon: NSImageView!
    
    @IBOutlet weak var snowCloud: NSImageView!
    
    @IBOutlet weak var lightningCloud: NSImageView!
    
    @IBAction func goButtonClicked(_ sender: Any) {
        getData();
    }
    
    @IBAction func zipFieldAction(_ sender: NSTextField) {
        getData();
    }
    
    @objc func getData() -> Void {
        timer.invalidate();
        var zipCode = zipField.stringValue;
        if(zipCode.isEmpty){
            zipCode = "93761";
        }
        if(!(zipCode.count < 5 || zipCode.count > 5)) {
            let apiCall = "https://api.openweathermap.org/data/2.5/weather?zip=" + zipCode + ",us&APPID=aa9644578cbb315c8d2f7c97b00ecba3";
            
            Alamofire.request(apiCall).responseObject { (response: DataResponse<weatherResponse>) in
                let weatherResp = response.result.value;
                let tKelvin = (weatherResp?.main?.temp)!;
                var tFahrenheit = (Double(tKelvin) * Double(9.0/5.0)) - 459.67;
                tFahrenheit = floor(tFahrenheit);
                self.descriptionLabel.stringValue = (weatherResp?.weather?[0].description)!;
                self.tempLabel.stringValue = String(tFahrenheit) + " °F";
                self.stationLabel.stringValue = (weatherResp?.name)!;
                self.hideIcons();
                for weatherPack in (weatherResp?.weather)!{
                    self.setWeatherIcon(descript: weatherPack.main!);
                }
            }
            timer = Timer.scheduledTimer(timeInterval: 480, target: self, selector: #selector(self.getData), userInfo: nil, repeats: true)
        }
        
    }
    
    
    func setWeatherIcon(descript: String) -> Void {
        if(descript == "Rain"){
            self.rainCloud.isEnabled = true;
        } else if(descript == "Clear"){
            self.sunIcon.isEnabled = true;
        } else if(descript == "Clouds"){
            self.cloudIcon.isEnabled = true;
        } else if(descript == "Snow"){
            self.snowCloud.isEnabled = true;
        } else if(descript == "Thunderstorm"){
            self.lightningCloud.isEnabled = true;
        }
        
    }
    
    func hideIcons() {
        self.rainCloud.isEnabled = false;
        self.sunIcon.isEnabled = false;
        self.cloudIcon.isEnabled = false;
        self.snowCloud.isEnabled = false;
        self.lightningCloud.isEnabled = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideIcons();
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}


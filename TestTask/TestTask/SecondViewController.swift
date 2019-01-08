//
//  SecondViewController.swift
//  TestTask
//
//  Created by Ruslan Kondratev on 07/01/2019.
//  Copyright © 2019 Ruslan Kondratev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    //MARK: - enums controller
    enum fieldsData:Int
    {
        case mail = 0
        case pass = 1
    }
    enum fieldsWeather:Int
    {
        case town = 0
        case temp = 1
        case speedWind = 2
    }
    //MARK: - variable controlers
    var mail_word:String!
    var pass_word:String!
    
    var weather:UIAlertController!
    var wrongData:UIAlertController!
    
    var textFields: Array<UITextField?> = []
    var hintLabels: Array<UILabel?> = []
    var placeholders: Array<Array<String?>> = []
    
    var checkButton:UIButton!
    
    var locationDic:Dictionary<String, Any>?
    var currentDic:Dictionary<String, Any>?
    
    var imageWeather:UIImage?
    //MARK: - preference function
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern#2.jpg")!)
        mail_word = String()
        pass_word = String()
        placeholders.append(["you@example.com","Creat a password"])
        placeholders.append(["введите корректное имя почтового ящика, согласно заданию","Введите корректный пароль, согласно заданию"])

        for i : Int in 0..<2
        {
            textFields.append(UITextField())
            textFields[i]?.placeholder = placeholders[0][i]
            textFields[i]?.font = UIFont.systemFont(ofSize: 30)
            textFields[i]?.textColor = .black
            textFields[i]?.textAlignment = .center
            textFields[i]?.backgroundColor = .white
            textFields[i]?.layer.borderWidth = 2
            textFields[i]?.layer.cornerRadius = 5
            textFields[i]?.layer.borderColor = UIColor.gray.cgColor
            textFields[i]?.sizeToFit()
            textFields[i]?.adjustsFontSizeToFitWidth = true
            textFields[i]?.isUserInteractionEnabled = true
            textFields[i]?.becomeFirstResponder()
            textFields[i]?.frame = CGRect(x: (self.view.bounds.width - textFields[i]!.bounds.width)/2, y: CGFloat(Float(2 + i) / Float(6)) * self.view.bounds.height, width: textFields[i]!.bounds.width, height: textFields[i]!.bounds.height)
            textFields[i]?.delegate = self
            self.view.addSubview(textFields[i]!)
            
            hintLabels.append(UILabel())
            hintLabels[i]?.text = placeholders[1][i]
            hintLabels[i]?.font = UIFont.systemFont(ofSize: 12)
            hintLabels[i]?.textColor = .lightGray
            hintLabels[i]?.textAlignment = .center
            hintLabels[i]?.sizeToFit()
            hintLabels[i]?.frame = CGRect(x: (self.view.bounds.width - hintLabels[i]!.bounds.width)/2, y: textFields[i]!.frame.maxY, width: self.hintLabels[i]!.bounds.width, height: hintLabels[i]!.bounds.height)
            self.view.addSubview( hintLabels[i]!)
        }
        
        self.checkButton = UIButton(type: .roundedRect)
        self.checkButton.setTitle("validate", for: .normal)
        self.checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.checkButton.sizeToFit()
        self.checkButton.frame = CGRect(x: (self.view.bounds.width - self.checkButton.bounds.width)/2, y: hintLabels[1]!.frame.maxY + 100, width: self.checkButton.bounds.width + 10, height: self.checkButton.bounds.height)
        self.checkButton.layer.cornerRadius = 8
        self.checkButton.backgroundColor = .lightGray
        self.checkButton.addTarget(self, action: #selector(checkData), for: .touchDown)
        self.view.addSubview(self.checkButton)
        
        self.weather = UIAlertController(title: "", message: "", preferredStyle: .alert)
        self.weather.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.wrongData = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        self.wrongData.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK: - check mail and password function
    func isValidEmailAddress(_ emailAddressString: String) -> Bool
    {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    func isValidPasswordAddress(_ passwordAddressString: String) -> Bool
    {
        
        var returnValue = true
        let RegEx:Array<String> = [".*[A-Z]{1}.*",".*[a-z]{1}.*",".*[0-9]{1}.*","^.{6}$"]
        var results:Array<Array<NSTextCheckingResult>> = []
        
        do {
            let nsString = passwordAddressString as NSString
            for passRegEx in RegEx
            {
                let regex = try NSRegularExpression(pattern: passRegEx)
                results.append(regex.matches(in: passwordAddressString, range: NSRange(location: 0, length: nsString.length)))
            }
            
            
            if results[0].count == 0 || results[1].count == 0 || results[2].count == 0 || results[3].count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    //MARK: - action button function
    @objc func checkData()
    {
        weather.message = nil
        wrongData.message = nil
        
        if isValidEmailAddress(mail_word) == true
        {
            if isValidPasswordAddress(pass_word) == true
            {weather.message = "Данные введены верно"}
            else {wrongData.message = "Пароль не соответствует требованию"}
        }
        else
        {
            if isValidPasswordAddress(pass_word) == true
            {wrongData.message = "Почта введена не верно"}
            else {wrongData.message = "Данные не соответствуют требованию"}
        }
        if weather.message == nil
        {
            self.present(wrongData, animated: true, completion: nil)
        }
        else
        {
            guard self.getWeather() == true else {weather.message = "Неудачная попытка загрузки данных погоды"; return}
            var weatherFields: Array<UITextField>? = self.weather.textFields
            self.weather.message = "Текущая погода"
            if weatherFields!.isEmpty == true
            {
                for _ in 0..<3
                {
                    self.weather.addTextField(configurationHandler: nil)
                }
                weatherFields = self.weather.textFields
            }
            var location = self.locationDic?["name"] as? String
            location!.insert(contentsOf: "локация: ", at: location!.startIndex)
            var tempareture = String(self.currentDic?["temp_c"] as! Double)
            tempareture.insert(contentsOf: "Температура в городе: ", at: tempareture.startIndex)
            var speedWind = String(self.currentDic?["wind_kph"] as! Double)
            speedWind.insert(contentsOf: "Скорость ветра: ", at: speedWind.startIndex)
            weatherFields?[fieldsWeather.town.rawValue].text = location
            weatherFields?[fieldsWeather.temp.rawValue].text = tempareture
            weatherFields?[fieldsWeather.speedWind.rawValue].text = speedWind
            for i : Int in 0..<3
            {
                weatherFields?[i].textAlignment = .center
                weatherFields?[i].isUserInteractionEnabled = false
            }

            self.weather.view.addSubview(UIImageView(image: self.imageWeather))
            self.present(weather, animated: true, completion: nil)
        }

    }
    //MARK: - request weather function
    func getWeather()->Bool
    {
        let request : String = "https://api.apixu.com/v1/current.json?key=19a0f670944a4788829171739190501&q=Saransk"
        let url:URL? = URL(string: request)
        var statusDowload:Bool?
        var conditionDic:Dictionary<String, Any>?
        
        URLSession.shared.dataTask(with: url!)
        {
            (Data, URLResponse, Error) in
            guard let data = Data, Error == nil else {statusDowload = false; return}
            do
            {
                var primaryDic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>
                self.locationDic = primaryDic?["location"] as? Dictionary<String, Any>
                self.currentDic = primaryDic?["current"] as? Dictionary<String, Any>
                conditionDic = self.currentDic?["condition"] as? Dictionary<String, Any>
                statusDowload = true
            }
            catch
            {
               print(self.weather.message = "Error during JSON's type convertion")
               statusDowload = false
            }
        }.resume()
        while(statusDowload == nil){}
        guard statusDowload == true else {return statusDowload!}
        statusDowload = nil
        var stringImage:String? = conditionDic?["icon"] as? String
        stringImage!.insert(contentsOf: "https:", at: stringImage!.startIndex)
        let urlImage:URL? = URL(string: stringImage ?? String())
        
        URLSession.shared.dataTask(with: urlImage!)
        {
            (Data, URLResponse, Error) in
            guard let data = Data, Error == nil else {statusDowload = false; return}
            self.imageWeather = UIImage(data: data)
            statusDowload = true
        }.resume()
        
        while(statusDowload == nil){}
        guard statusDowload == true else {return statusDowload!}
        statusDowload = nil
        return true
    }
}
//MARK: - extension delegate SecondViewController
extension SecondViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason)
    {
        if textField.isEqual(self.textFields[fieldsData.mail.rawValue])
        {self.mail_word = textField.text!}
        else{self.pass_word = textField.text!}
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.isEqual(self.textFields[fieldsData.mail.rawValue])
        {self.textFields[fieldsData.mail.rawValue]?.resignFirstResponder()}
        else{self.textFields[fieldsData.pass.rawValue]?.resignFirstResponder()}
        return true
    }
}


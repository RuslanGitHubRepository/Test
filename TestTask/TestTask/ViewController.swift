//
//  ViewController.swift
//  TestTask
//
//  Created by Ruslan Kondratev on 07/01/2019.
//  Copyright © 2019 Ruslan Kondratev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - variable controller
    var identificationButton:UIButton!
    var headlineLabel:UILabel!
    var hintLabel:UILabel!
    //MARK: - preference function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern#1.jpg")!)
        self.identificationButton = UIButton(type: .roundedRect)
        self.identificationButton.setTitle("identification", for: .normal)
        self.identificationButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.identificationButton.sizeToFit()
        self.identificationButton.frame = CGRect(x: (self.view.bounds.width - self.identificationButton.bounds.width)/2, y: self.view.bounds.height/2, width: self.identificationButton.bounds.width + 10, height: self.identificationButton.bounds.height)
        self.identificationButton.layer.cornerRadius = 8
        self.identificationButton.backgroundColor = .lightGray
        self.identificationButton.addTarget(self, action: #selector(pushButton), for: .touchDown)
        self.view.addSubview(self.identificationButton)
        self.headlineLabel = UILabel()
        self.headlineLabel.text = "Verification work"
        self.headlineLabel.font = UIFont.systemFont(ofSize: 25)
        self.headlineLabel.textAlignment = .center
        self.headlineLabel.textColor = .purple
        self.headlineLabel.sizeToFit()
        self.headlineLabel.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: self.headlineLabel.bounds.height)
        self.view.addSubview(self.headlineLabel)
        self.hintLabel = UILabel()
        self.hintLabel.text = "push the button for identification"
        self.hintLabel.font = UIFont.systemFont(ofSize: 12)
        self.hintLabel.textColor = .lightGray
        self.hintLabel.textAlignment = .center
        self.hintLabel.sizeToFit()
        self.hintLabel.frame = CGRect(x: (self.view.bounds.width - self.hintLabel.bounds.width)/2, y: self.identificationButton.frame.maxY, width: self.hintLabel.bounds.width, height: self.hintLabel.bounds.height)
        self.view.addSubview(self.hintLabel)
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK: - action button function - notification system
    @objc func pushButton ()
    {
        NotificationCenter.default.post(name: .init(rawValue: "pushButton"), object: nil)
    }

}

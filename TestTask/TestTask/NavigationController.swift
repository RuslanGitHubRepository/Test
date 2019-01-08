//
//  NavigationController.swift
//  TestTask
//
//  Created by Ruslan Kondratev on 07/01/2019.
//  Copyright © 2019 Ruslan Kondratev. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(pushController), name: .init(rawValue: "pushButton"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func pushController()
    {
        let cont = SecondViewController()
        cont.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.pushViewController(cont, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

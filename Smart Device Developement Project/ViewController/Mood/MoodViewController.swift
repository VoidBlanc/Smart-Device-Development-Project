//
//  MoodViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {

    @IBOutlet weak var labelNotification: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
        labelNotification.isHidden = true
        periodButton.forEach{(button) in
            button.isHidden = !button.isHidden
            
        }
    }
    
    
    @IBOutlet var periodButton: [UIButton]!
    
    
    @IBAction func periodTapped(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

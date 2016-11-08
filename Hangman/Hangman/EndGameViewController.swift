//
//  EndGameViewController.swift
//  Hangman
//
//  Created by Milan Saxena on 11/7/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {
    
    var alertTitle: String = ""
    var message: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Start Over", style: .cancel, handler:
            { action in
                self.performSegue(withIdentifier: "backToGame", sender: alertController)
                
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitle(textTitle: String) {
        alertTitle = textTitle
    }
    
    func setMessage(textTitle: String) {
        message = textTitle
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

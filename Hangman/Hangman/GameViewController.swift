//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var tries: UILabel!
    @IBOutlet var hangmanImage: UIImageView!
    @IBOutlet var letters: UILabel!
    var listOfDashes: [UILabel] = []
    var listOfLetters: [UILabel] = []
    var answer: String = ""
    var photoIndex: Int = 1
    var won: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        answer = phrase!
        //let num = phrase?.characters.count
        hangmanImage.image = UIImage(named: "Hangman_State_" +  "\(photoIndex)")
        playGame(secret: phrase!, input: "____")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guessLetter(_ sender: UIButton) {
        let text = sender.currentTitle!
        
        if answer.contains(text) {
            inputLetters(secret: answer, input: text)
            if checkWinState() {
                won = true
                self.performSegue(withIdentifier: "end", sender: sender)
            }
        } else {
            if letters.text! != nil {
                letters.text = letters.text! + text + " "
            } else {
                letters.text = text + " "
            }
            photoIndex += 1
            hangmanImage.image = UIImage(named: "Hangman_State_" +  "\(photoIndex)")
            if photoIndex == 7 {
                won = checkWinState()
//                if winner {
//                    self.performSegue(withIdentifier: "end", sender: sender)
//                }
                self.performSegue(withIdentifier: "end", sender: sender)
            }
            
        }
        
    }
    
    
    func playGame(secret: String, input: String) {
        var i = 0
        var dx = 0
        var dy = 0
        while i < secret.characters.count {
            if i % 5 == 0 {
                dy += 45
                dx = 0
                let indexOfChar = secret.index(secret.startIndex, offsetBy: i)
                
                if secret[indexOfChar] != " " {
                    let label = UILabel(frame: CGRect(x: 33 + dx, y: 139 + dy,  width: 42, height: 21))
                    label.text = input
                    listOfDashes.append(label)
                    self.view.addSubview(label)
                }
            } else {
                let indexOfChar = secret.index(secret.startIndex, offsetBy: i)
                
                if secret[indexOfChar] != " " {
                    let label = UILabel(frame: CGRect(x: 33 + dx, y: 139 + dy,  width: 42, height: 21))
                    label.text = input
                    listOfDashes.append(label)
                    self.view.addSubview(label)
                }
            }
            dx += 78
            i+=1
        }
    }
    
    func inputLetters(secret: String, input: String) {
        var i = 0
        var dx = 0
        var dy = 0
        while i < secret.characters.count {
            if i % 5 == 0 {
                dy += 45
                dx = 0
                let label = UILabel(frame: CGRect(x: 33 + dx, y: 139 + dy,  width: 42, height: 21))
                let indexOfChar = secret.index(secret.startIndex, offsetBy: i)
            
                let indexOfInput = input.index(input.startIndex, offsetBy: 0)
            
                if !secret.isEmpty && !input.isEmpty && secret[indexOfChar] == input[indexOfInput] {
                    label.text = input
                    if !listOfLetters.contains(label) {
                        listOfLetters.append(label)
                    }
                }
                self.view.addSubview(label)
                dx += 78
            } else {
                let label = UILabel(frame: CGRect(x: 33 + dx, y: 139 + dy,  width: 42, height: 21))
                let indexOfChar = secret.index(secret.startIndex, offsetBy: i)
                
                let indexOfInput = input.index(input.startIndex, offsetBy: 0)
                
                if secret[indexOfChar] == input[indexOfInput] {
                    label.text = input
                    if !listOfLetters.contains(label) {
                        listOfLetters.append(label)
                    }
                }
                self.view.addSubview(label)
                dx += 78
            }
            i+=1
        }

    }
    
    
    func checkWinState() -> Bool {
        print(listOfDashes.count)
        print(listOfLetters.count)
        if listOfLetters.count == listOfDashes.count {
            print("You Win")
            return true
        } else {
            print("You Lose")
            return false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EndGameViewController
        if won {
            vc.setTitle(textTitle: "Congratulations! You won!")
            vc.setMessage(textTitle: "The phrase was \(answer)!")
            
        } else {
            vc.setTitle(textTitle: "Sorry! You Lost!")
            vc.setMessage(textTitle: "The phrase was \(answer)!!")
        }
        
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

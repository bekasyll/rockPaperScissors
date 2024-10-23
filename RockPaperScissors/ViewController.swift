//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Bekasyl Asylbekov on 9/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var tiesLabel: UILabel!
    
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    let images = [
        UIImage(named: "rock"),
        UIImage(named: "paper"),
        UIImage(named: "scissors")
    ]
    
    var wins = 0
    var losses = 0
    var ties = 0
    
    override func viewDidLoad() {
         super.viewDidLoad()
         imageView1.image = images[0]
         imageView2.image = images[1]
         updateLabels()
         updateGameMode()
     }

    @IBAction func playButtonTapped(_ sender: Any) {
        if modeSegmentedControl.selectedSegmentIndex == 0 {
            let playerChoice = randomImage()
            let computerChoice = randomImage()
            
            imageView1.image = images[playerChoice]
            imageView2.image = images[computerChoice]
            
            checkResult(playerChoice: playerChoice, computerChoice: computerChoice)
        } else {
            print("Выберите элемент вручную")
        }
    }
    
    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        updateGameMode()
    }

    @IBAction func rockSelected(_ sender: UIButton) {
        animateSelection(button: sender)
        playManual(playerChoice: 0)
    }
    
    @IBAction func paperSelected(_ sender: UIButton) {
        animateSelection(button: sender)
        playManual(playerChoice: 1)
    }
    
    @IBAction func scissorsSelected(_ sender: UIButton) {
        animateSelection(button: sender)
        playManual(playerChoice: 2)
    }

    func playManual(playerChoice: Int) {
        let computerChoice = randomImage()
        imageView1.image = images[playerChoice]
        imageView2.image = images[computerChoice]
        checkResult(playerChoice: playerChoice, computerChoice: computerChoice)
    }

    func randomImage() -> Int {
        return Int.random(in: 0..<images.count)
    }

    func checkResult(playerChoice: Int, computerChoice: Int) {
        if playerChoice == computerChoice {
            ties += 1
            animateTie()
        } else if (playerChoice == 0 && computerChoice == 2) ||
                  (playerChoice == 1 && computerChoice == 0) ||
                  (playerChoice == 2 && computerChoice == 1) {
            wins += 1
            animateWin()
        } else {
            losses += 1
            animateLoss()
        }
        updateLabels()
    }
    
    func updateLabels() {
        winsLabel.text = "Wins: \(wins)"
        lossesLabel.text = "Losses: \(losses)"
        tiesLabel.text = "Ties: \(ties)"
    }

    func updateGameMode() {
        if modeSegmentedControl.selectedSegmentIndex == 0 {
            rockButton.isEnabled = false
            paperButton.isEnabled = false
            scissorsButton.isEnabled = false
        } else {
            rockButton.isEnabled = true
            paperButton.isEnabled = true
            scissorsButton.isEnabled = true
        }
    }


    func animateSelection(button: UIButton) {
        UIView.animate(withDuration: 0.2,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                button.transform = CGAffineTransform.identity
            }
        })
    }

    func animateWin() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView1.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).rotated(by: .pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.imageView1.transform = CGAffineTransform.identity
            }
        })
    }

    func animateLoss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView1.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.imageView1.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.imageView1.transform = CGAffineTransform.identity
                self.imageView1.alpha = 1.0
            }
        })
    }

    func animateTie() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.imageView1.transform = CGAffineTransform(translationX: -10, y: 0)
            self.imageView2.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.imageView1.transform = CGAffineTransform.identity
                self.imageView2.transform = CGAffineTransform.identity
            }
        })
    }
}

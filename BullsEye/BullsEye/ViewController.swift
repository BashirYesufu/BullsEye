//
//  ViewController.swift
//  BullsEye
//
//  Created by Bash_iCode on 7/9/21.
//

import UIKit



class ViewController: UIViewController {
    var currentSliderValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    @IBOutlet weak var targetLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighed")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizeable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int(arc4random_uniform(101))
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        updateLabels()
    }

    @IBAction func showAlert() {
        
        let difference = abs(currentSliderValue - targetValue)
        var points = 100 - difference
        
        if difference == 0 {
            points += 100
        } else if difference == 1 {
            points += 50
        } else {
            score += points
        }
        
        let title : String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Come On! Try Harder!"
        }
        
        let sliderMessage = "You scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: sliderMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The slider is now at \(slider.value)")
        currentSliderValue = lroundf(slider.value)
    }
    
    
}


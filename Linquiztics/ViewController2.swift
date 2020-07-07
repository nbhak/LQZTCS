//
//  ViewController2.swift
//  Linquiztics
//
//  Created by Nathan Bhak on 31/12/2017.
//  Copyright © 2017 Nathan Bhak. All rights reserved.
//


// Import frameworks
import UIKit
import GameplayKit
import AVFoundation

// This view controller manages the question screen
class ViewController2: UIViewController {
    
    // Stores audio players as properties so they are retained while the sound is playing
    var audioPlayer: AVAudioPlayer!
    var bgMusic: AVAudioPlayer!
        
    // Tens prefixes
    let tenPrefix = ["", "undec", "udec", "redec", "cadec", "cidec", "sedec", "sipdec", "odec", "nodec"]
    // Unit suffixes
    let unitSuffix = ["", "un", "u", "re", "ca", "ci", "se", "sip", "o", "no"]
    // Digits
    let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    // Adjectives
    let adjectives = ["dif", "dil", "div"]
    // English adjectives
    let engAdj = ["difficult","careful","beautiful"]
    // Suffixes for making the adjective comparative or superlative
    let adjForms = ["","or","is"]
    // English words for making the adjective comparative or superlative
    let engForms = ["","more ","the most "]
    // Negative prefix
    let negaPrefix = ["","","an"]
    // English negative word
    let engNega = ["","","not "]
    
    // Verbs
    let vbList = ["ambu","cur"]
    // English verbs
    let engVb = ["stroll", "rush"]
    // Prepositional prefixes
    let prepList = ["en","e"]
    // English prepositions
    let engPrep = [" in"," out"]
    // Past tense suffix
    let tenseList = ["","vi"]
    // English past tense suffix
    let engTense = ["","ed"]
    
    // Answer buttons
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    // Clue button
    @IBOutlet weak var clueButton: UIButton!
    // Score label
    @IBOutlet weak var scoreLabel: UILabel!
    // Question label
    @IBOutlet weak var questionLabel: UILabel!
    
    // Stores code language words featured in puzzle
    var code = [String]()
    // Stores English words featured in puzzle
    var eng = [String]()

    // Indicates which answer is correct
    var correctAnswer = 0
    
    // Determines which parts of language are chosen as answer options
    var index1 = 0
    var index2 = 0
    var index3 = 0
    var index4 = 0
    var index5 = 0
    
    // High score
    var highScore = UserDefaults().integer(forKey: "HighScore")
    // Current score
    var score = 0
    // Current level
    var level = 1
    // Keeps track of all the answers' positions in their arrays
    var shift = [0,1,2]
    // Keeps track of the correct answer's position in its array
    var correctness = [1,0,0]
    
    // Question type
    var questionType = 0
    // This function is called after the main view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load popping sound
        let url = Bundle.main.url(forResource: "Blop", withExtension: "mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        }catch let error as NSError {
            print(error.debugDescription)
        }
        // Load music
        let url1 = Bundle.main.url(forResource: "Composition", withExtension: "mp3")
        do{
            bgMusic = try AVAudioPlayer(contentsOf: url1!)
            bgMusic.prepareToPlay()
        }catch let error as NSError {
            print(error.debugDescription)
        }
        // Play music on loop
        bgMusic.numberOfLoops = -1
        bgMusic.play()
        // Add curvature to clue button
        clueButton.layer.cornerRadius = 10
        clueButton.clipsToBounds = true
        // Call askQuestion function
        askQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Function for generating random integers
    func genIndices(range: UInt32) {
        // Variables for representing indices of word parts in their arrays
        index1 = Int(arc4random_uniform(range))
        index2 = Int(arc4random_uniform(range))
        index3 = Int(arc4random_uniform(range))
        index4 = Int(arc4random_uniform(range))
        index5 = Int(arc4random_uniform(range))
    }
    
    // Function for assigning text to buttons
    func setButtonText(){
        // Adjective question asked
        if questionType == 1{
            // Display English answer options
            a1.setTitle(eng[0], for: .normal)
            a2.setTitle(eng[1], for: .normal)
            a3.setTitle(eng[2], for: .normal)
        }
        // Other question asked
        else{
            // Displays code language answer options
            a1.setTitle(code[0], for: .normal)
            a2.setTitle(code[1], for: .normal)
            a3.setTitle(code[2], for: .normal)
        }
    }
    
    // Function for asking a question
    func askQuestion() {
        // If score is greater than 5
        if score>=5 && score<10{
            //set difficulty to 2
            level = 2
        }
        // If score is greater than 10
        else if score>=10{
            // Set difficulty to 3
            level = 3
        }
        // Randomly selects question type
        questionType = Int(arc4random_uniform(UInt32(level)))
        // Represents which answer in the array of answers is correct
        correctness = [1,0,0]
        // Number question is asked
        if questionType == 0 {
            // Randomly generates variable values
            genIndices(range: 10)
            // Generates answer options
            code = [tenPrefix[index1]+unitSuffix[index2], unitSuffix[index2]+tenPrefix[index1], tenPrefix[index1]+unitSuffix[index3]]
            // Checks for blank and duplicate options
            while code[0] == code[1] || code[1] == code[2] || code[0] == code[2] || code[2] == "" {
                // Generates new index variable values
                genIndices(range: 10)
                // Generates answer options
                code = [tenPrefix[index1]+unitSuffix[index2], unitSuffix[index2]+tenPrefix[index1],tenPrefix[index1]+unitSuffix[index3]]
            }

            // Stores Arabic numeral value of correct answer, along with two empty strings
            eng = [digits[index1]+digits[index2], "", ""]
            // Determines which answer choice will be on each button
            shift = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: shift) as! [Int]
            code = [code[shift[0]], code[shift[1]], code[shift[2]]]
            eng = [eng[shift[0]], eng[shift[1]], eng[shift[2]]]
            correctness = [correctness[shift[0]], correctness[shift[1]], correctness[shift[2]] ]
            // Assigns text to buttons
            setButtonText()
            // Finds index of correct answer
            correctAnswer = correctness.index(of: 1)!
            // Displays question
            questionLabel.text = "What is \(eng[correctAnswer]) in code language?"
        }
        
        // Adjective question is asked
        else if questionType == 1 {
            // Sets index variables to random integers
            genIndices(range: 3)
            // Generates answer options in English
            eng = [engNega[index1]+engForms[index3]+engAdj[index2],engNega[index1]+engForms[index4]+engAdj[index2],engNega[index2]+engForms[index3]+engAdj[index2]]
            // Checks for duplicates
            while eng[0]==eng[1] || eng[0]==eng[2] || eng[1]==eng[2]{
                genIndices(range: 3)
                // Generates answer options in English
                eng = [engNega[index1]+engForms[index3]+engAdj[index2],engNega[index1]+engForms[index4]+engAdj[index2],engNega[index5]+engForms[index3]+engAdj[index2]]
            }
            // Stores code language translation of correct answer, along with two empty strings
            code = [negaPrefix[index1]+adjectives[index2]+adjForms[index3],"",""]
            // Determines which answer choice will be on each button
            shift = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: shift) as! [Int]
            code = [code[shift[0]], code[shift[1]], code[shift[2]]]
            eng = [eng[shift[0]], eng[shift[1]], eng[shift[2]]]
            correctness = [correctness[shift[0]], correctness[shift[1]], correctness[shift[2]]]
            // Assigns text to buttons
            setButtonText()
            // Finds index of correct answer
            correctAnswer = correctness.index(of: 1)!
            // Displays question
            questionLabel.text = "What is '\(code[correctAnswer])' in English?"
        }
            
        // Verb question is asked
        else if questionType == 2 {
            // Randomly generates index variable values
            genIndices(range: 2)
            // Generates answer options in code language
            code = [prepList[index1]+vbList[index2]+tenseList[index3], tenseList[index3]+vbList[index5]+prepList[index1], prepList[index1]+vbList[index2]+tenseList[index4]]
            // Checks for duplicates
            while code[0]==code[1] || code[0]==code[2] || code[1]==code[2] {
                // Generates new index variable values
                genIndices(range: 2)
                // Generates answer options in code language
                code = [prepList[index1]+vbList[index2]+tenseList[index3], tenseList[index3]+vbList[index5]+prepList[index1], prepList[index1]+vbList[index2]+tenseList[index4]]
            }
            
            // Stores English translation of correct answer, along with two empty strings
            eng = [engVb[index2]+engTense[index3]+engPrep[index1], "", ""]
            // Determines which answer will be on each button
            shift = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: shift) as! [Int]
            code = [code[shift[0]], code[shift[1]], code[shift[2]]]
            eng = [eng[shift[0]], eng[shift[1]], eng[shift[2]]]
            correctness = [correctness[shift[0]], correctness[shift[1]], correctness[shift[2]] ]
            // Assigns text to buttons
            setButtonText()
            // Finds index of correct answer
            correctAnswer = correctness.index(of: 1)!
            // Displays question
            questionLabel.text = "What is 'I \(eng[correctAnswer])' in code language?"
        }
    }
    
    // Function runs when answer button is tapped
    @IBAction func aSelected(_ sender: UIButton) {
        
        // Play popping sound
        audioPlayer.play()
        // Runs if answer is correct
        if sender.tag == correctAnswer {
            // Add 1 to score
            score = score+1
            // Runs if user has achieved a new high score
            if score>UserDefaults().integer(forKey: "HighScore"){
                // Saves high score
                saveHighScore()
            }
        }
        
        // Answer is incorrect
        else {
            if score>0 {
                // Subtract 1 from score
                score = score-1
            }
        }
        // Display new score
        scoreLabel.text = "Score: \(score)"
        // Ask a new question
        askQuestion()
    }
    
    func saveHighScore(){
        // Sets new value of high score
        UserDefaults.standard.set(score, forKey: "HighScore")
    }
    
    
    // Clues button is tapped
    @IBAction func showClues(_ sender: Any) {
        // Shows popup with relevant clues
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        popOverVC.questionType = questionType
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func quit(_ sender: UIButton) {
        // Stops music
        bgMusic.stop()
    }
    
}



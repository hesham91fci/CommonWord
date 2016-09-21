//
//  SpeechProcessingViewController.swift
//  CommonWord
//
//  Created by IBM on 9/16/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import UIKit

class SpeechProcessingViewController: UIViewController {
    
    @IBOutlet weak var commonWordLabel: UILabel!
    @IBOutlet weak var fileContentTextView: UITextView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    
    var fileContent:String!
    var fileName:String!
    var commonWords=[String:Int]()
    var errorThrown:Bool = false
    let pronounsArray=["HIS","HER","HERS","YOUR","YOURS","THEIR","THEIRS","THIS","THAT","THOSE","THESE","THEY"]
    let verbsArray=["WOULD","HAVE"]
    let prepositionsArray=["FROM","WITH","ABOUT"]
    let questionsArray=["WHAT","WHOM","WHICH","WHERE","WHEN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fileContentTextView.layer.borderWidth = 5.0
        self.fileContentTextView.layer.borderColor = UIColor(red: 111/255, green: 146/255, blue: 13/255, alpha: 1).CGColor
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSOperationQueue.mainQueue().addOperationWithBlock({() -> Void in
            self.readSpeech()
            self.calculateCommonWord()
        })
        
        
    }
    /**
    * the function which calculate the most frequent word in a text file
    */
    func calculateCommonWord(){
        
        let fileContentAsWords = fileContent.characters.split{$0 == " "}.map(String.init) // eleminating spaces
        self.updateProgressBar(30.0)
        for word in fileContentAsWords {
            
            
            if let range = word.rangeOfString("\\w+", options: [.RegularExpressionSearch, .CaseInsensitiveSearch]) { // logic wise the word life is qual to Life the option CaseInsensitiveSearch option is needed
                let result = word.substringWithRange(range)
                if result.characters.count<=3 || self.pronounsArray.contains(result.uppercaseString)
                    || self.prepositionsArray.contains(result.uppercaseString) || self.questionsArray.contains(result.uppercaseString)
                    || self.verbsArray.contains(result.uppercaseString){ // eleminating the WH questions, small words, pronouns, prepositions and small verbs ignoring their cases
                    continue
                }
                else{
                    if commonWords[result.lowercaseString] == nil { // ignoring the case so no equal words logically are put in the dictionary
                        commonWords[result.lowercaseString] = 1
                    }
                    else{
                        commonWords[result.lowercaseString]! += 1
                    }
                }
                
            }
            
            
            
        }
        self.updateProgressBar(80.0)
        let sortedCommonWords = commonWords.sort{ $0.1 > $1.1 } // sorting the dictionary
        self.updateProgressBar(90.0)
        self.commonWordLabel.text = sortedCommonWords.first?.0
        self.updateProgressBar(100.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func readSpeech(){
        let bundle = NSBundle.mainBundle()
        let filePath = bundle.pathForResource(self.fileName, ofType: "txt")
        do
        {
            if(filePath != nil){
                self.fileContent = try String(contentsOfFile: filePath!)
                self.fileContentTextView.text = self.fileContent
            }
            else{
                self.errorThrown=true
            }
            
        }
        catch
        {
            let showAlert = UIAlertController(title: NSLocalizedString("APP_TITLE", comment: "comment"), message: NSLocalizedString("ERROR_IN_FILE_PARSING", comment: "comment"), preferredStyle: UIAlertControllerStyle.Alert)
            
            showAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "comment"), style: .Default, handler: { (action: UIAlertAction) in
            }))
            self.presentViewController(showAlert, animated: true, completion: nil)
            self.fileContent = NSLocalizedString("ERROR_IN_FILE_PARSING", comment: "comment")
            errorThrown=true
        }
        self.updateProgressBar(25.0)
    }
    
    func updateProgressBar(progress:Float){
        self.progressBarView.setProgress(progress/100, animated: true)
        self.progressPercentLabel.text = "\(progress)%"
    }

}

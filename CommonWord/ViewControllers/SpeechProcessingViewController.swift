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
    var commonWords=[String:Int]()
    let pronounsArray=["HIS","HER","HRES","YOUR","YOURS","THEIR","THEIRS","THIS","THAT","THOSE","THESE","THEY"]
    let verbsArray=["WOULD","HAVE"]
    let prepositionsArray=["FROM","WITH","ABOUT"]
    let questionsArray=["WHAT","WHOM","WHICH","WHERE","WHEN"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSOperationQueue.mainQueue().addOperationWithBlock({() -> Void in
            self.readSpeech()
            self.calculateCommonWord()
        })
        
        
    }
    
    func calculateCommonWord(){
        
        let fileContentAsWords = fileContent.characters.split{$0 == " "}.map(String.init)
        self.updateProgressBar(30.0)
        for word in fileContentAsWords {
            
            
            if let range = word.rangeOfString("\\w+", options: [.RegularExpressionSearch, .CaseInsensitiveSearch]) {
                let result = word.substringWithRange(range)
                if result.characters.count<=3 || self.pronounsArray.contains(result.uppercaseString)
                    || self.prepositionsArray.contains(result.uppercaseString) || self.questionsArray.contains(result.uppercaseString)
                    || self.verbsArray.contains(result.uppercaseString){
                    continue
                }
                else{
                    if commonWords[result.lowercaseString] == nil {
                        commonWords[result.lowercaseString] = 1
                    }
                    else{
                        commonWords[result.lowercaseString]! += 1
                    }
                }
                
            }
            
            
            
        }
        self.updateProgressBar(80.0)
        let sortedCommonWords = commonWords.sort{ $0.1 > $1.1 }
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
        let filePath = bundle.pathForResource("Steve Jobs Speech", ofType: "txt")
        do
        {
            self.fileContent = try String(contentsOfFile: filePath!)
            self.fileContentTextView.text = self.fileContent
        }
        catch
        {
            self.fileContent = NSLocalizedString("ERROR_IN_FILE_PARSING", comment: "comment")
        }
        self.updateProgressBar(25.0)
    }
    
    func updateProgressBar(progress:Float){
        self.progressBarView.setProgress(progress/100, animated: true)
        self.progressPercentLabel.text = "\(progress)%"
    }

}

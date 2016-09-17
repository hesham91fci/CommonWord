//
//  SpeechProcessingViewController.swift
//  CommonWord
//
//  Created by IBM on 9/16/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import UIKit

class SpeechProcessingViewController: UIViewController {
    var fileContent:String!
    var commonWords=[String:Int]()
    let pronounsArray=["his","her","hers","your","yours","their","theirs","this","that","those","these"]
    let verbsArray=["would","have"]
    let prepositionsArray=["from","with","about"]
    let questionsArray=["what","whom","which","where","when"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.readSpeech()
        let fileContentAsWords = fileContent.characters.split{$0 == " "}.map(String.init)
        for word in fileContentAsWords {
        
            
            if let range = word.rangeOfString("\\w+", options: .RegularExpressionSearch) {
                let result = word.substringWithRange(range)
                if result.characters.count<=3 || self.pronounsArray.contains(result)
                || self.prepositionsArray.contains(result) || self.questionsArray.contains(result)
                || self.verbsArray.contains(result){
                    continue
                }
                else{
                    if commonWords[result] == nil {
                        commonWords[result] = 1
                    }
                    else{
                        commonWords[result]! += 1
                    }
                }
                
            }
            
            
            
        }
        
        let sortedCommonWords = commonWords.sort{ $0.1 > $1.1 }
        for (word,frequency) in sortedCommonWords {
            print(word,frequency)
        }
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
        }
        catch
        {
            self.fileContent = NSLocalizedString("ERROR_IN_FILE_PARSING", comment: "comment")
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

//
//  PeopleTableViewController.swift
//  CommonWord
//
//  Created by IBM on 9/16/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PeopleCell", forIndexPath: indexPath) as! PeopleTableViewCell

        if indexPath.item == 0 {
            return self.dequeueSteveJobsCell(cell)
        }
        
        if indexPath.item == 1 {
            return self.dequeueGandhiCell(cell)
        }
        

        return cell
    }
    
    func dequeueSteveJobsCell(cell: PeopleTableViewCell) -> PeopleTableViewCell{
        cell.profileImage.image = UIImage(named: NSLocalizedString("STEVE_JOBS", comment: "comment"))
        cell.speechDate.text = NSLocalizedString("STEVE_JOBS_SPEECH_DATE", comment: "comment")
        cell.characterName.text = NSLocalizedString("STEVE_JOBS", comment: "comment")
        return cell
    }
    
    func dequeueGandhiCell(cell: PeopleTableViewCell) -> PeopleTableViewCell{
        cell.profileImage.image = UIImage(named: NSLocalizedString("GHANDI", comment: "comment"))
        cell.speechDate.text = NSLocalizedString("GHANDI_SPEECH_DATE", comment: "comment")
        cell.characterName.text = NSLocalizedString("GHANDI", comment: "comment")
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let speechProcessingScreen = mainStoryBoard.instantiateViewControllerWithIdentifier("SpeechProcessingViewController") as! SpeechProcessingViewController
        self.navigationController?.pushViewController(speechProcessingScreen, animated: true)
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

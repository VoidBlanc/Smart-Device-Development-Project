//
//  RunnigHistoryViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit


class RunnigHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ExpandableHeaderViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    var authUID = AuthenticateUser.getUID()
   var runningsections : [Session] = []
   /* var runningsections : [Session] {
            return RunningDataManager.loadallsession(authUID)
        }
 */
 
    var selectedid : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runningsections = RunningDataManager.loadallsession(authUID)
       
        
        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return runningsections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runningsections[section].totalfinishdate!.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(runningsections[indexPath.section].expanded){
            return 44
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: runningsections[section].month!, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = "Date :" + runningsections[indexPath.section].totalfinishdate![indexPath.row]
        cell.detailTextLabel?.text = "Time taken :" + runningsections[indexPath.section].allTotalTime![indexPath.row]
       // cell.detailTextLabel?.text = runningsections[indexPath.section].totaldistance![indexPath.row]
        return cell
    }
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        runningsections[section].expanded = !runningsections[section].expanded
        
        tableview.beginUpdates()
        for i in 0 ..< runningsections[section].totalfinishdate!.count
        {
            tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableview.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var runningid : Int =  (runningsections[indexPath.section].AllSessionID![indexPath.row])
        selectedid = runningid
        tableView.deselectRow(at: indexPath, animated: true)
        
 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        selectedid  =  (runningsections[tableview.indexPathForSelectedRow!.section].AllSessionID![tableview.indexPathForSelectedRow!.row])
        var nextcontroller = segue.destination as! HistorySessionViewController
        nextcontroller.currentid = String(selectedid)
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

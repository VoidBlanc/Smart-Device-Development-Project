//
//  PlanDataManager.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 21/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DietaryPlanDataManager: NSObject {
    
    // MARK: - USER PLAN PREFERENCES
    
    //Create User Plan Preferences Table
    static func createUPTable() {
        SQLiteDB.sharedInstance.execute(sql:
            "CREATE TABLE IF NOT EXISTS " +
                "UserPlanPreferences (" +
                "username text primary key, " +
                "mealplantype text, " +
                "duration text, " +
                "mealsperday int, " +
                "mealtiming text, " +
                "reminders text, " +
                "startDate text) "
        )
    }
    
    
    
    //Create/Update
    static func insertOrReplacePreferences(userPlanPreferences: UserPlanPreferences)
    {
        SQLiteDB.sharedInstance.execute(sql:
            "INSERT OR REPLACE INTO userPlanPreferences(username, mealplantype, duration, mealsperday, mealtiming, reminders, startDate)" +
            "VALUES(?, ?, ?, ?, ?, ?, ?)",
                                        parameters: [
                                            userPlanPreferences.username,
                                            userPlanPreferences.mealPlanType,
                                            userPlanPreferences.duration,
                                            userPlanPreferences.mealsperday,
                                            userPlanPreferences.mealtiming,
                                            userPlanPreferences.reminders,
                                            userPlanPreferences.startDate]
        )
                
    }
    
    //Load preferences
    static func loadPreferences(username: String) -> [UserPlanPreferences] {
        var preferences : [UserPlanPreferences] = []
        let userpreferences = SQLiteDB.sharedInstance.query(sql:
        "SELECT username, mealplantype, duration, mealsperday, mealtiming, reminders, startDate" +
        " FROM userPlanPreferences" +
        " WHERE username = ?",
            parameters: [username]
        )
        
        var count = preferences.count
            for row in userpreferences {
                preferences.append(UserPlanPreferences(
                    row["username"] as! String,
                    row["mealplantype"] as! String,
                    row["duration"] as! String,
                    row["mealsperday"] as! Int,
                    row["mealtiming"] as! String,
                    row["reminders"] as! String,
                    row["startDate"] as! String
                ))
            }
        
        if (count < 1) {
            preferences.append(UserPlanPreferences("", "","", 0, "", "", ""))
        }
        
           
            
        
      return preferences
    }
    
    static func countPreferences(userName: String) -> Int {
        var preferences : [UserPlanPreferences] = []
        let userpreferences = SQLiteDB.sharedInstance.query(sql:
            "SELECT username, mealplantype, duration, mealsperday, mealtiming, reminders, startDate" +
            " FROM userPlanPreferences" +
            " WHERE username = ?",
            parameters: [userName]
        )
        
        var count = 0
        for row in userpreferences {
            count = count + 1
        }
        
        return count
    }
}

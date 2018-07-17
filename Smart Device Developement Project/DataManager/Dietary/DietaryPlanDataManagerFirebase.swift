//
//  DietaryCreateData.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 5/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class DietaryPlanDataManagerFirebase: NSObject {

    //MARK: - Meal
    //Load Meal "table"
    static func loadMeals(onComplete: @escaping ([Meal]) -> Void){
        //Create empty list
        var mealList : [Meal] = []
        let ref = FirebaseDatabase.Database.database().reference().child("Meal/")
        // Load full list of movies and execute "with" closure once, when download is complete
        ref.observeSingleEvent(of: .value, with:{(snapshot) in
                for record in snapshot.children {
                    let r = record as! DataSnapshot
                    let id = Int(r.key)!
                    let image = r.childSnapshot(forPath: "image").value as! String
                    let name = r.childSnapshot(forPath: "name").value as! String
                    let calories = Float(r.childSnapshot(forPath: "calories").value as! String)!
                    let carbohydrates = Float(r.childSnapshot(forPath: "carbohydrates").value as! String)!
                    let protein = Float(r.childSnapshot(forPath: "protein").value as! String)!
                    let fat = Float(r.childSnapshot(forPath: "fat").value as! String)!
                    let sodium = Float(r.childSnapshot(forPath: "sodium").value as! String)!
                    let ingredients = r.childSnapshot(forPath: "ingredients").value as! String
                    let imageRecipe = r.childSnapshot(forPath: "imageRecipe").value as! String
                    mealList.append(Meal(id, image, name, calories, carbohydrates, protein, fat, sodium, ingredients, imageRecipe))
                }
            onComplete(mealList)
        })
        
        
    }
    
    //Create / Update
    static func createMealData() {
        let ref1 = FirebaseDatabase.Database.database().reference().child("Meal/\(1)/")
        ref1.setValue([
            "name" : "Chicken Rice",
            "image": "chickenrice",
            "calories" : "510",
            "carbohydrates" : "45.6",
            "protein" : "45.7",
            "fat" : "16.5",
            "sodium" : "1112.23",
            "ingredients" : "Chicken breast, ginger, white rice, brown rice, canola oil, garlic, Pandan leaf, sesame oil, chicken seasoning powder",
            "imageRecipe" : "chickenricerecipe"
            ]
        )
        
        let ref2 = FirebaseDatabase.Database.database().reference().child("Meal/\(2)/")
        ref2.setValue([
            "name" : "Black Carrot Cake",
            "image": "blackcarrotcake",
            "calories" : "556.47",
            "carbohydrates" : "65.77",
            "protein" : "13.16",
            "fat" : "26.74",
            "sodium" : "1937.08",
            "ingredients" : "Daikon, Vegetable oil, salt, white pepper, rice flour, eggs, garlic, soy sauce, Sriracha, Scallions, cilantro",
            "imageRecipe" : "blackcarrotcakerecipe"
            ])
        
        let ref3 = FirebaseDatabase.Database.database().reference().child("Meal/\(3)/")
        ref3.setValue([
            "name" : "Chilli Chicken Pasta",
            "image": "chillichickenpasta",
            "calories" : "466",
            "carbohydrates" : "76",
            "protein" : "35",
            "fat" : "5.5",
            "sodium" : "300",
            "ingredients" : "wholegrain pasta, corn, celery, olive oil, chicken breast, chilli powder, chicken seasoning, pepper, tomatoes, lime, parsley",
            "imageRecipe" : "chillichickenpastarecipe"
            
            ])
        
        let ref4 = FirebaseDatabase.Database.database().reference().child("Meal/\(4)/")
        ref4.setValue([
            "name" : "Curry Chicken",
            "image": "currychicken",
            "calories" : "364",
            "carbohydrates" : "22.2",
            "protein" : "39",
            "fat" : "12.8",
            "sodium" : "350",
            "ingredients" : "chicken leg, onions, chilli powder, turmeric powder, green capsicum, salt, pepper, sunflower oil, evaporated milk, curry leaves",
            "imageRecipe" : "currychickenrecipe"
            ])
        
        let ref5 = FirebaseDatabase.Database.database().reference().child("Meal/\(5)/")
        ref5.setValue([
            "name" : "Fried Olive Rice",
            "image": "friedoliverice",
            "calories" : "323",
            "carbohydrates" : "40",
            "protein" : "12.8",
            "fat" : "12.4",
            "sodium" : "310",
            "ingredients" : "olive oil, garlic, minced meat, chinese olives, long beans, brown rice, basmati rice, red chilli, cashews, sesame oil",
            "imageRecipe" : "friedolivericerecipe"
            ])
        
        let ref6 = FirebaseDatabase.Database.database().reference().child("Meal/\(6)/")
        ref6.setValue([
            "name" : "Mee Goreng",
            "image": "meegoreng",
            "calories" : "220",
            "carbohydrates" : "28",
            "protein" : "13",
            "fat" : "7.2",
            "sodium" : "370",
            "ingredients" : "canola oil, chilli paste, garlic, shallots, dried shrimp, minced meat, prawns, chye sim, yellow noodles, cabbage, bean sprouts, tomato sauce, stalks onions",
            "imageRecipe" : "meegorengrecipe"
            ])
        
        let ref7 = FirebaseDatabase.Database.database().reference().child("Meal/\(7)/")
        ref7.setValue([
            "name" : "Mini Speedy Pizzas",
            "image": "minipizzas",
            "calories" : "205",
            "carbohydrates" : "36.4",
            "protein" : "11.2",
            "fat" : "3.4",
            "sodium" : "800.5",
            "ingredients" : "tomato pasta sauce, wholemeal bread, low-fat cheese, chicken cubes, white mushroom, eggplant, capsicum",
            "imageRecipe" : "minipizzasrecipe"
            ])
        
        let ref8 = FirebaseDatabase.Database.database().reference().child("Meal/\(8)/")
        ref8.setValue([
            "name" : "Sardine Fried Rice",
            "image": "sardinefriedrice",
            "calories" : "323",
            "carbohydrates" : "38.7",
            "protein" : "14.9",
            "fat" : "11.9",
            "sodium" : "480",
            "ingredients" : "Sardines, canola oil, onion, garlic, vegetables, rice, pepper, eggs",
            "imageRecipe" : "sardinefriedricerecipe"
            ])
        
        let ref9 = FirebaseDatabase.Database.database().reference().child("Meal/\(9)/")
        ref9.setValue([
            "name" : "Sliced Fish Bee Hoon Soup",
            "image": "beehoonsoup",
            "calories" : "385",
            "carbohydrates" : "55.2",
            "protein" : "21.1",
            "fat" : "8.8",
            "sodium" : "470",
            "ingredients" : "fish fillet, brown rice bee hoon, tomatoes, spring onions, ginger, corn oil, sesame oil, evaporated milk, fish stock seasoning, pepper",
            "imageRecipe" : "beehoonsouprecipe"
            ])
        
        let ref10 = FirebaseDatabase.Database.database().reference().child("Meal/\(10)/")
        ref10.setValue([
            "name" : "Teriyaki Salmon and Pasta",
            "image": "salmonpasta",
            "calories" : "378",
            "carbohydrates" : "39.2",
            "protein" : "26.9",
            "fat" : "13.4",
            "sodium" : "375",
            "ingredients" : "capsicum, canola oil, salmon fillet, teriyaki marinade, black and white sesame seeds, wholemeal pasta, olive oil, cucumber, lime, pepper",
            "imageRecipe" : "salmonpastarecipe"
            ])
        
        
    }
    
    //MARK: - Meal Plan
    
    //Load Meal Plan "table"
    static func loadMealPlans(date: String, username: String, onComplete: @escaping ([MealPlan]) -> Void) {
        //Create empty list
        var mealPlanList : [MealPlan] = []
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan")
        // Load full list of movies and execute "with" closure once, when download is complete
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                
                let exists: Bool = snapshot.exists()
                
                if (exists == true){
                    for record in snapshot.children {
                        let r = record as! DataSnapshot
                        let userName = r.childSnapshot(forPath: "username").value as! String
                        let Date = r.childSnapshot(forPath: "date").value as! String
                        let id = Int(r.key)!
                        let mealid = r.childSnapshot(forPath: "mealID").value as! Int
                        let mealname = r.childSnapshot(forPath: "mealName").value as! String
                        let mealimage = r.childSnapshot(forPath: "mealImage").value as! String
                        let calories = r.childSnapshot(forPath: "calories").value as! Int
                        let isDiary = r.childSnapshot(forPath: "isDiary").value as! String
                        let recipeimage = r.childSnapshot(forPath: "recipeImage").value as! String
                        let fCalories = Float(calories)
                        
                        if(userName == username && Date == date) {
                            mealPlanList.append(MealPlan(id,userName,Date,mealid,mealname,mealimage,fCalories,recipeimage,isDiary))
                        }
                    }
                }
                else {
                    mealPlanList.append(MealPlan(0,"","",0,"","",0,"", ""))
                }
            onComplete(mealPlanList)
        })
    }
    
    static func loadMealPlansCount(date: String, username: String, onComplete: @escaping (Int) -> Void){
        var count: Int = 0
        //Create empty list
        var mealPlanList : [MealPlan] = []
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan/")
        // Load full list of movies and execute "with" closure once, when download is complete
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
            for record in snapshot.children{
                let r = record as! DataSnapshot
                let uname = r.childSnapshot(forPath: "username").value as! String
                let Date = r.childSnapshot(forPath: "date").value as! String
                if(uname == username && Date == date) {
                    count = count + 1
                }
                
            }
            onComplete(count)
        })
        
    }
    
    static func loadMealPlanLastID(onComplete: @escaping (Int) -> Void){
        var planid: Int = 0
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan/")
        // Load full list of movies and execute "with" closure once, when download is complete
        ref.observeSingleEvent(of: .value, with:
            {(snapshot) in
                for record in snapshot.children{
                    let r = record as! DataSnapshot
                    let id = Int(r.key)!
                }
                onComplete(planid)
        })
        

    }
    
    
    //Create / Update
    static func createPlanData(mealPlanList: [MealPlan]) {
        for i in 0...mealPlanList.count - 1{
            let ref = FirebaseDatabase.Database.database().reference().child("MealPlan/\(mealPlanList[i].planID!)/")
            ref.setValue([
                "username" : mealPlanList[i].username,
                "date" : mealPlanList[i].date,
                "mealID" : mealPlanList[i].mealID,
                "mealName" : mealPlanList[i].mealName,
                "mealImage" : mealPlanList[i].mealImage,
                "calories" : mealPlanList[i].calories,
                "isDiary" : mealPlanList[i].isDiary,
                "recipeImage" : mealPlanList[i].recipeImage
                ]
            )
        }
    }
    
    static func updatePlan(mealPlan: MealPlan) {
        let ref = FirebaseDatabase.Database.database().reference().child("MealPlan/\(mealPlan.planID!)/")
        ref.setValue([
            "username" : mealPlan.username,
            "date" : mealPlan.date,
            "mealID" : mealPlan.mealID,
            "mealName" : mealPlan.mealName,
            "mealImage" : mealPlan.mealImage,
            "calories" : mealPlan.calories,
            "isDiary" : mealPlan.isDiary,
            "recipeImage" : mealPlan.recipeImage
            ])
    }
    
    static func create1Plan() {
        
            let ref = FirebaseDatabase.Database.database().reference().child("MealPlan/\(1)/")
            ref.setValue([
                "username" : "1",
                "date" : "09/07/2018",
                "mealID" : "1",
                "mealName" : "Chicken Rice",
                "mealImage" : "chickenrice",
                "calories" : "510",
                "isDiary" : "No",
                "recipeImage" : "chickenricerecipe"
                ]
            )
        
    }
    
    //Delete
    static func deleteMealPlan(_ mealPlan: MealPlan){
        let ref = FirebaseDatabase.Database.database().reference().child("Meal/\(mealPlan.planID)/")
        ref.removeValue()
    }
    
    //MARK: - Hawker Centres
    static func createHawkerData() {
        let ref1 = FirebaseDatabase.Database.database().reference().child("HawkerCentres/\(1)/")
        ref1.setValue([
            "name" : "Chicken Rice",
            "image": "chickenrice",
            "calories" : "510",
            "carbohydrates" : "45.6"
            ]
        )
    }
    
    
}

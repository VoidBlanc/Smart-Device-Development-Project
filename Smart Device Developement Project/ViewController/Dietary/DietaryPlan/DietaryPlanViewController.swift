//
//  DietaryPlanViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 12/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import UserNotifications

class DietaryPlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generatePlanButton: UIButton!
    @IBOutlet weak var loadMealsButton: UIButton!
    @IBOutlet weak var notifyLabel: UILabel!
    
    private var datePicker: UIDatePicker?
    
    
    /*let mealType = [[MealType("Vegan", "No animal products", "vegan")],
                [MealType("Clean Eating", "Ideal if you are looking to make a healthy change in your eating habits", "cleaneating")],
                [MealType("High Protein", "High Protein", "highprotein")],
                [MealType("Keto", "Low in carbohydrates, high in fats. If you get hungry easily and struggle with weight loss this is the plan.", "keto")]]*/
    let headers:[String] = ["Planned Meals", "Dietary Diary"]
    var meal : [Meal] = []
    var mealplan: [MealPlan] = []
    var mealPlans: [[MealPlan]] = [[],[]]

    var contentWidth:CGFloat = 0.0
    var username = ""
    var totalCalories:Int = 0
    var selectedDate:String = ""
    var preferences: [UserPlanPreferences] = []
    var planCount: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let todayDate = formatter.string(from: date)
        dateTextField.text = todayDate
        selectedDate = dateTextField.text!
        
       
        self.username = AuthenticateUser.getUID()
        
        
        //Firebase load meals and plans
        DispatchQueue.main.async {
            DietaryPlanDataManagerFirebase.createMealData()
            self.loadMeals()
            self.loadPlanCount(date: self.selectedDate, username: self.username)
        }
        
        //Load meal plans
        if(DietaryPlanDataManager.countPreferences(userName: username) < 1) {
            generatePlanButton.isHidden = false
            loadMealsButton.isHidden = true
        }
        else{
            generatePlanButton.isHidden = true
            loadMealsButton.isHidden = false
        }
        
        //Date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DietaryPlanViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //when user taps, usually keyboard comes up, disables the keyboard coming up
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DietaryPlanViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        //set input type to datepicker
        dateTextField.inputView = datePicker
        
        // Create tables
        DietaryPlanDataManager.createUPTable()
        
        //Load Preferences
        preferences = DietaryPlanDataManager.loadPreferences(username: username)
        
        //Check if there is a plan in selected date
        if(DietaryPlanDataManager.countPreferences(userName: username) >= 1 ) {
            let days = preferences[0].duration!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(DietaryPlanDataManager.countPreferences(userName: username) < 1) {
            generatePlanButton.isHidden = false
            loadMealsButton.isHidden = true
        }
        else{
            generatePlanButton.isHidden = true
            loadMealsButton.isHidden = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Tap Gestures
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        selectedDate = dateTextField.text!
        view.endEditing(true)
    }

    // Segue unwind
    @IBAction func unwindToDietaryPlanController(segue: UIStoryboardSegue) {}
   
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlans[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealPlans.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        cell.mealName.text = mealPlans[indexPath.section][indexPath.row].mealName
        cell.mealCalories.text = String(describing: mealPlans[indexPath.section][indexPath.row].calories!)
        cell.mealImage.image = UIImage(named: mealPlans[indexPath.section][indexPath.row].mealImage!)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        if(segue.identifier == "mealSegue")
        {
            let ViewMealViewController =
                segue.destination as! ViewMealViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow
            
            if(myIndexPath != nil)
            {
                // Set the mealItem field with the meal
                // object selected by the user.
                //
                let selectedMeal: MealPlan = mealPlans[myIndexPath!.section][myIndexPath!.row]
                ViewMealViewController.mealPlan = selectedMeal
                ViewMealViewController.meals = meal

            }
        }
    }
    
    // MARK: - Functions
    func loadMeals() {
        DietaryPlanDataManagerFirebase.loadMeals(){
            mealListFromFirebase in
            self.meal = mealListFromFirebase
        }
    }
    
    func loadPlanMeals (date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadMealPlans(date: date, username: username){
            mealPlanListFromFirebase in
            self.mealplan = mealPlanListFromFirebase
          
                for j in 0...self.mealplan.count-1 {
                    if (self.mealplan[j].isDiary == "No") {
                        self.mealPlans[0].append(self.mealplan[j])
                    }
                    else {
                        self.mealPlans[1].append(self.mealplan[j])
                    }
                }
            
            self.tableView.reloadData()
            
        }
    }
    
    func loadPlanCount(date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadMealPlansCount(date: date, username: username) {
            planCountFromFirebase in
            self.planCount = planCountFromFirebase
        }
    }

   
    @IBAction func loadMeals(_ sender: Any) {
        
        if(planCount < 1) {
        }
        
        DispatchQueue.main.async {
            self.loadPlanMeals(date: self.selectedDate, username: self.username)
        }
    }
    
 

}

//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    let sm = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
    }

    @IBAction func schedule(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        
        //SOM
        //content.sound = UNNotificationSound(named: "arquivodesom.caf")
        
        //categoria
        content.categoryIdentifier = "Lembrete"
        
        //Trigger
        //intervalo de tempo exemplo daqui uma hora
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        
        //vai ocorrer com calendario
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: studyPlan.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //regiao do mapa
        
        
        let request  = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        sm.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
    }
    
}

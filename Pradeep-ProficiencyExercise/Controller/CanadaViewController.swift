//
//  CanadaViewController.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit
import Foundation

class CanadaViewController: UIViewController {

    var httpUtility:HttpUtility?
    var canadaList:CanadaModel?
    var canadaTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        httpUtility = HttpUtility()
        retrieveDataFromApi()
    }
    
    //MARK: - Api Call
     func retrieveDataFromApi() {
         
         if Reachability.isConnectedToNetwork(){
             print("Internet Connection Available!")
             
             // make api call
             httpUtility?.getApiData(requestUrl: Common.apiString, resultType: CanadaModel.self, completionHandler: { (canadaResponse) in
                 self.canadaList = canadaResponse
                 //debugPrint("response = \(String(describing: self.canadaList))")
                 print("title = \(self.canadaList?.title ?? "")")
                 
                 DispatchQueue.main.async {
                     
                     self.navigationItem.title = self.canadaList?.title
                     self.canadaTableView.reloadData()
                 }
             })
             
         }else{
             print("Internet Connection not Available!")
             
             // create the alert
             let alert = UIAlertController(title: "Message", message: "Internet Connection not Available!", preferredStyle: UIAlertController.Style.alert)
             
             // add an action (button)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in
             }))
             
             // show the alert
             self.present(alert, animated: true, completion: nil)
         }
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

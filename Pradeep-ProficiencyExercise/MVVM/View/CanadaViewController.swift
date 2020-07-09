//
//  CanadaViewController.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation
import UIKit

class CanadaViewController: UIViewController {
    var canadaViewModel = CanadaViewModel()
    var canadaList: CanadaModel?
    var canadaTableView = UITableView()
    let child = SpinnerViewController()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadViewComponents()
        retrieveDataFromApi()
    }
    func loadViewComponents() {
        self.view.addSubview(canadaTableView)
        //enable Auto Layout on contactsTableView by setting translatesAutoresizingMaskIntoConstraints to false
        canadaTableView.translatesAutoresizingMaskIntoConstraints = false
        canadaTableView.delegate = self
        canadaTableView.dataSource = self
        canadaTableView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        canadaTableView.register(CanadaTableViewCell.self, forCellReuseIdentifier: Constants.canadaCellIdentifier)
        canadaTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canadaTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        canadaTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        canadaTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    @objc private func refreshTableData(_ sender: Any) {
        // Fetch Data from api
        self.refreshControl.endRefreshing()
        retrieveDataFromApi()
    }
    // MARK: - Api Call
    func retrieveDataFromApi() {
        self.loadSpinnerView()
        canadaViewModel.getDataFromApi(apiUrl: Constants.apiString) { response, status in
            if status {
                self.canadaList = response
                //debugPrint("response = \(String(describing: self.canadaList))")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationItem.title = self.canadaList?.title
                    self.canadaTableView.reloadData()
                    self.removeSpinnerView()
                }
            }
            else {
                self.presentSingleButtonDialog()
            }
        }
    }
 }

// MARK: - Table datasource and Delegate
extension CanadaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        canadaViewModel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.canadaCellIdentifier, for: indexPath) as? CanadaTableViewCell
        cell?.selectionStyle = .none
        if let rowDict = canadaList?.rows[indexPath.row] {
            cell?.rowData = rowDict
        }
        return cell!
    }
}

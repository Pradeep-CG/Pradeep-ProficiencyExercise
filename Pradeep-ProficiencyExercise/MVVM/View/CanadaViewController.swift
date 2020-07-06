//
//  CanadaViewController.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class CanadaViewController: UIViewController {
    var canadaViewModel = CanadaViewModel()
    var canadaList: CanadaModel?
    var canadaTableView = UITableView()
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
        retrieveDataFromApi()
    }
    // MARK: - Api Call
    func retrieveDataFromApi() {
        canadaViewModel.getDataFromApi(apiUrl: Constants.apiString) { (response, status) in
            if status {
                self.canadaList = response
                //debugPrint("response = \(String(describing: self.canadaList))")
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.navigationItem.title = self.canadaList?.title
                    self.canadaTableView.reloadData()
                }
            } else {
                // create the alert
                let alert = UIAlertController(title: Constants.messageTitle, message: Constants.messageBody, preferredStyle: UIAlertController.Style.alert)
                 // add an action (button)
                alert.addAction(UIAlertAction(title: Constants.alertOk, style: UIAlertAction.Style.default, handler: { _ in
                    self.refreshControl.endRefreshing()
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
 }

// MARK: - Table datasource and Delegate
extension CanadaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canadaViewModel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (canadaList?.rows[indexPath.row].rowDescription) != nil {
            return UITableView.automaticDimension
        } else {
            return Constants.rowHeight
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.canadaCellIdentifier, for: indexPath) as? CanadaTableViewCell
        cell?.selectionStyle = .none
        if let rowDict = canadaList?.rows[indexPath.row] {
            cell?.rowData = rowDict
        }
        if let imgHref = canadaList?.rows[indexPath.row].imageHref {
            let url = URL(string: imgHref)!
            let resource = ImageResource(downloadURL: url, cacheKey: imgHref)
            cell?.rowImageView.kf.setImage(with: resource) { result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    cell?.rowImageView.image = Common.scaleUIImageToSize(image: UIImage(named: Constants.blankImageName)!)
                }
            }
        } else {
            cell?.rowImageView.image = Common.scaleUIImageToSize(image: UIImage(named: Constants.blankImageName)!)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

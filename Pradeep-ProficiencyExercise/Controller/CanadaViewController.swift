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
    var httpUtility: HttpUtility?
    var canadaList: CanadaModel?
    var canadaTableView = UITableView()
    let cache = NSCache<NSString, UIImage>()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        httpUtility = HttpUtility()
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
        if Reachability.isConnectedToNetwork() {
            // make api call
            // swiftlint:disable:next line_length
            httpUtility?.getApiData(requestUrl: Constants.apiString, resultType: CanadaModel.self, completionHandler: { (canadaResponse) in
                self.canadaList = canadaResponse
                //debugPrint("response = \(String(describing: self.canadaList))")
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.navigationItem.title = self.canadaList?.title
                    self.canadaTableView.reloadData()
                }
            })
        } else {
            // create the alert
            // swiftlint:disable:next line_length
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

// MARK: - Table datasource and Delegate
extension CanadaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canadaList?.rows.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (canadaList?.rows[indexPath.row].rowDescription) != nil {
            return UITableView.automaticDimension
        } else {
            return Constants.rowHeight
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next line_length
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.canadaCellIdentifier, for: indexPath) as? CanadaTableViewCell
        if let rowDict = canadaList?.rows[indexPath.row] {
            cell?.rowData = rowDict
        }
        if let imgHref = canadaList?.rows[indexPath.row].imageHref {
            if cache.object(forKey: imgHref as NSString) != nil {
                cell?.rowImageView.image = Common.scaleUIImageToSize(image: cache.object(forKey: imgHref as NSString)!)
            } else {
                // swiftlint:disable:next line_length
                httpUtility?.downloadImage(urlString: imgHref, index: indexPath, completionHandler: { (imageUrl, downloadedImage, imgIndexPath) in
                     DispatchQueue.main.sync {
                        self.cache.setObject(downloadedImage, forKey: imageUrl as NSString)
                        self.canadaTableView.reloadRows(at: [imgIndexPath], with: .none)
                    }
                })
            }
        } else {
            cell?.rowImageView.image = Common.scaleUIImageToSize(image: UIImage(named: Constants.blankImageName)!)
        }
        return cell!
    }
}

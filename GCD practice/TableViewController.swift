//
//  ViewController.swift
//  GCD practice
//
//  Created by Pavel Yurkov on 14.02.2021.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class TableViewController: UIViewController {
    
    private var photoURLs: [String] = []
    
    private lazy var myCoolTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "GCD test table"
        setupLayout()
        getURLsFromServer()
        
    }
    
    func getURLsFromServer() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/photos") {
            let queue = DispatchQueue.global(qos: .userInitiated)
            DispatchQueue.main.async {
                SwiftSpinner.show("Loading data...", animated: true)
            }
            queue.async {
                let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
                    guard let data = data else { return }
                    if let vc = self {
                        vc.parseJSON(data)
                    }
                }

                task.resume()
            }
        }
    }
    
    func parseJSON(_ serverData: Data) {
        
        let json = JSON(serverData)
        
        for (_, element) in json.enumerated() {
            if let url = element.1["url"].string {
                photoURLs.append(url)
            }
        }
        DispatchQueue.main.async {
            SwiftSpinner.hide()
            self.myCoolTableView.reloadData()
        }
    }

}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myCoolTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = photoURLs[indexPath.row]
        
        return cell
    }
    
}

private extension TableViewController {
    
    func setupLayout() {
        view.addSubviewWithAutolayout(myCoolTableView)
        
        let constraints = [
            myCoolTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCoolTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myCoolTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myCoolTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}


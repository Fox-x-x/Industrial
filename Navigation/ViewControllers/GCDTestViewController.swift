//
//  GCDTestViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 06.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class GCDTestViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
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
        
        getURLsFromServer { [weak self] result in
            if let vc = self {
                switch result {
                case .success(let URLs):
                    vc.photoURLs = URLs
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                        vc.myCoolTableView.reloadData()
                    }
                case .failure(let error):
                    print("error: \(error)")
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                    }
                    handleApiError(error: error, vc: vc)
                }
            }
            
        }
        
    }
    
    func getURLsFromServer(completion: @escaping (Result<[String], ApiError>) -> Void) {
        
        var URLsFromServer: [String] = []
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        let queue = DispatchQueue.global(qos: .userInitiated)
        DispatchQueue.main.async {
            SwiftSpinner.show("Loading data...", animated: true)
        }
        queue.async {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data else { return }
                if let vc = self {
                    URLsFromServer = vc.parseJSON(data)
                }
                if URLsFromServer.isEmpty {
                    completion(.failure(.emptyData))
                } else {
                    completion(.success(URLsFromServer))
                }
            }

            task.resume()
        }
    }
    
    func parseJSON(_ serverData: Data) -> [String] {
        
        var URLsFromJSON: [String] = []
        
        let json = JSON(serverData)
        print(json)
        
        for (_, element) in json.enumerated() {
            if let url = element.1["url"].string {
                URLsFromJSON.append(url)
            }
        }
        
        return URLsFromJSON
    }

}

extension GCDTestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension GCDTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myCoolTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = photoURLs[indexPath.row]
        
        return cell
    }
    
}

private extension GCDTestViewController {
    
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




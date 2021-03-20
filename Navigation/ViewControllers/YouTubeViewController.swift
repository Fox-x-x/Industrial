//
//  YouTubeViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 17.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class YouTubeViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
    private var videos = ["https://www.youtube.com/watch?v=yqqaW8DCc-I",
                          "https://www.youtube.com/watch?v=syiQmaGZFXM",
                          "https://www.youtube.com/watch?v=F8MN0o6RS9o"
    ]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        setupLayout()
    }

}

extension YouTubeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row]

        return cell
    }
     
}

extension YouTubeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let videoVC = YouTubeVideoViewController(video: videos[indexPath.row])
        navigationController?.present(videoVC, animated: true, completion: nil)
    }
}

private extension YouTubeViewController {
    
    func setupLayout() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}

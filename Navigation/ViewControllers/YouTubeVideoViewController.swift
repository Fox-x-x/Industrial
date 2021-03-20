//
//  YouTubeVideoViewController.swift
//  Navigation
//
//  Created by Pavel Yurkov on 17.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import WebKit

class YouTubeVideoViewController: UIViewController {
    
    private var video: String
    
    init(video: String) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        
        setupLayoutAndPlay()
        
    }

}

private extension YouTubeVideoViewController {
    
    func setupLayoutAndPlay() {
        
        let configuration = WKWebViewConfiguration()
        configuration.mediaTypesRequiringUserActionForPlayback = []
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        if let videoUrl = URL(string: video) {
            webView.load(URLRequest(url: videoUrl))
        }
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

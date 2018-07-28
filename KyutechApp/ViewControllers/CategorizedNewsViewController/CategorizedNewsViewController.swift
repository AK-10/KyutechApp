//
//  CategorizedNewsViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents.MDCActivityIndicator

class CategorizedNewsViewController: UIViewController {
    
    var newsArray: [News] = []
    var categoryCode: Int? = nil
    
    @IBOutlet weak var newsHeaderCollection: UICollectionView!
    
    deinit {
        print("\(self) was deinited")
        NewsModel.nextURL = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        getNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupCollection() {
        newsHeaderCollection.delegate = self
        newsHeaderCollection.dataSource = self
        
        let nib = UINib(nibName: "SimpleCardCell", bundle: nil)
        newsHeaderCollection.register(nib, forCellWithReuseIdentifier: "NewsHeadCell")
        newsHeaderCollection.reloadData()
    }
    
    func getNews() {
        guard let categoryCode = categoryCode else { return }
        let activityIndicator = MDCActivityIndicator()
        newsHeaderCollection.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: newsHeaderCollection.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: newsHeaderCollection.centerYAnchor).isActive = true
        activityIndicator.cycleColors = [.blue, .red, .green, .yellow]
        activityIndicator.startAnimating()
        NewsModel.readNews(newsID: categoryCode, onSuccess: { [weak self] (readedNewsArray) in
            self?.newsArray = readedNewsArray
            self?.newsHeaderCollection.reloadData()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            }, onError: { () in
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                let snackBarMessage = MDCSnackbarMessage()
                snackBarMessage.duration = 2
                snackBarMessage.text = "データを取得できませんでした"
                MDCSnackbarManager.show(snackBarMessage)
        })
    }
}

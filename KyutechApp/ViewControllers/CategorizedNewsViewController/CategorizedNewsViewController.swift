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
    
    var indicator = ActivityIndicatorWithBackground()
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
        setupIndicator()
        getNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupIndicator() {
        self.view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(indicator)
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
        
        indicator.startAnimating()
        NewsModel.readNews(newsID: categoryCode, onSuccess: { [weak self] (readedNewsArray) in
            self?.newsArray = readedNewsArray
            self?.newsHeaderCollection.reloadData()
            self?.indicator.stopAnimating()
            }, onError: { () in
                self.indicator.stopAnimating()
                let snackBarMessage = MDCSnackbarMessage()
                snackBarMessage.duration = 2
                snackBarMessage.text = "データを取得できませんでした"
                MDCSnackbarManager.show(snackBarMessage)
        })
    }
}

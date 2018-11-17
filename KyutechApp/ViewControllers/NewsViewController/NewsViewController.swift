//
//  NewsViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents.MDCActivityIndicator

class NewsViewController: UIViewController {

    @IBOutlet weak var newsHeadCollection: UICollectionView!
    var newsHeadings: [NewsHeading] = []
    
    var indicator = ActivityIndicatorWithBackground()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewsTable()
        getHeader()
        setupNavigationBar()
        setupIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHeader()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationItem.title = "Test"
        navigationController?.navigationBar.removeBottomBorder()
        navigationController?.navigationBar.addShadowToBar(color: UIColor.extendedInit(from: "#00BCD4")!)
    }
    
    func setupNewsTable() {
        newsHeadCollection.delegate = self
        newsHeadCollection.dataSource = self
        newsHeadCollection.scrollsToTop = true
        
        let nib = UINib(nibName: "RoundHeadCollectionCell", bundle: nil)
        newsHeadCollection.register(nib, forCellWithReuseIdentifier: "NewsHeadCell")
    }
    
    func setupIndicator() {
        self.view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(indicator)
    }
    
    func getHeader() {
        self.indicator.startAnimating()
        NewsHeadingModel.readNewsHeadings(onSuccess: { [weak self] (newsHeads) in
            self?.newsHeadings = newsHeads
            DispatchQueue.main.async {
                self?.newsHeadCollection.reloadData()
            }
            self?.indicator.stopAnimating()
            }, onError: { () in
                self.indicator.stopAnimating()
                print("Error")
        })
    }
}


extension NewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsHeadings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsHeadCollection.dequeueReusableCell(withReuseIdentifier: "NewsHeadCell", for: indexPath) as! RoundHeadCollectionCell
        let newsHead = newsHeadings[indexPath.row]
        
        cell.setup(roundLabelText: newsHead.shortName, color: newsHead.color(), title: newsHead.name, date: newsHead.updatedAt)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = CGFloat(64)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(withIdentifier: "CategorizedNews") as! CategorizedNewsViewController
        let newsHeading = newsHeadings[indexPath.row]
        nextVC.categoryCode = newsHeading.newsHeadingCode
        nextVC.navigationItem.title = newsHeading.name
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}



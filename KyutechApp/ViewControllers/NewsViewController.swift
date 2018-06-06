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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewsTable()
        getHeader()
        setupNavigationBar()
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
    
    func getHeader() {
        let activityIndicator = MDCActivityIndicator()
        newsHeadCollection.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: newsHeadCollection.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: newsHeadCollection.centerYAnchor).isActive = true
        activityIndicator.cycleColors = [.blue, .red, .yellow, .green]

        activityIndicator.startAnimating()
        NewsHeadingModel.readNewsHeadings(onSuccess: { [weak self] (newsHeads) in
            self?.newsHeadings = newsHeads
            DispatchQueue.main.async {
                self?.newsHeadCollection.reloadData()
            }
            activityIndicator.stopAnimating()
            }, onError: { () in
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
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



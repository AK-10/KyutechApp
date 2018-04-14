//
//  NewsViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsHeadCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewsTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupNewsTable() {
        newsHeadCollection.delegate = self
        newsHeadCollection.dataSource = self
        newsHeadCollection.scrollsToTop = true
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        newsHeadCollection.register(nib, forCellWithReuseIdentifier: "NewsHeadCell")
    }

}


extension NewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsHeadCollection.dequeueReusableCell(withReuseIdentifier: "NewsHeadCell", for: indexPath) as! NewsCollectionCell
        cell.setup()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == newsHeadCollection {
            let navigationbar = self.navigationController?.navigationBar as? MaterialNavigationBar
            navigationbar?.addShadow()
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if scrollView == newsHeadCollection {
            let navigationbar = self.navigationController?.navigationBar as? MaterialNavigationBar
            navigationbar?.removeShadow()
        }
    }
    
}



//
//  NewsViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class NewsViewController: UIViewController {

    @IBOutlet weak var newsHeadCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewsTable()
        setupNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupNewsTable() {
        newsHeadCollection.delegate = self
        newsHeadCollection.dataSource = self
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        newsHeadCollection.register(nib, forCellWithReuseIdentifier: "NewsHeadCell")
    }
    
    func setupNavBar() {
    }

}


extension NewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsHeadCollection.dequeueReusableCell(withReuseIdentifier: "NewsHeadCell", for: indexPath) as! NewsCollectionCell
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = CGFloat(56)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//
//  CategorizedNewsViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class CategorizedNewsViewController: UIViewController {
    
    var newsArray: [News] = []
    var newsHeading: NewsHeading? = nil
    
    @IBOutlet weak var newsHeaderCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupNavbar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollection() {
        NewsModel.readNews(newsID: newsHeading?.newsHeadingCode ?? 357, onSuccess: { [weak self] (readedNewsArray) in
            self?.newsArray = readedNewsArray
            self?.newsArray.reverse()
            self?.newsHeaderCollection.reloadData()
        }, onError: { () in})
        let nib = UINib(nibName: "SimpleCardCell", bundle: nil)
        newsHeaderCollection.register(nib, forCellWithReuseIdentifier: "NewsHeadCell")
        newsHeaderCollection.delegate = self
        newsHeaderCollection.dataSource = self
        newsHeaderCollection.reloadData()
    }
    
    func setupNavbar() {
        self.navigationItem.title = newsHeading?.name
    }

}

extension CategorizedNewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsHeadCell", for: indexPath) as! SimpleCardCell
        let news = newsArray[indexPath.row]
        var title: String = ""
        var date: String = ""
        for content in news.infos {
            let infoTitle = content["title"]
            if infoTitle == "タイトル" || infoTitle == "休講科目" || infoTitle == "補講科目" || infoTitle == "件名"{
                title = content["content"]!
                break
            }
        }
        for content in news.infos {
            if content["title"] == "日付" || content["title"] == "期日" {
                date = content["content"]!
                break
            }
        }
        cell.setup(title: title, date: date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(withIdentifier: "NewsDetail") as! NewsDetailViewController
        nextVC.news = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(60)
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

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

extension CategorizedNewsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private func getLastCell() -> UICollectionViewCell? {
        let indexs = newsHeaderCollection.indexPathsForVisibleItems
        if indexs.last?.row == newsArray.count {
            return newsHeaderCollection.cellForItem(at: (indexs.last)!) ?? nil
        } else {
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height {
            NewsModel.fetchNews(onSuccess: { [weak self] (fetchedNews) in
                self?.newsArray.append(contentsOf: fetchedNews)
                self?.newsHeaderCollection.reloadData()
                NewsModel.isLoading = false
                }, onError: { [weak self] () in
                    print("error")
                    NewsModel.isLoading = false
                    let snackBarMessage = MDCSnackbarMessage()
                    snackBarMessage.text = "データを取得できませんでした"
                    snackBarMessage.duration = 2
                    MDCSnackbarManager.show(snackBarMessage)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsHeadCell", for: indexPath) as! SimpleCardCell
        cell.tag = 2130
        let news = newsArray[indexPath.row]
        let texts = news.getTexts()
        cell.setup(title: texts.0, date: texts.1)
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

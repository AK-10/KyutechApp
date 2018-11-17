//
//  CategorizedNewsViewController+CollectionView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MDCSnackbarMessage
import MaterialComponents.MDCSnackbarManager

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
            self.indicator.startAnimating()
            NewsModel.fetchNews(onSuccess: { [weak self] (fetchedNews) in
                self?.newsArray.append(contentsOf: fetchedNews)
                self?.newsHeaderCollection.reloadData()
                }, onError: { () in
                    print("error")
                    let snackBarMessage = MDCSnackbarMessage()
                    snackBarMessage.text = "データを取得できませんでした"
                    snackBarMessage.duration = 2
                    MDCSnackbarManager.show(snackBarMessage)
                }, completion: { () in
                    self.indicator.stopAnimating()
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

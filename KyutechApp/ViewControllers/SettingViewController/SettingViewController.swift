//
//  SettingViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/02.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import SafariServices

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingCollection: UICollectionView!
    let items: [(String,String)] = Const.webPageLinks
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollection() {
        let nib = UINib(nibName: "SimpleCardCell", bundle: nil)
        settingCollection.register(nib, forCellWithReuseIdentifier: "SettingCell")
        settingCollection.delegate = self
        settingCollection.dataSource = self
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.removeBottomBorder()
        self.navigationController?.navigationBar.addShadowToBar(color: UIColor.extendedInit(from: "#00BCD9")!)
    }
    

}

extension SettingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SimpleCardCell
        cell.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.titleLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.8).isActive = true
        cell.titleLabel.updateConstraints()
        cell.setup(title: items[indexPath.item].0, date: "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = CGFloat(56)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyBoard = UIStoryboard(name: "Update", bundle: nil)
            let updateDialog =  storyBoard.instantiateInitialViewController() as! UpdateUserInfoViewController
//            present(updateDialog, animated: true, completion: nil)
            self.tabBarController?.present(updateDialog, animated: true, completion: nil)
//        } else if indexPath.item == 1 {
//
        } else {
            guard let url = URL(string: items[indexPath.item].1) else { return }
            let safariView = SFSafariViewController(url:url)
            safariView.delegate = self
            UIApplication.shared.statusBarStyle = .default
            present(safariView, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SettingViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

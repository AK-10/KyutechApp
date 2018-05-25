//
//  NewsDetailTableViewCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/11.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class NewsDetailCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailLabel.textColor = .black
    }
    
    func setup(content: String, url: String) {
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .justified
        detailLabel.text = content
        if url != "" && !(url.contains("mailto:")) {
            self.isUserInteractionEnabled = true
            detailLabel.textColor = .blue
        } else {
            self.isUserInteractionEnabled = false
        }
    }
    
    
    func didTapped(urlString: String) {
        var url: URL? = nil
        if urlString != "" {
            url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        }
        guard let URL = url else { return }
        print("xxx")
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: {(isOpenSuccess) in
                if isOpenSuccess {
                    print("successed open \(URL)!")
                } else {
                    print("failed open \(URL)")
                }
            })
        } else {
            print("failed")
        }
        
    }


}

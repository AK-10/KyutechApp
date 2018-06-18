//
//  NewsDetailTableViewCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/11.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import SafariServices

class SimpleTableCell: UITableViewCell {

    @IBOutlet weak var detailTextView: UITextView!
    
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
        detailTextView.textColor = .black
        self.selectionStyle = .none
    }
    
    func setup(content: String, url: String) {
        self.selectionStyle = .none
        detailTextView.isEditable = false
        detailTextView.isScrollEnabled = false
        detailTextView.isSelectable = true
        detailTextView.textAlignment = .natural
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let attributedString = NSMutableAttributedString(string: content, attributes: [.paragraphStyle:paragraphStyle, .font:UIFont.systemFont(ofSize: 16)])
        if url != "" && !(url.contains("mailto:")) {
            print(url)
            detailTextView.textColor = UIColor.extendedInit(from: "#00BCD9")
            attributedString.addAttribute(.link, value: url, range: NSString(string: content).range(of: content))
        }
        detailTextView.attributedText = attributedString
    }
}

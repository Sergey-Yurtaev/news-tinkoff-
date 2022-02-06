//
//  NewsTableViewCell.swift
//  News
//
//  Created by Sergey Yurtaev on 05.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet var imageNewsView: ImageView!
    {
        didSet {
            imageNewsView.contentMode = .scaleAspectFit
            imageNewsView.clipsToBounds = true
            imageNewsView.backgroundColor = .white
        }
    }
    @IBOutlet var titleNewsLabel: UILabel!
    @IBOutlet var touchCounterLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
        
    // MARK: - Public methods
    func configure(with article: Article) {
        titleNewsLabel.text = article.title
        imageNewsView.fetchImage(from: article.urlToImage)
    }
}

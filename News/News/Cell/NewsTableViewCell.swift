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
            imageNewsView.contentMode = .scaleAspectFill
            imageNewsView.clipsToBounds = true
            imageNewsView.backgroundColor = .white
            imageNewsView.layer.cornerRadius = 20
        }
    }
    @IBOutlet var titleNewsLabel: UILabel!
    @IBOutlet var touchCounterLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    // MARK: - Public methods
    func configure(with article: Article) {
        titleNewsLabel.text = article.title
        guard let imageURL = article.urlToImage else { return }
        imageNewsView.fetchImage(from: imageURL)
        
    }
}

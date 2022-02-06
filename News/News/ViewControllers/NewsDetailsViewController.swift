//
//  NewsDetailsViewController.swift
//  News
//
//  Created by Sergey Yurtaev on 05.02.2022.
//

import UIKit
import SafariServices

class NewsDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = newsDetails.content
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var image: ImageView = {
        let image = ImageView()
        image.contentMode = .scaleAspectFit
        image.fetchImage(from: newsDetails.urlToImage)
        return image
    }()
    
    private lazy var fullNewsButton: UIButton = {
        let fullNewsButton = UIButton()
        fullNewsButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        
        fullNewsButton.setTitle("Click to go to link", for: .normal)
        fullNewsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        fullNewsButton.setTitleColor(.white, for: .normal)
        
        fullNewsButton.layer.cornerRadius = 10
        fullNewsButton.addTarget(self, action: #selector(goToFullNews), for: .touchUpInside)
        
        return fullNewsButton
    }()
    
    // MARK: - Public properties
    var newsDetails: Article!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        setupSubviews()
        setConstrains()
    }
    
    // MARK: - Private methods
    private func setupSubviews() {
        view.addSubview(image)
        view.addSubview(descriptionLabel)
        view.addSubview(fullNewsButton)
    }
    
    private func setConstrains() {
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 165),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            image.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 400)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        fullNewsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullNewsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            fullNewsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullNewsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func goToFullNews() {
        let fullNews = SFSafariViewController(url: URL(string: newsDetails.url)!)
        present(fullNews, animated: true)
    }
}

//
//  ViewController.swift
//  News
//
//  Created by Sergey Yurtaev on 05.02.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    //MARK: Private properties
    //pageSize20
    private let urlSrting = "https://newsapi.org/v2/everything?q=apple$&pageSize=20&apiKey=261ad03d5fb74b308c312eb98f9c58c1"
    private let cellID = "cell"
    private var news: News?
    private var newsArticle: [Article] = []
    var updateCounter = 0
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: cellID)
        setupNavigationBar()
        setNetworkData()
        setupRefreshControl()
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "tableviewloadingcellid")
    }
    
    // MARK: - Private methods
    private func setupNavigationBar() {
        title = "Breaking News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.configureWithOpaqueBackground()
        
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.titleTextAttributes =  [.foregroundColor: UIColor.white]
        navBarApperance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
    }
}

// MARK: - UITableViewDataSourse
extension NewsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArticle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsTableViewCell {
            
            let object = newsArticle[indexPath.row]
            cell.configure(with: object)
            
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailsVC = NewsDetailsViewController()
        navigationController?.pushViewController(newsDetailsVC, animated: true)
        let detailsNews = newsArticle[indexPath.row]
        newsDetailsVC.newsDetails = detailsNews
    }
}

// MARK: - Private Methods
extension NewsViewController {
    
    private func setNetworkData() {
        NetworkManager.shared.fetchData(from: urlSrting) { news in
            DispatchQueue.main.async {
                self.news = news
                self.news?.articles?.forEach({ value in
                    self.newsArticle.append(value)
                })
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(updateView), for: .valueChanged)
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc private func updateView() {
        NetworkManager.shared.fetchData(from: urlSrting) { news in
            self.news = news
            self.news?.articles?.forEach({ value in
                self.newsArticle.append(value)
            })
            DispatchQueue.main.async {
                self.newsArticle.shuffle()
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}


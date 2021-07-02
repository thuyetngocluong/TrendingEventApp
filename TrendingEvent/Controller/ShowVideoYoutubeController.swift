//
//  ShowVideoYoutubeController.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import YouTubePlayer
class ShowVideoYoutubeController: UIViewController {
    var alpha2Code: String?
    var itemTrending: ItemTrending?
    var itemYoutube: YoutubeModel?
    
    @IBOutlet weak var countryLB: UILabel!
    
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noDataLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        noDataLB.isHidden = true
        
        let countries = allCountries.filter { $0.alpha2 == alpha2Code}
        if countries.count > 0 {
            countryLB.text = countries[0].name
            countryImage.image = UIImage(named: countries[0].alpha2.lowercased())
        }
        
        tableView.register(UINib(nibName: "VideoYoutubeItemCell", bundle: nil), forCellReuseIdentifier: "VideoYoutbeItem")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData() {
        activityIndicator.isHidden = false
        if let item = itemTrending {
            YoutubeService.shared.search(content: item.title) {
                [weak self] in
                self?.itemYoutube = $1
                let count = $1?.items.count ?? 0
                DispatchQueue.main.async {
                    if count > 0 {
                        self?.noDataLB.isHidden = true
                    }
                    else {
                        self?.noDataLB.isHidden = false
                    }
                    self?.activityIndicator.isHidden = true
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShowVideoYoutubeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! VideoYoutubeItemCell
        if let item = itemYoutube?.items[indexPath.row] {
            cell.playVideo(item: item)
        }
    }
}

extension ShowVideoYoutubeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemYoutube?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoYoutbeItem", for: indexPath) as! VideoYoutubeItemCell
        if let item = itemYoutube?.items[indexPath.row] {
            cell.setCell(item: item)
        }
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
                  cell.alpha = 1
        }
        return cell;
    }
    
}

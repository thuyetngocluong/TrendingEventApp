//
//  ItemCell.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import Alamofire
import YouTubePlayer

class TrendingItemCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var moreInformationLB: UILabel!
    
    @IBOutlet weak var timePubLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(item: ItemTrending) {
        titleLB.text = item.title
        if item.newsItem.count > 0 {
            descriptionLB.text = item.newsItem[0].newsItemTitle
        }
        moreInformationLB.text = "Lượt xem: \(item.approxTraffic)"
        timePubLB.text = "\(item.pubDate.toTrendingDate?.toHourAgo ?? "") giờ trước"
        ImageService.shared.getUIImage(url: item.picture) {
            [weak self] _, image in
            DispatchQueue.main.async {
                self?.imgView.image = image
            }
        }
        
    }
}

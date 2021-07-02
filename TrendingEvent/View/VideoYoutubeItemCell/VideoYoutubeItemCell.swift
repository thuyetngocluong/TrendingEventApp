//
//  VideoYoutubeItemCell.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/29/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import Alamofire
import YouTubePlayer

class VideoYoutubeItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var channelLB: UILabel!

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var timePubLB: UILabel!
    var imgView: UIImageView!
    var videoPlayer: YouTubePlayerView!
    
    @IBOutlet weak var imageChannel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imageChannel.layer.cornerRadius = imageChannel.frame.width / 2
        imgView = UIImageView(frame: videoView.frame)
        videoView.addSubview(imgView)
    }
    
    func setCell(item: ItemYoutube) {
        titleLB.text = item.snippet.title
        channelLB.text = item.snippet.channelTitle
        timePubLB.text = "\(item.snippet.publishTime.toYoutubeDate?.toHourAgo ?? "") giờ trước"
        ImageService.shared.getUIImage(url: item.snippet.thumbnails.high.url) {
            [weak self] _, image in
            DispatchQueue.main.async {
                self?.imgView.image = image
            }
        }
        
        ChannelService.shared.getChannel(id: item.snippet.channelID) {
            [weak self] success, channelModel in
            if let model = channelModel {
                let itemsChannel = model.items.filter { $0.id == item.snippet.channelID }
                if itemsChannel.count > 0 {
                    let url = itemsChannel[0].snippet.thumbnails.high.url
                    ImageService.shared.getUIImage(url: url) {
                        [weak self] _, image in
                         DispatchQueue.main.async {
                            self?.imageChannel.image = image
                         }
                    }
                }
            }
        }
    }
    
    func playVideo(item: ItemYoutube) {
        videoPlayer = YouTubePlayerView(frame: videoView.frame)
        videoPlayer.loadVideoID(item.id.videoID)
        imgView.removeFromSuperview()
        videoView.addSubview(videoPlayer)
        videoView.layoutIfNeeded()
    }
    
}

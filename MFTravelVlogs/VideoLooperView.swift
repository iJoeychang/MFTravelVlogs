//
//  VideoLooperView.swift
//  MFTravelVlogs
//
//  Created by changyou on 2021/3/2.
//

import UIKit
import AVFoundation

class VideoLooperView: UIView {

    let clips: [VideoClip]
    let videoPlayerView = VideoPlayerView()
    
    // Add player
    @objc private let player = AVQueuePlayer()
    private var token: NSKeyValueObservation?

    init(clips: [VideoClip]) {
      self.clips = clips
      
      super.init(frame: .zero)
      
      // Set up the player
      initializePlayer()
      addGestureRecognizers()
    }
    
    // 10 Set up player
    private func initializePlayer() {
      videoPlayerView.player = player
      
      addAllVideosToPlayer()

      player.volume = 0.0
      player.play()
      
      token = player.observe(\.currentItem) { [weak self] player, _ in
        if player.items().count == 1 {
          self?.addAllVideosToPlayer()
        }
      }
    }
    
    // Create player items from video URLs and insert them into the player's list
    private func addAllVideosToPlayer() {
      for video in clips {
        let asset = AVURLAsset(url: video.url)
        let item = AVPlayerItem(asset: asset)
        player.insert(item, after: player.items().last)
      }
    }
    
    // Add methods to pause and play when the view leaves the screen
    func pause() {
      player.pause()
    }

    func play() {
      player.play()
    }
    
    // MARK - Gestures
    
    // Add single and double tap gestures to the video looper
    func addGestureRecognizers() {
      // 1
      let tap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasTapped))
      let doubleTap = UITapGestureRecognizer(target: self,
                                             action: #selector(VideoLooperView.wasDoubleTapped))
      doubleTap.numberOfTapsRequired = 2
      
      // 2
      tap.require(toFail: doubleTap)

      // 3
      addGestureRecognizer(tap)
      addGestureRecognizer(doubleTap)
    }
    
    // Single tapping should toggle the volume
    @objc func wasTapped() {
      player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    // Double tapping should toggle the rate between 2x and 1x
    @objc func wasDoubleTapped() {
      player.rate = player.rate == 1.0 ? 2.0 : 1.0
    }
    
    // MARK - Unnecessary Code
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

}

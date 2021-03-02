//
//  VideoPlayerView.swift
//  MFTravelVlogs
//
//  Created by changyou on 2021/3/2.
//

import UIKit

import AVFoundation

class VideoPlayerView: UIView {

    var player: AVPlayer? {
      get {
        return playerLayer.player
      }

      set {
        playerLayer.player = newValue
      }
    }
    
    // Override the layerClass
    override class var layerClass: AnyClass {
      return AVPlayerLayer.self
    }
    
    // Add accessor for playerLayer so you don't need to
    var playerLayer: AVPlayerLayer {
      return layer as! AVPlayerLayer
    }

}

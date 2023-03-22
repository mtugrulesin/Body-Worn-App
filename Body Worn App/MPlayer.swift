//
//  MPlayer.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import SwiftUI
import AVKit

struct MPlayer: View{
    
    var url:String
    
    
    var body: some View{
        
        let player = AVPlayer(url: URL(string: "http://11.11.11.1:3000/video/\(url)")!)
        VideoPlayer(player: player)
                    .onAppear() {
                        print("http://192.168.1.145:3000/video/\(url)")
                        // Start the player going, otherwise controls don't appear
                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                        player.play()
                    }
                    .onDisappear() {
                        // Stop the player when the view disappears
                        player.pause()
                    }
    }
    
}

/*struct MPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MPlayer()
    }
}*/

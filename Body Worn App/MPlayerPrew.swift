//
//  MPlayerPrew.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import SwiftUI
import AVKit

struct MPlayerPrew: View{
    
    var url:String
    
    
    @State private var isTouch = false
    
    var body: some View{
        
        let player = AVPlayer(url: URL(string: "http://11.11.11.1:3000/video/\(url)")!)
        
        VideoPlayer(player: player)
                    .onAppear() {
                        
                        // Start the player going, otherwise controls don't appear
                        player.play()
                        player.volume = 0
                        
                    }
                    .onDisappear() {
                        // Stop the player when the view disappears
                        player.pause()
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .top
                      )
        
        
    }
    
}

/*struct MPlayerPrew_Previews: PreviewProvider {
    static var previews: some View {
        MPlayerPrew()
    }
}*/

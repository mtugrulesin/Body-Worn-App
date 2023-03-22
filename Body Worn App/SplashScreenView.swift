//
//  SplashScreenView.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import SwiftUI

struct SplashScreenView: View {
    var network = Network()
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView().environmentObject(network)
            //MPlayer()
        }else{
            VStack{
                VStack{
                    Image("logo").font(.system(size: 80)).foregroundColor(.red).scaledToFit().frame(width: 50, height: 50)
                }.scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.125
                            self.opacity = (opacity+0.2)
                        }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+3){
                    withAnimation{
                        self.isActive = true
                    }
                    
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

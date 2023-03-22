//
//  ContentView.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @EnvironmentObject var network : Network
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            
            VStack{
                ProductInfo(network: network).padding()
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
          ).onAppear{
              DispatchQueue.background(delay: 2.0, completion: {
                  network.getDeviceStatus()
                  
              })
          }
        
    }
}

enum ImageNames: String{
    case waiting = "clock.fill"
    case checkMark = "checkmark.circle.fill"
    case record = "record.circle.fill"
}

enum StateName: String{
    case waiting = "Bekleniyor"
    case checkMark = "Hazır"
    case record = "Kayıt Devam Ediyor"
}

enum ButtonState: String{
    case start = "Start"
    case stop = "Stop"
}


struct ProductInfo: View{
    var network : Network
    @State private var imageName = ImageNames.waiting.rawValue
    @State private var state = StateName.waiting.rawValue
    @State private var buttonState = ButtonState.start.rawValue
    @State private var playerState = false
    @State private var recordings = [String]()
    @State private var isRecording = false
    @State private var seconds = 0
    @State private var videoUrl = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let time2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        
        if playerState{
            MPlayer(url: videoUrl).frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            ).onTapGesture {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                playerState = false
            }
        }else{
            VStack{
                ZStack{
                    
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white).padding().shadow(radius: 10)
                    VStack {
                        Text("Cihaz Durumu")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black).padding().frame(width: .infinity)
                            

                        HStack{
                            if imageName == ImageNames.record.rawValue{
                                Image(systemName: "\(imageName)").foregroundColor(Color.green).frame(width: 20, height: 20).scaleEffect(1.5)
                            }else{
                                Image(systemName: "\(imageName)").foregroundColor(Color.green).frame(width: 20, height: 20).scaleEffect(1.5)
                            }
                            Text(state)
                                .font(.title2)
                                .foregroundColor(.gray).padding().frame(height: 20)
                        }
                        Spacer()
                        //Text("00:00")
                        
                    }.padding(25)
                        .multilineTextAlignment(.leading).onAppear(){
                            network.getDeviceStatus()
                        }
                        
                    
                }.frame(width: 350, height: 130).onReceive(timer){time in
                    recordings.removeAll()
                    network.getDeviceStatus()
                    network.getVideoList()
                    
                    if network.videoList.videoList.count > 0{
                        recordings = network.videoList.videoList
                    }
                    
                    if ((network.res?.status) != false) {
                        isRecording = true
                        imageName = ImageNames.record.rawValue
                        buttonState = ButtonState.stop.rawValue
                        state = StateName.record.rawValue
                    }else if network.res?.status == false{
                        isRecording = false
                        buttonState = ButtonState.start.rawValue
                        imageName = ImageNames.checkMark.rawValue
                        state = StateName.checkMark.rawValue
                    }
                }
                
                
                HStack{
                    
                    
                    Button(action: {
                        
                        if network.res?.status == false{
                            
                            network.getRecordStart()
                        }else{
                            network.getRecordStop()
                        }
                        
                        
                    }) {
                        ZStack{
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipped()
                                .foregroundColor(.red)
                            Text(buttonState).frame(alignment: .center).foregroundColor(.white)
                        }
                    }
                    
                }
                
                ZStack{
                    
                    
                    
                    List{
                        
                        ForEach(recordings, id: \.self) { recording in
                            RecordingRow(videoUrl: recording).onTapGesture {
                                playerState = true
                                videoUrl = recording
                            }
                                    }
                        
                    }.onAppear{
                        UITableView.appearance().backgroundColor = .clear
                    }.shadow(radius: 10)
                        
                    
                }.frame(width: 350, height: 430)
                
                
                
                
                
                
            }
        }
        
    }
}



struct RecordingRow: View {
    
    
    
    
    var videoUrl: String
    
    var body: some View {
       
        HStack {
            Text("\(videoUrl)").font(.system(size: 13))
            Spacer()
            Button(action: {
                
                
            }) {
                Image(systemName: "play.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35, alignment: .center)
                    .clipped()
                    .foregroundColor(.black)
                    
            }
            
                MPlayerPrew(url: videoUrl).frame(width: 62)
            
            
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Network())
    }
}


extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

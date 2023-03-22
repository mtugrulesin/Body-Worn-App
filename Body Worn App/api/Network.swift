//
//  Network.swift
//  Body Worn App
//
//  Created by Mehmet Tuğrul EŞİN on 30.08.2022.
//

import Foundation


class Network: ObservableObject{
    
    @Published var res : Response?
    @Published var videoList : VideoListModel = VideoListModel(event: "",videoList: [])
    
    
    func getDeviceStatus(){
        guard let url = URL(string: "http://11.11.11.1:5000/status") else { fatalError("Missing URL") }

           let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedRes = try JSONDecoder().decode(Response.self, from: data)
                        self.res = decodedRes
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func getRecordStart(){
        guard let url = URL(string: "http://11.11.11.1:5000/startRecord") else { fatalError("Missing URL") }

           let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedRes = try JSONDecoder().decode(Response.self, from: data)
                        self.res = decodedRes
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    
    func getRecordStop(){
        guard let url = URL(string: "http://11.11.11.1:5000/stopRecord") else { fatalError("Missing URL") }

           let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedRes = try JSONDecoder().decode(Response.self, from: data)
                        self.res = decodedRes
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func getVideoList(){
        guard let url = URL(string: "http://11.11.11.1:5000/getVideoList") else { fatalError("Missing URL") }

           let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        print()
                        let decodedRes = try JSONDecoder().decode(VideoListModel.self, from: data)
                        self.videoList = decodedRes
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
}





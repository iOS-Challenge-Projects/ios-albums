//
//  AlbumController.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation


class AlbumController {
    
    //MARK: - Properties
    
    var albums: [Album] = []
    var baseURL = URL(string: "https://album-1b801.firebaseio.com/")!
    
    
    //MARK: - Networking
    
    func getAlbums(completion: @escaping (Error?)-> Void = { _ in }) {
        
        let requestURL = baseURL.appendingPathComponent(".json")
        //This function should perform a URLSessionDataTask that fetches the albums from the baseURL , decodes them
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error dugin URLSession: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No Data Found")
                completion(NSError())
                return
            }
            
            do{
                self.albums = try JSONDecoder().decode([String: Album].self, from: data).map(){$0.value}
                completion(nil)
            }catch{
                NSLog("Error Decoding data: \(error)")
                completion(error)
            }
        }.resume()
        // sets the albums array to the decoded albums
    }
    
    
    func put(album: Album, completion: @escaping (Error?)-> Void = { _ in }) {
        
        //append the id to update/create new entry
        let requestURL = baseURL.appendingPathComponent("\(album.id)").appendingPathComponent(".json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "PUT"
        
        
        //Encode data to prepare it then send it to FB
        do{
            request.httpBody = try JSONEncoder().encode(album)
        }catch{
            NSLog("Error Decoding data: \(error)")
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            if let error = error {
                NSLog("Error dugin URLSession: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    //MARK: - CRUD
    
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String) {
        
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, name: name)
        
        //add to the array of albums
        albums.append(newAlbum)
        
        //Create antry into FB
        put(album: newAlbum)
    }
    
    
    func createSong(duration: String, name: String)-> Song {
        let newSong = Song(duration: duration, name: name)
        
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        
//        album.artist = artist
//        album.coverArt = coverArt
//        album.genres = genres
//        album.name = name
//        album.songs = songs
//        
//        put(album: album)
    }
    
    //MARK: - Decode
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        
        let decoder = JSONDecoder()
        
        guard let url = urlPath else {  return }
        
        let data = try! Data(contentsOf: url)
        
        
        do{
            let album = try decoder.decode(Album.self, from: data)
            print("Decode: \(album)")
        }catch{
            print("Error Decoding data: \(error) ")
        }
        
    }
    
    
    
        //MARK: - Encode
    func testEncodingExampleAlbum()  {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        
        let encoder = JSONEncoder()
        
        guard let url = urlPath else {  return }
        
        let data = try! Data(contentsOf: url)
        
        
        do{
            let album = try encoder.encode(data)
            print("Encode: \(album)")
        }catch{
            print("Error Decoding data: \(error) ")
        }
        
    }
}

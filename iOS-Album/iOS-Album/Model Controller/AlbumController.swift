//
//  AlbumController.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation


class AlbumController {
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        
        let decoder = JSONDecoder()
        
        guard let url = urlPath else {  return }
        
        let data = try! Data(contentsOf: url)
        
        
        do{
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        }catch{
            print("Error Decoding data: \(error) ")
        }
        
    }
    
    
    func testEncodingExampleAlbum()  {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        
        let decoder = JSONDecoder()
        
        guard let url = urlPath else {  return }
        
        let data = try! Data(contentsOf: url)
        
        
        do{
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        }catch{
            print("Error Decoding data: \(error) ")
        }
        
    }
}

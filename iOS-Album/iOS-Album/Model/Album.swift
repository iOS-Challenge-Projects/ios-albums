//
//  Album.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    let artist: String
    let coverArt:  [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs:  [Song]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name  = try container.decode(String.self, forKey: .name)
        
        
        //Decode array
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLStrings: [String] = []
        
        //Append results
        while coverArtContainer.isAtEnd == false{
            let covertArtCon = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtCodingKeys.self)
            let coverArtURLString = try covertArtCon.decode(String.self, forKey: .url)
            
            coverArtURLStrings.append(coverArtURLString)
            
        }
        //Set the new array = to the original
        self.coverArt = coverArtURLStrings.compactMap{URL(string: $0)}
        
        //Decode Songs
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songsArray: [Song] = []
        
        while songsContainer.isAtEnd {
            let songString = try songsContainer.decode(Song.self)
            songsArray.append(songString)
        }
        
        
        songs  = songsArray
        
        
    }
    
    
    //MARK: - Encoder
    
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        //Get the coverArt
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        //Iterate over coverArt
        for cover in coverArt{
            var coverArtCont = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtCodingKeys.self)
            
            try coverArtCont.encode(cover, forKey: .url)
        }
    }
    
}

//MARK: - Song

struct Song: Codable {
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationCodingKeys: String,CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
    }
    
    let duration: String
    let id: String
    let name: String
    
    //The goal of implementing this initializer yourself is to avoid using nested structs
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        
        id = try container.decode(String.self, forKey: .id)
        
        
        //Pull duration from diccionary to make object using nestedContainer
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationCodingKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        
        //Created object using nestedContainer
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationCodingKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameCodingKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
        
    }
    
    
}

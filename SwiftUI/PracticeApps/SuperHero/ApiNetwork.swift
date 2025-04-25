//
//  ApiNetwork.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 30/01/25.
//

import Foundation

class ApiNetwork{
    
    struct Wrapper:Codable{
        let response:String
        let  results:[SuperHeroe]
    }
    
    struct SuperHeroe:Codable, Identifiable{
        let id:String
        let name:String
        let image:ImageSuperHero
        let powerstats:Powerstats
        let biography:Biography
    }
    struct ImageSuperHero: Codable{
        let url: String
    }
    
    struct SuperHeroCompleted:Codable{
        let id:String
        let name:String
        let image:ImageSuperHero
        let biography:Biography
        let powerstats:Powerstats
    }
    struct Powerstats:Codable{
        let intelligence:String
        let strength:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    
    struct Biography:Codable{
        let publisher:String
        let alignment:String
        let aliases: [String]
        let fullName:String
        //en json el parametro es full-name y lo
        //tenemos que pasar tal cual el valor
        enum CodingKeys: String, CodingKey {
            case fullName = "full-name"
            case publisher = "publisher"
            case alignment = "alignment"
            case aliases = "aliases"
        }
        
    }
    
    func getHeroesbyQuery(query:String) async throws -> Wrapper{
        let url = URL(string:"https://superheroapi.com/api/6a9dc5087fa7526cd5a63169973b1363/search/\(query)")
        
        let (data,_) = try await URLSession.shared.data(from: url!)
        
        let wapper = try JSONDecoder().decode(Wrapper.self, from: data)
        
        return wapper
    }
    func getHerobyId(id:String) async throws -> SuperHeroCompleted{
        
        let url = URL(string:"https://superheroapi.com/api/6a9dc5087fa7526cd5a63169973b1363/\(id)")
        
        let (data,_) = try await URLSession.shared.data(from: url!)
        
        return try JSONDecoder().decode(SuperHeroCompleted.self, from: data)
        
}
}

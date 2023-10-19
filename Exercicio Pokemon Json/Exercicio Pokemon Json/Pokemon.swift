//
//  Pokemon.swift
//  Exercicio Pokemon Json
//
//  Created by Usuário Convidado on 05/10/23.
//

import Foundation

struct UmPokemon:Decodable{
    var id:Int
    var name:String
    var sprites:Sprites
}

struct Sprites:Decodable{
    var front_default:String
}

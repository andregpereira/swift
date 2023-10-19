//
//  ViewController.swift
//  Exercicio Pokemon Json
//
//  Created by Usuário Convidado on 05/10/23.
//

import UIKit

var poke:UmPokemon!=nil

class ViewController: UIViewController {

    
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var minhaImagem: UIImageView!
    @IBOutlet weak var txtNomePokemon: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exibir(_ sender: Any) {
        if txtNomePokemon.text != ""{
            loadPokemon()
        }
       
    }
    
    
    
    func loadPokemon(){
        let jsonURLString = "https://pokeapi.co/api/v2/pokemon/" + txtNomePokemon.text!.lowercased()
        let url = URL(string: jsonURLString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard let data = data else {return}
            
            do{
                poke = try JSONDecoder().decode(UmPokemon.self, from: data)
                let imagem = self.carregarImagem(urlImagem: poke.sprites.front_default)
                DispatchQueue.main.sync {
                    self.lblNome.text = poke.name
                    self.lblId.text = String(poke.id)
                    self.minhaImagem.image = imagem
                }
        
            }catch let jsonError{
                print("Erro de serialização no Json", jsonError)
            }
        })
        .resume()
    }
    
    func carregarImagem(urlImagem:String)->UIImage?{
        var image:UIImage?=nil
        guard let url = URL(string: urlImagem)
        else{
            print("Não foi possível criar a url")
            return nil
        }
        do{
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
        
        return image
    }
    


}


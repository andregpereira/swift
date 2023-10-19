//
//  ViewController.swift
//  Exemplo 1 Json
//
//  Created by Usuário Convidado on 28/09/23.
//

import UIKit

var comic:Comic!=nil

class ViewController: UIViewController {
    
    var numero:Int=0
    var jsonUrlString:String=""
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var minhaImagem: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func exibir(_ sender: Any) {
        loadComic()
    }
    
    func loadComic(){
     
        if numero==0{
            jsonUrlString = "https://xkcd.com/info.0.json"
        }else{
            jsonUrlString = "https://xkcd.com/" + String(numero) + "/info.0.json"
        }
   
        
        
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
            do{
                comic = try JSONDecoder().decode(Comic.self, from: data)
                if self.numero==0{
                    self.numero=comic.num
                }
                let imagem = self.carregarImagem(urlImagem: comic.img)
                DispatchQueue.main.sync {
                    self.titulo.text = comic.title
                    self.id.text = String(comic.num)
                    self.data.text = comic.day + "/" + comic.month + "/" + comic.year
                    self.minhaImagem.image = imagem
                    self.numero = self.numero-1
                }
            }catch let erro{
                print("Erro de serialização", erro)
            }
        }
        .resume()
    }
    
    func carregarImagem(urlImagem:String)->UIImage?{
        guard let url = URL(string: urlImagem) else {return nil}
        var image:UIImage? = nil
        do{
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
        }catch let erro{
            print("Erro de serialização", erro)
        }
        return image
    }


}


//
//  ViewController.swift
//  Core Data Exemplo
//
//  Created by Usuário Convidado on 14/09/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var pessoaVindoDaTable:NSManagedObject?=nil

    override func viewDidLoad() {
        super.viewDidLoad()
        txtNome.delegate = self
        txtTelefone.delegate = self
        txtEmail.delegate = self
        if pessoaVindoDaTable != nil{
            txtNome.text = pessoaVindoDaTable?.value(forKey: "nome") as? String
            txtTelefone.text = pessoaVindoDaTable?.value(forKey: "telefone") as? String
            txtEmail.text = pessoaVindoDaTable?.value(forKey: "email") as? String
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtNome{
            txtTelefone.becomeFirstResponder()
            return true
        }else if textField == txtTelefone{
            txtEmail.becomeFirstResponder()
            return true
        }else if textField == txtEmail{
            salvar(textField)
            return true
        }else{
            return false
        }
    }
    
    @IBAction func salvar(_ sender: Any) {
        txtNome.resignFirstResponder()
        txtTelefone.resignFirstResponder()
        txtEmail.resignFirstResponder()
        save(nome: txtNome.text!, tele: txtTelefone.text!, emai: txtEmail.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func save(nome:String, tele:String, emai:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entidade = NSEntityDescription.entity(forEntityName: "Pessoa", in: managedContext)!
        
        if pessoaVindoDaTable == nil{
            //Aqui inicia o processo de gravação
            let pessoa = NSManagedObject(entity: entidade, insertInto: managedContext)
            pessoa.setValue(nome, forKeyPath: "nome")
            pessoa.setValue(tele, forKeyPath: "telefone")
            pessoa.setValue(emai, forKeyPath: "email")
        }else{
            var objectUpdate = pessoaVindoDaTable
            objectUpdate!.setValue(nome, forKeyPath: "nome")
            objectUpdate!.setValue(tele, forKeyPath: "telefone")
            objectUpdate!.setValue(emai, forKeyPath: "email")
        }
    

        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Não foi possível salvar \(error.localizedDescription)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtNome.resignFirstResponder()
        txtTelefone.resignFirstResponder()
        txtEmail.resignFirstResponder()
    }


}


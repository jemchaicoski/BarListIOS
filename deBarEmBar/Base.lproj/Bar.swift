//
//  File.swift
//  deBarEmBar
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//
import UIKit
import Foundation
import os.log

class Bar: NSObject, NSCoding {
    
    //MARK: Initialization
    init?(nome: String?, foto: UIImage?, telefone: String?, coordenadaX: Float?, coordenadaY: Float?, rating: Int?) {
        super.init()
        
        // Initialize stored properties.
        startNome(nome: nome!)
        startFoto(image: foto!)
        startTelefone(telefone: telefone!)
        startCoordenadas(coordenadaXtart: coordenadaX, coordenadaYtart: coordenadaY)
        startRating(rating: rating!)
        
    }
    
    private func startNome(nome: String){
        if(nome.isEmpty || nome.count < 3 ){
            self.nome = nil
        }else{
            self.nome = nome
        }
    }
    private func startFoto(image: UIImage){
        print(UIImage.Type.self)
        if(type(of: image) == UIImage.Type.self){
            self.foto = image
        }else{
            //self.foto = nil
        }
        self.foto = image
    }
    private func startTelefone(telefone: String){
        if(!telefone.isEmpty){
            let allowed = "0123456789"
            let characterSet = CharacterSet(charactersIn: allowed)
            guard telefone.rangeOfCharacter(from: characterSet.inverted) == nil else {
                self.telefone = nil
                return
            }
            self.telefone = telefone
        }
    }
    private func startCoordenadas(coordenadaXtart: Float?, coordenadaYtart: Float?){
        if(coordenadaXtart == nil || coordenadaYtart == nil){
            self.coordenadaX = nil
            self.coordenadaY = nil
        }else{
            self.coordenadaX = coordenadaXtart!
            self.coordenadaY = coordenadaYtart!
        }
    }
    private func startRating(rating: Int){
        if(rating < 0 || rating > 5){
            self.rating = nil
        }
        self.rating = rating
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: PropertyKey.nome)
        aCoder.encode(telefone, forKey: PropertyKey.telefone)
        aCoder.encode(foto, forKey: PropertyKey.foto)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
  
    convenience required init?(coder aDecoder: NSCoder) {
            
            // The name is required. If we cannot decode a name string, the initializer should fail.
            guard let nome = aDecoder.decodeObject(forKey: PropertyKey.nome) as? String else {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
            }
            
            // Because photo is an optional property of Meal, just use conditional cast.
            let foto = aDecoder.decodeObject(forKey: PropertyKey.foto) as? UIImage
        
            let telefone = aDecoder.decodeObject(forKey: PropertyKey.telefone)
        
            let coordenadaX = aDecoder.decodeFloat(forKey: PropertyKey.coordenadaX)
        
            let coordenadaY = aDecoder.decodeFloat(forKey: PropertyKey.coordenadaY)
            
            let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
            
            // Must call designated initializer.
            self.init(nome: nome,foto: foto, telefone: telefone as! String, coordenadaX: coordenadaX, coordenadaY: coordenadaY, rating: rating)
            
    }
    
    //MARK: Properties
    
    var nome: String?
    var foto: UIImage?
    var telefone: String?
    var coordenadaX: Float?
    var coordenadaY: Float?
    var rating: Int?
    
    struct PropertyKey {
        static let nome = "nome"
        static let telefone = "telefone"
        static let foto = "foto"
        static let coordenadaX = "coordenadaX"
        static let coordenadaY = "coordenadaY"
        static let rating = "rating"
    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(bars, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bars successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save bars...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Bar]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Bars")
}

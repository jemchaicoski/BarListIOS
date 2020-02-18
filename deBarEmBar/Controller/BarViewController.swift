//
//  BarViewController.swift
//  deBarEmBar
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//

import UIKit
import os.log

class BarViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var ImageBar: UIImageView!
    @IBOutlet weak var nomeBarTextField: UITextField!
    @IBOutlet weak var enderecoBarTextField: UITextField!
    @IBOutlet weak var telefoneBarTextField: UITextField!
    @IBOutlet weak var RatingBar: RatingBar!
    var bar: Bar?
    @IBOutlet weak var btnSalvar: UIBarButtonItem!
 
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        nomeBarTextField.delegate = self;
        
        // Set up views if editing an existing Meal.
        if let bar = bar {
            navigationItem.title = bar.nome
            nomeBarTextField.text = bar.nome
            telefoneBarTextField.text = bar.telefone
            ImageBar.image = bar.foto
            enderecoBarTextField.text = bar.endereco
            RatingBar.rating = bar.rating!
        }
        
        
        // Enable the Save button only if the text field has a valid Bar name.
        updateSaveButtonState()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
        switch textField{
        case nomeBarTextField:
            nomeCampo = "Bar: "
            break
        
        case enderecoBarTextField:
            nomeCampo = "Endereço: "
            break
            
        case telefoneBarTextField:
            nomeCampo = "Telefone: "
            break
            
        default:
            print("Errouuuuu")
        }
        
        let digitado = textField.text!
        let message = nomeCampo + digitado
        print(message)
        return true;
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Fodeo irmãozinho")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage] as? UIImage {
            ImageBar.contentMode = .scaleAspectFill
            ImageBar.image = pickedImage
    
    
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        btnSalvar.isEnabled = false
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === btnSalvar else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nomeBarTextField.text ?? ""
        let foto = ImageBar.image
        let telefone = telefoneBarTextField.text ?? ""
        let endereco = enderecoBarTextField.text ?? ""
        let rating = RatingBar.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        bar = Bar(nome: name, foto: foto, telefone: telefone, endereco: endereco, coordenadaX: 0.0, coordenadaY: 0.0, rating: rating)
    }
    
    @IBAction func setImage(_ sender: UITapGestureRecognizer) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated:true, completion: nil)
    }

    @IBAction func Cancel(_ sender: Any) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddBarMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBarMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nomeBarTextField.text ?? ""
        btnSalvar.isEnabled = !text.isEmpty
    }
    
}

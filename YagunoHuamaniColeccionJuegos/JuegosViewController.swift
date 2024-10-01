//
//  JuegosViewController.swift
//  YagunoHuamaniColeccionJuegos
//
//  Created by Angel Yaguno on 30/09/24.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row]
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var categoriaPicker: UIPickerView!
    
    var juego:Juego? = nil
    var categorias: [String] = ["Acción", "Aventura", "Estrategia", "RPG", "Deportes"]

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        categoriaPicker.delegate = self
        categoriaPicker.dataSource = self
        
        if juego != nil {
            imageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
            
            if let categoriaIndex = categorias.firstIndex(of: juego!.categoria ?? "") {
                categoriaPicker.selectRow(categoriaIndex, inComponent: 0, animated: false)
            }
        }
        
    }

    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
    }

    @IBAction func agregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if juego == nil {
            juego = Juego(context: context)
        }
        
        juego!.titulo = tituloTextField.text
        juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.5)
        juego!.categoria = categorias[categoriaPicker.selectedRow(inComponent: 0)]
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

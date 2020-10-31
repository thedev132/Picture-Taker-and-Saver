//
//  ViewController.swift
//  CameraApp
//
//  Created by Mohamad Mortada on 10/31/20.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var picButton: UIButton!
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\b
        shareButton.frame = CGRect(x: 45, y: 750, width: 290, height: 30)
        shareButton.addTarget(self, action: #selector(presentSharePage), for: .touchUpInside)
        view.addSubview(shareButton)
        picImage.backgroundColor = .secondarySystemFill
        picButton.backgroundColor = .systemBlue
    }
    
    
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            return
        }
        picImage.image = image
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
   
    @objc private func presentSharePage() {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: picImage.image!)
  
            return
        }
        

}
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}



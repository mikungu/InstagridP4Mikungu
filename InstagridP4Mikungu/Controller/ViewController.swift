//
//  ViewController.swift
//  InstagridP4Mikungu
//
//  Created by Mikungu Giresse on 10/07/22.
//

import UIKit

class ViewController: UIViewController {

    private var button: UIButton!
    private var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(nextSwipeGesture(recognizer:)))
    
    @IBOutlet var layouts: [UIButton]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var swipeText: UILabel!
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var centralViewLayout: CentralViewLayout!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(nextSwipeGesture(recognizer:)))
            self.centralViewLayout.addGestureRecognizer(swipeGesture)
            if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
                swipeGesture.direction = .left
            } else {
                swipeGesture.direction = .up
            }
    }

    @IBAction func tapButtonLayout1(_ sender: UIButton) {
        chooseButtonLayout1()
        markSelectedButton(sender)
    }
    
    private func chooseButtonLayout1 () {
        centralViewLayout.style = .wideTop
        
    }
    
    @IBAction func tapButtonLayout2(_ sender: UIButton) {
        chooseButtonLayout2()
        markSelectedButton(sender)
    }
    
    private func chooseButtonLayout2 () {
        centralViewLayout.style = .wideBottom
    }
    
    @IBAction func tapButtonLayout3(_ sender: UIButton) {
        chooseButtonLayout3()
        markSelectedButton(sender)
    }
    private func chooseButtonLayout3 () {
        centralViewLayout.style = .fourSquare
    }
    
    private func markSelectedButton (_ sender: UIButton) {
        layouts[0].isSelected = false
        layouts[1].isSelected = false
        layouts[2].isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func tapChooseImage(_ sender: UIButton) {
        button = sender
        openGalery()
        
    }
    
    @objc func nextSwipeGesture (recognizer: UISwipeGestureRecognizer) {
        animationView()
        share()
    }
    
    private func animationView () {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform : CGAffineTransform
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
           translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        } else {
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        }
        UIView.animate(withDuration: 0.3) {
            self.centralViewLayout.transform = translationTransform
        }
    }
    
    private func share () {
        let renderer = UIGraphicsImageRenderer(size: centralViewLayout.bounds.size)
        let screenshot = renderer.image {
            _ in centralViewLayout.drawHierarchy(in: centralViewLayout.bounds, afterScreenUpdates: true)
        }
        let activityController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { (_, _, _, _) in UIView.animate(withDuration: 0.3) { self.centralViewLayout.transform = .identity}
        }
    }
}

    extension ViewController:
        UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage]
            button.setImage(image as? UIImage, for: .normal)
            button.subviews.first?.contentMode = .scaleAspectFill
            picker.dismiss(animated: true, completion: nil)
        }
        
        private func openGalery () {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
                                                
    



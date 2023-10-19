//
//  ViewController.swift
//  swift-playground
//
//  Created by 이예빈 on 10/15/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
        
    var selectedImages: [UIImage] = []
        
    @IBAction func selectImagesButtonTapped(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 2
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
            
        present(picker, animated: true, completion: nil)
    }
        
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.selectedImages.append(image)
                                
                            if self?.selectedImages.count == 2 {
                                self?.showSelectedImages()
                                picker.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
        
    func showSelectedImages() {
        guard let firstImage = selectedImages.first else { return }

        imageView1.image = firstImage

        if selectedImages.count >= 2 {
            guard let secondImage = selectedImages[safeIndex: 1] else { return }
            imageView2.image = secondImage
        }
    }
}
// 배열 안전 접근을 위한 extension (safe index access)
extension Collection where Indices.Iterator.Element == Index {

    subscript(safeIndex index : Index) -> Iterator.Element? {

        return indices.contains(index) ? self[index] : nil

    }
}


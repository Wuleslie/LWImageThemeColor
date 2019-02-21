//
//  ViewController.swift
//  LWImageThemeColor
//
//  Created by XueSong on 2019/1/26.
//  Copyright © 2019 raystudio. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        setupSubViewsLayout()
        
        let cover:UIImage? = UIImage.init(named: "IMG_5542.JPG")
        imageView.image = cover
        
        let imageColor = cover?.themeColor()
        paletteView.backgroundColor = imageColor
    }
    
    private func setupSubViews() {
        view.addSubview(paletteView)
        paletteView.addSubview(imageView)
        view.addSubview(libraryButton)
        view.addSubview(cameraButton)
    }
    
    private func setupSubViewsLayout() {
        paletteView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview().offset(-80)
            $0.top.equalToSuperview().offset(80)
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        libraryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(paletteView.snp.bottom).offset(32)
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
        
        cameraButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(libraryButton.snp.bottom).offset(16)
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
    }
    
    @objc func pickAlbumPhoto() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func takeAPhoto() {
        imagePicker.sourceType = .camera
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.cameraCaptureMode = .photo;
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker .dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        paletteView.backgroundColor = image?.themeColor()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker .dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var paletteView:UIView = {
        let view = UIView.init()
        return view
    }()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView.init()
        return view
    }()
    
    lazy var libraryButton:UIButton = {
        let button = UIButton.init()
        button.layer.cornerRadius = 20.0
        button.layer.borderWidth = 1.0
        let purpleColor = UIColor.init(red: 128.0/255, green: 82.0/255, blue: 216.0/255, alpha: 1.0)
        button.layer.borderColor = purpleColor.cgColor
        button.setTitle("Pick from Albums", for: .normal)
        button.setTitleColor(purpleColor, for: .normal)
        let highlightedPurpleColor = UIColor.init(red: 128.0/255, green: 82.0/255, blue: 216.0/255, alpha: 0.5)
        button.setTitleColor(highlightedPurpleColor, for: .highlighted)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(pickAlbumPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraButton:UIButton = {
        let button = UIButton.init()
        button.layer.cornerRadius = 20.0
        button.layer.borderWidth = 1.0
        let purpleColor = UIColor.init(red: 128.0/255, green: 82.0/255, blue: 216.0/255, alpha: 1.0)
        button.layer.borderColor = purpleColor.cgColor
        button.setTitle("Take a photo", for: .normal)
        button.setTitleColor(purpleColor, for: .normal)
        let highlightedPurpleColor = UIColor.init(red: 128.0/255, green: 82.0/255, blue: 216.0/255, alpha: 0.5)
        button.setTitleColor(highlightedPurpleColor, for: .highlighted)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(takeAPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var imagePicker:UIImagePickerController = {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        return picker
    }()
}


//
//  ViewController.swift
//  Assignment_9
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let myview:UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
        
    }()
    
    private let imgpicker = UIImagePickerController()
    private let imgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myview)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        myview.addGestureRecognizer(tap)
        
        imgpicker.delegate = self
        imgView.contentMode = .scaleAspectFill
        imgpicker.allowsEditing = true
        myview.addSubview(imgView)
        
        let pinchGesture  = UIPinchGestureRecognizer(target: self, action: #selector(didpinchGesture))
            myview.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(didrotate))
            myview.addGestureRecognizer(rotateGesture)
        
               let leftswipe = UISwipeGestureRecognizer(target: self, action: #selector(didswipe))
                leftswipe.direction = .left
                myview.addGestureRecognizer(leftswipe)
        
                let rightswipe = UISwipeGestureRecognizer(target: self, action: #selector(didswipe))
                rightswipe.direction = .right
                myview.addGestureRecognizer(rightswipe)
        
                let upswipe = UISwipeGestureRecognizer(target: self, action: #selector(didswipe))
                upswipe.direction = .up
                myview.addGestureRecognizer(upswipe)
        
                let downswipe = UISwipeGestureRecognizer(target: self, action: #selector(didswipe))
                downswipe.direction = .down
                myview.addGestureRecognizer(downswipe)
        
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(didpan))
        myview.addGestureRecognizer(pangesture)
     
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        myview.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 500)
        imgView.frame = CGRect(x: 150, y: 300, width: 100, height: 100)
    }


}

extension ViewController{
    @objc private func didpan(gesture:UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        imgView.center = CGPoint(x:x,y:y)
    }
    
}
extension ViewController {
    @objc func didTap(){
        imgpicker.sourceType = .photoLibrary
//        DispatchQueue.main.async {
//            self.present(self.imgpicker, animated: true, completion: nil)
//        }
        self.present(self.imgpicker, animated: true, completion: nil)
    }
    
    @objc private func didpinchGesture(gesture: UIPinchGestureRecognizer){
                myview.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
            }
}
extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print("hello1")
        if let img = info[.editedImage] as? UIImage{
            imgView.image = img
            print("hello")
        }
//        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension ViewController{
    @objc private func didrotate(gesture: UIRotationGestureRecognizer){
        imgView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
}

extension ViewController{
    @objc private func didswipe(gesture: UISwipeGestureRecognizer){

        if gesture.direction == .left{
            UIView.animate(withDuration: 0.5){
                self.imgView.frame = CGRect(x: self.imgView.frame.origin.x - 40, y: self.imgView.frame.origin.y, width: 200, height: 200)
            }
        }
        else if gesture.direction == .right{

            UIView.animate(withDuration: 0.5){
                self.imgView.frame = CGRect(x: self.imgView.frame.origin.x + 40, y: self.imgView.frame.origin.y, width: 200, height: 200)
            }
        }
        else if gesture.direction == .up{
            imgView.frame = CGRect(x: imgView.frame.origin.x, y: imgView.frame.origin.y - 40, width: 200, height: 200)

        }
        else if gesture.direction == .down{
            imgView.frame = CGRect(x: imgView.frame.origin.x - 40, y: imgView.frame.origin.y+40, width: 200, height: 200)

        }
    }
}

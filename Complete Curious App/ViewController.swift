//
//  ViewController.swift
//  Complete Curious App
//
//  Created by Alan Santoso on 20/05/19.
//  Copyright © 2019 Alan Santoso. All rights reserved.
//

import UIKit
import CoreMotion
import SpriteKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var parallaxView: UIImageView!
    
    //KEY OUTLET
    
    @IBOutlet weak var trueKey: UIImageView!
    @IBOutlet weak var key1: UIImageView!
    @IBOutlet weak var key2: UIImageView!
    @IBOutlet weak var key3: UIImageView!
    @IBOutlet weak var key4: UIImageView!
    @IBOutlet weak var key5: UIImageView!
    
    
    @IBOutlet weak var imageSlot1: UIImageView!
    @IBOutlet weak var imageSlot2: UIImageView!
    @IBOutlet weak var imageSlot3: UIImageView!
    @IBOutlet weak var imageSlot4: UIImageView!
    @IBOutlet weak var imageSlot5: UIImageView!

    
    //rectangles
    @IBOutlet weak var rect1: UIImageView!
    @IBOutlet weak var rect2: UIImageView!
    @IBOutlet weak var rect3: UIImageView!
    @IBOutlet weak var rect4: UIImageView!
    @IBOutlet weak var rect5: UIImageView!


    //LOCK OUTLET
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var unlock: UIImageView!
    
    //ImageView
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    //Counter
    var counter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        //ACTIVATE BATTERY STATE
        UIDevice.current.isBatteryMonitoringEnabled = true
        let views = [key2,key3,key4, key5]
        let views2 = [image2]
        
        
        //Normal Panning
        for view in views {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleSpecialKeyPanGesture(recognizer:)))
            
            view?.addGestureRecognizer(gesture)
            
        }
        
        //Comeback Panning
        for view in views2 {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.comeBackPanning))
            
            view?.addGestureRecognizer(gesture)
            
            
        }
        
        //LONGPRESS
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(recognizer:)))
        
        parallaxView.addGestureRecognizer(longPress)
    
        setupFirstHint()
        
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(ViewController.shakeAnimation), userInfo: nil, repeats: true)

        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.key1.alpha += 0.2
        print(self.key1.alpha)
        if self.key1.alpha > 1 {
            print("COMPLETED")
            self.timer.invalidate()
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleSpecialKeyPanGesture(recognizer:)))
            
            self.key1.addGestureRecognizer(gesture)
        }else{
            Vibration.heavy.vibrate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //motionEffect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup(){
        image3.layer.cornerRadius = 50
        image2.layer.cornerRadius = 50
        parallaxView.layer.cornerRadius = 50
        key1.transform = CGAffineTransform(rotationAngle: 3.92699)
        key2.transform = CGAffineTransform(rotationAngle: 3.92699)
        key4.transform = CGAffineTransform(rotationAngle: 3.92699)
        key5.transform = CGAffineTransform(rotationAngle: 3.92699)
        
        
        imageSlot1.transform = CGAffineTransform(rotationAngle: 3.92699)
        imageSlot2.transform = CGAffineTransform(rotationAngle: 3.92699)
        imageSlot3.transform = CGAffineTransform(rotationAngle: 3.92699)
        imageSlot4.transform = CGAffineTransform(rotationAngle: 3.92699)
        imageSlot5.transform = CGAffineTransform(rotationAngle: 3.92699)

        trueKey.alpha = 0
        trueKey.center = CGPoint(x: trueKey.frame.midX, y: trueKey.frame.midY)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8678501248, blue: 0.3901852369, alpha: 0.8094499144)

        key1.alpha = 0.2
        unlock.alpha = 0
        
        setGradientBackground(colorTop: .yellow, colorBottom: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        
        imageSlot1.alpha=0
        imageSlot2.alpha=0
        imageSlot3.alpha=0
        imageSlot4.alpha=0
        imageSlot5.alpha=0
        
        
    }
    
    func setupFirstHint(){
        UIView.animate(withDuration: 3, animations: {
            self.key3.transform = CGAffineTransform(translationX: 0, y: -140)
        }) { (_) in
            self.key3.alpha=0
            self.imageSlot1.alpha = 1
            Vibration.heavy.vibrate()
        }
    }
    
    @objc func shakeAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: key1.center.x - 10, y: key1.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: key1.center.x + 10, y: key1.center.y))
        
        key1.layer.add(animation, forKey: "position")
    }
    
    @objc func longPress (recognizer : UILongPressGestureRecognizer){
        print("getpressed")
        UIView.animate(withDuration: 2, animations: {
            self.parallaxView.alpha = 0
            self.parallaxView.transform = CGAffineTransform(translationX: 0, y: -100)
        }) { (_) in
            
        }
    }
    
    @objc func handleSpecialKeyPanGesture(recognizer : UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            print("lock x: \(lock.center.x), y: \(lock.center.y)")
            
           if (view.center.y < 368 && view.center.x > 206 && view.center.x < 214 && view.center.y > 362) {
                counter += 1
                //view.center = CGPoint(x:300, y:200)
                switch counter{
                case 1 :
                    view.center = CGPoint(x:125, y:125)
                    view.isUserInteractionEnabled = false
                    recognizer.isEnabled = false
                    Vibration.heavy.vibrate()
                    imageSlot2.image = recognizer.view?.asImage()
                    imageSlot2.alpha = 1
                    view.alpha = 0
                    
                case 2:
                    view.center = CGPoint(x:204, y:125)
                    view.isUserInteractionEnabled = false
                    recognizer.isEnabled = false
                    Vibration.heavy.vibrate()
                    imageSlot3.image = recognizer.view?.asImage()
                    imageSlot3.alpha = 1
                    view.alpha = 0


                case 3:
                    view.center = CGPoint(x:282, y:125)
                    view.isUserInteractionEnabled = false
                    recognizer.isEnabled = false
                    Vibration.heavy.vibrate()
                    imageSlot4.image = recognizer.view?.asImage()
                    imageSlot4.alpha = 1
                    view.alpha = 0


                case 4:
                    view.center = CGPoint(x:364, y:125)
                    view.isUserInteractionEnabled = false
                    recognizer.isEnabled = false
                    Vibration.heavy.vibrate()
                    imageSlot5.image = recognizer.view?.asImage()
                    imageSlot5.alpha = 1
                    view.alpha = 0
                    finishingAnimation()
                    

                case 5:
                    view.center = CGPoint(x:362, y:125)
                    view.isUserInteractionEnabled = false
                    recognizer.isEnabled = false
                    Vibration.heavy.vibrate()
                    
                    
                default:
                    counter = 0
                }
            }
            print("position \(view.center)")
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func finishingAnimation(){
        
        UIView.animate(withDuration: 3, animations: {
            self.imageSlot1.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY+50)
            self.imageSlot2.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY+50)
            self.imageSlot3.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY+50)
            self.imageSlot4.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY+50)
            self.imageSlot5.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY+50)
            
            self.rect1.alpha = 0
            self.rect2.alpha = 0
            self.rect3.alpha = 0
            self.rect4.alpha = 0
            self.rect5.alpha = 0

            self.image2.alpha = 0
            self.image3.alpha = 0
        }) { (_) in
            print("success")
            UIView.animate(withDuration: 2, animations: {
                self.imageSlot1.alpha=0
                self.imageSlot2.alpha=0
                self.imageSlot3.alpha=0
                self.imageSlot4.alpha=0
                self.imageSlot5.alpha=0
            }, completion: { (_) in
                UIView.animate(withDuration: 2, animations: {
                    self.trueKey.alpha=1
                }, completion: { (_) in
                    UIView.animate(withDuration: 3, animations: {
                        self.trueKey.transform = CGAffineTransform(translationX: 0, y: -140)
                    }, completion: { (_) in
                        UIView.animate(withDuration: 1, animations: {
                            self.trueKey.alpha = 0
                        }, completion: { (_) in
                            self.animateUnlock()
                        })
                    })
                })
            })
           
        }
        
    }
    
    @objc func comeBackPanning(recognizer : UIPanGestureRecognizer){
        if recognizer.state == .began{
        } else if recognizer.state == .changed {
            //LOCATION OF X or Y
            
            
            let translation = recognizer.translation(in: self.view)
            
            recognizer.view!.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            
        }else if recognizer.state == .ended {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                recognizer.view!.transform = .identity
            })
        }
    }
    
    func animateUnlock(){
        UIView.animate(withDuration: 2, delay: 0.5, animations: {
            self.lock.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 2, animations: {
                self.unlock.alpha = 1
            }, completion: {(_) in
                let alert = UIAlertController(title: "Congratulations!", message: "You've Won", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
                
            })
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}



extension UIView {
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//
//  AppMainVc.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//

/* import classes */
import UIKit
import Lottie

@available(iOS 10.0, *)
class AppMainVc: UIViewController {
    
    //MARK:- Variables
    
   var loaderBackView:UIView!
   var viewLoader : AnimationView!
    
    //MARK:- View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //MARK:- View Life Cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }
    
  func setupAnimationView() {
          viewLoader = AnimationView.init(name: "loader")
          viewLoader.contentMode = .scaleAspectFit
          viewLoader.frame = CGRect.init(x: 0, y: 0, width: 60 , height: 60)
          viewLoader.center = self.view.center
          viewLoader.loopMode = .loop
   
      }
  /* Start Loader */
     func startSpinner() {
         setupAnimationView()
         self.viewLoader.isHidden = false
         self.loaderBackView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
         self.loaderBackView.backgroundColor = UIColor.clear
         self.view.addSubview(self.loaderBackView)
         self.view.addSubview(self.viewLoader)
         self.viewLoader.play()
      
     }

     /* Stop Loader */
     func stopSpinner() {
         if self.viewLoader != nil {
             self.viewLoader.isHidden = true
             self.viewLoader.stop()
             self.loaderBackView.removeFromSuperview()
             self.viewLoader.removeFromSuperview()
         }
     }
   
    
    /* Creating Custom Alert */
    func showAlert(message msg:String , title:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("any")
            }}))
        DispatchQueue.main.async() {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
     
    
    /* Hiding Keyboard */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboardonTapAnywhereonView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /* Dismiss Keyboard */
    @objc func dismissKeyboardonTapAnywhereonView() {
        view.endEditing(true)
    }
}


extension Date {

    func getElapsedInterval() -> String {
        

        var interval = Calendar.current.dateComponents([.year], from: self, to: Date()).year

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "year ago" :
                "\(interval ?? 0)" + " " + "years ago"
        }
        
         interval = Calendar.current.dateComponents([.month], from: self, to: Date()).month

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "month ago" :
                "\(interval ?? 0)" + " " + "months ago"
        }
        
        
        interval = Calendar.current.dateComponents([.day], from: self, to: Date()).day

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "day ago" :
                "\(interval ?? 0)" + " " + "days ago"
        }
        
        
        interval = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "hr ago" :
                "\(interval ?? 0)" + " " + "hours ago"
        }
        
        interval = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "min ago" :
                "\(interval ?? 0)" + " " + "minutes ago"
        }
        
        interval = Calendar.current.dateComponents([.second], from: self, to: Date()).second

        if (interval ?? 0) > 0 {
            return interval == 1 ? "\(interval ?? 0)" + " " + "sec ago" :
                "\(interval ?? 0)" + " " + "seconds ago"
        }
         return "a moment ago"

    }
}

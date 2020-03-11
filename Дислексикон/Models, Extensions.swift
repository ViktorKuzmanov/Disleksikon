//  Created by Viktor Kuzmanov on 3/23/18.
//  Copyright © 2018 Code X Team. All rights reserved.

import Foundation
import UIKit
import AVFoundation

class Nivo1Object {
    
    var objectName: String
    var image: UIImage
    var audioName: String
    
    init(objectName: String, image: UIImage, audioName: String) {
        self.objectName = objectName
        self.image = image
        self.audioName = audioName
    }
}

struct Nivo3 {
    
    var audioNamePrasanje: String
    var odgovori: [Odgovor]
}

struct Odgovor {
    
    var tekst: String 
    var audioName: String
    var tocnoIliNe: Bool
}

extension UIButton {
    
    // Pulse animation on button
    
    func runPulseAnimation() {
        
        let pulseAnimation = CASpringAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.6
        pulseAnimation.fromValue = 0.95
        pulseAnimation.toValue = 1.0
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 2
        pulseAnimation.initialVelocity = 0.5
        pulseAnimation.damping = 1.0
        
        layer.add(pulseAnimation, forKey: nil)
    }
    
    // mark animation on button
    
    func bounceAnimation() {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // MARK: Generic func playAudio
    
    func playAudio(audioName: String) {
        let urlKnigaAudio = Bundle.main.url(forResource: audioName, withExtension: "m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlKnigaAudio!)
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        audioPlayer.play()
    }
}


extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4 = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}

extension UICollectionViewCell {
    
    // MARK: Pop up text
    func popUpText(message : String) {
        var toastLabel = UILabel()
        
        // Setup different size labels for different devices
        switch UIDevice.current.screenType.rawValue {
            
        case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE":
            let labelForThis = UILabel(frame: CGRect(x: 10, y: self.frame.size.height - 200 , width: 300, height: 60))
            toastLabel = labelForThis
            toastLabel.numberOfLines = 0
            
        case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
            let labelForThis = UILabel(frame: CGRect(x: 10, y: self.frame.size.height - 200 , width: 350, height: 35))
            toastLabel = labelForThis
    
        case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
            let labelForThis = UILabel(frame: CGRect(x: 20, y: self.frame.size.height - 200 , width: 370, height: 36))
            toastLabel = labelForThis
            
        case "iPhone X":
            let labelForThis = UILabel(frame: CGRect(x: 10, y: self.frame.size.height - 200 , width: 350, height: 36))
            toastLabel = labelForThis
            
        default:
            break
        }
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 25.0)
        toastLabel.text = message
        toastLabel.alpha = 1
        toastLabel.layer.cornerRadius = 7
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 0.3, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.8
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

// EVE PRIMER ZA AKO SAKAS SO SWITCH ZA SITE DEVICES
//
//switch UIDevice.current.screenType.rawValue {
//case "iPhone 4 or iPhone 4S":
//    return 63
//case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE":
//    return 72
//case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
//    return 80
//case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
//    return 83
//case "iPhone X":
//    return 85
//default:
//    return 70
//}






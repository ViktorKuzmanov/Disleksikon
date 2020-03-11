//Created by Viktor Kuzmanovon 3/23/18.Copyright © 2018 Code X Team. All rights reserved.

import UIKit
import AVFoundation

class NivoaViewController: UIViewController {

    @IBOutlet weak var buttonNivo1: UIButton!
    @IBOutlet weak var buttonNivo2: UIButton!
    @IBOutlet weak var buttonNivo3: UIButton!
    @IBOutlet weak var stackViewNivoa: UIStackView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pozadinaZaNivoa")!)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonNivo3.layer.cornerRadius = 20
        buttonNivo2.layer.cornerRadius = 20
        buttonNivo1.layer.cornerRadius = 20
        
        setupConstrantsBasedOnOrientation()
        setupBackButtonInNextController()
    }
    
    // MARK: Setup na button kopce
    
    func setupBackButtonInNextController() {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Arial", size: 17)!], for: UIControlState.normal)
        backButton.tintColor = #colorLiteral(red: 0.3596812487, green: 0.6592496037, blue: 0.8525697589, alpha: 1)
        navigationItem.backBarButtonItem = backButton
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
    
    // MARK: Nivo buttons funkcii
    
    @IBAction func nivo1ButtonIsPressed(_ sender: UIButton) {
        playAudio(audioName: "nauciJaAzbukata")
        sender.runPulseAnimation()
    }
    
    @IBAction func nivo2ButtonIsPressed(_ sender: UIButton) {
        playAudio(audioName: "sliko-zbor")
        sender.runPulseAnimation()
    }
    
    @IBAction func nivo3ButtonIsPressed(_ sender: UIButton) {
        playAudio(audioName: "nivo3")
        sender.runPulseAnimation()
    }
    
    // MARK: Setup constraints na stackViewNivoa (istite se i u protrait i u landscape)
    
    func setupConstrantsBasedOnOrientation() {
        
        switch UIDevice.current.screenType.rawValue {
            
        case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE": // ne e ok u portrait
            stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            
        case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
            stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
            stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
            
        case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
            stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
            stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
            
        case "iPhone X":
            stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
            stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
            
        default:
            break
        }
    }
}

//else { // ako e u landscape
//
//            switch UIDevice.current.screenType.rawValue {
//
//            case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE":
//                stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75).isActive = true
//                stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -75).isActive = true
//                print()
//                print("U LANDSCAPE E e u iPhone SE")
//                print()
//
//            case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
//                stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
//                stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
//
//            case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
//                stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
//                stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
//
//            case "iPhone X":
//                stackViewNivoa.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 110).isActive = true
//                stackViewNivoa.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110).isActive = true
//
//            default:
//                break
//            }
//        }

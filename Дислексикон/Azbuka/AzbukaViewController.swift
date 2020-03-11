//  Created by Viktor Kuzmanov on 3/23/18.
//  Copyright © 2018 Code X Team. All rights reserved.
import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer!

class AzbukaViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var bukviArray = ["а","б","в","г","д","ѓ","е","ж","з","ѕ","и","ј","к","л","љ","м","н","њ","о","п","р","с","т","ќ","у","ф","х","ц","ч","џ","ш"]
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupHeightOnContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        setupNavigationBarStuff()
        setupHeightOnContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Other functions
    
    func setupNavigationBarStuff() {
//        navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "bukvi")!)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.black,
             NSAttributedStringKey.font: UIFont(name: "BodoniSvtyTwoSCITCTT-Book", size: 25)!]
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Азбука"
    }
    
    // MARK: Kaa ce click na bukva pravi sound
    
    @IBAction func buttonBukvaIsPressed(_ sender: UIButton) {
        
        if sender.tag != 31 {
            sender.playAudio(audioName: bukviArray[sender.tag])
            sender.bounceAnimation()
        }
    }
    
    func setupHeightOnContentView() {
        
        if UIDevice.current.orientation.isPortrait == true { // ako e u portrait via heights
            
            switch UIDevice.current.screenType.rawValue {

            case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE":
                contentView.heightAnchor.constraint(equalToConstant: 725).isActive = true
                print("u portrait u iPhone SE")

            case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
                contentView.heightAnchor.constraint(equalToConstant: 820).isActive = true
                print("u portrait u iPhone 8")

            case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
                contentView.heightAnchor.constraint(equalToConstant: 900).isActive = true
                print("u portrait u iPhone Plus")

            case "iPhone X":
                contentView.heightAnchor.constraint(equalToConstant: 830).isActive = true
                print("u portrait u iPhone X")

            default:
                contentView.heightAnchor.constraint(equalToConstant: 780)

            }

        } else if UIDevice.current.orientation.isLandscape == true { // setup contentView za ako e u landscape orientation
            
            switch UIDevice.current.screenType.rawValue {

            case "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE":
                contentView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
                print("u landscape iPhone Se")

            case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
                contentView.heightAnchor.constraint(equalToConstant: 1350).isActive = true
                print("u landscape iPhone 8")

            case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
                contentView.heightAnchor.constraint(equalToConstant: 1550).isActive = true
                print("u landscape iPhone Plus")

            case "iPhone X":
                contentView.heightAnchor.constraint(equalToConstant: 1650).isActive = true
                print("u landscape iPhone X")

            default:
                contentView.heightAnchor.constraint(equalToConstant: 1550)

            }
        }
    }
}


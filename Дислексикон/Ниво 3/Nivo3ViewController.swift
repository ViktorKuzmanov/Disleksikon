import UIKit
import AVFoundation

class Nivo3ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.title = "Тест"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Button za exit is pressed
    @IBAction func backButtonForExitIsPressed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: Butron za audio na text is pressed
    @IBAction func buttonAudioZaTekstPressed(_ sender: UIButton) {
        sender.playAudio(audioName: "а")
        sender.bounceAnimation()
    }
}

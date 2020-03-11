import UIKit
import AVFoundation

class SlikoZborCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    var audioPlayer: AVAudioPlayer!
    var brojac = 0
    
    @IBOutlet weak var constraintHintBtnOnBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintPrasalnikBtnBottom: NSLayoutConstraint!
    
    @IBOutlet weak var imageNaObject: UIImageView!
    @IBOutlet weak var buttonAudio: UIButton!
    @IBOutlet weak var textFieldZaObject: UITextField!
    @IBOutlet weak var buttonGotovo: UIButton!
    @IBOutlet weak var imageZaProverka: UIImageView!
    @IBOutlet weak var buttonZaProverka: UIButton!
    @IBOutlet weak var buttonHint: UIButton!
    @IBOutlet weak var buttonPrasalnik: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldZaObject.delegate = self 
//        buttonZaProverka.isHidden = true
        buttonGotovo.layer.cornerRadius = 10
    }
    
    @IBAction func buttonAudioIsPressed(_ sender: UIButton) {
        
        // PLAY SOME AUDIO
        let nameOfAudio = GlobalStuff.globalObjects[sender.tag].audioName
        
        let urlKnigaAudio = Bundle.main.url(forResource: nameOfAudio, withExtension: "m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlKnigaAudio!)
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        sender.runPulseAnimation()
        audioPlayer.play()
    }
    
    // MARK: TextField check if correct or incorrect
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonZaProverka.isHidden = false
        imageZaProverka.isHidden = false
        
        // za pred i posle text da nema prazno mesto ako stavil korisnikot
        while textField.text?.last == " " {
            textField.text?.removeLast()
        }
        while textField.text?.first == " " {
            textField.text?.removeFirst()
        }
        
        if textField.text?.lowercased() == GlobalStuff.globalObjects[textFieldZaObject.tag].objectName {
            buttonZaProverka.setTitle("Точен одговор", for: .normal)
            buttonZaProverka.setTitleColor(#colorLiteral(red: 0.3890887499, green: 0.8534072042, blue: 0, alpha: 1), for: .normal)
            imageZaProverka.image = UIImage(named: "Tocno")
        } else {
            buttonZaProverka.setTitle("Погрешен одговор", for: .normal)
            buttonZaProverka.setTitleColor(.red, for: .normal)
            imageZaProverka.image = UIImage(named: "Netocno")
        }
        
    }
    
    // MARK: Gotovo is pressed
    
    @IBAction func buttonGotovoIsPressed(_ sender: UIButton) {
        buttonZaProverka.isHidden = false
        imageZaProverka.isHidden = false 
        
        textFieldZaObject.resignFirstResponder()
        sender.bounceAnimation()
        
        // za pred i posle text da nema prazno mesto ako stavil korisnikot
        while textFieldZaObject.text?.last == " " {
            textFieldZaObject.text?.removeLast()
        }
        while textFieldZaObject.text?.first == " " {
            textFieldZaObject.text?.removeFirst()
        }
        
        if textFieldZaObject.text?.lowercased() == GlobalStuff.globalObjects[tag].objectName {
            buttonZaProverka.setTitle("Точен одговор", for: .normal)
            buttonZaProverka.setTitleColor(#colorLiteral(red: 0.3890887499, green: 0.8534072042, blue: 0, alpha: 1), for: .normal)
            imageZaProverka.image = UIImage(named: "Tocno")
        } else {
            buttonZaProverka.setTitle("Погрешен одговор", for: .normal)
            buttonZaProverka.setTitleColor(.red, for: .normal)
            imageZaProverka.image = UIImage(named: "Netocno")
        }
    }
    
    // MARK: Button za proverka is pressed
    @IBAction func buttonZaProverkaIsPressed(_ sender: UIButton) {
        
        // PLAY SOME AUDIO
        if sender.titleLabel?.text == "Точен одговор" {
            playAudio(audioName: "точен одговор")
            sender.runPulseAnimation()
        } else {
            playAudio(audioName: "погрешен одговор")
            sender.runPulseAnimation()
        }
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
    
    @IBAction func buttonPrasalnikIsPressed(_ sender: UIButton) {
        playAudio(audioName: "prasalnik")
        sender.bounceAnimation()
        popUpText(message: "Напиши го тоа што го гледаш на сликата")
    }
    
    @IBAction func buttonHintIsPressed(_ sender: UIButton) {
        brojac += 1
        sender.bounceAnimation()
        print()
        print("brojac = ", brojac)
        print()
        
        if brojac == 1 {
            popUpText(message: "Притисни уште еднаш за точниот одговор")
            playAudio(audioName: "hint")
        } else if brojac == 2 {
            popUpText(message: GlobalStuff.globalObjects[sender.tag].objectName)
            brojac = 0
        } else {
        }
    }
}

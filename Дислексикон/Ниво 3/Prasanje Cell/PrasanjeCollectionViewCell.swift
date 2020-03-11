import UIKit

class PrasanjeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var buttonImagePrasanje: UIButton!
    
    @IBOutlet weak var stackViewOdgovori: UIStackView!
    @IBOutlet weak var buttonOdgovor1: UIButton!
    @IBOutlet weak var buttonOdgovor2: UIButton!
    @IBOutlet weak var buttonOdgovor3: UIButton!
    
    @IBOutlet weak var buttonAudio1: UIButton!
    @IBOutlet weak var buttonAudio2: UIButton!
    @IBOutlet weak var buttonAudio3: UIButton!
    
    @IBOutlet weak var imageTocnoIliNe: UIImageView!
    @IBOutlet weak var odgovoriStackView: UIStackView!
    
    var brojac = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRounderBordersAnd2LinesOnButtons()
        setupSpacingForDifferentDevices()
    }
    
    // MARK: Button prasanje is pressed
    
    @IBAction func buttonPrasanjeIsPressed(_ sender: UIButton) {
        let audioNamePrasanje = Nivo3GlobalStruct.nivo3Objects[tag].audioNamePrasanje
        sender.playAudio(audioName: audioNamePrasanje)
    }
    
    // MARK: Buttons odgovori are pressed
    @IBAction func buttonOdgovorOneIsPressed(_ sender: UIButton) {
        
        // Animate imageTocnoIliNe zoom out ako zavisno od toa dali e tocno ili ne
        brojac += 1
        if brojac <= 1 {
            animateImageTocnoIliNe(odgovorButtonTag: 0, senderZaDaCallFunc: sender)
        }
        // Da vidime dali e tocen i da change bg color spored toa
        let trueIliFalse = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[0].tocnoIliNe
        changeColorNaOdgovorClickURedIliGreen(sender: sender, tocnoIliNe: trueIliFalse)
    }
    
    @IBAction func buttonOdgovorTwoIsPressed(_ sender: UIButton) {
        // Animate imageTocnoIliNe zoom out ako zavisno od toa dali e tocno ili ne
        brojac += 1
        if brojac <= 1 {
            animateImageTocnoIliNe(odgovorButtonTag: 1, senderZaDaCallFunc: sender)
        }
        // Da vidime dali e tocen i da ima soodvetna pozadina spored toa
        let trueIliFalse = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[1].tocnoIliNe
        changeColorNaOdgovorClickURedIliGreen(sender: sender, tocnoIliNe: trueIliFalse)
    }
    
    @IBAction func buttonOdgovorThreeIsPressed(_ sender: UIButton) {
        // Animate imageTocnoIliNe zoom out ako zavisno od toa dali e tocno ili ne
        brojac += 1
        if brojac <= 1 {
            animateImageTocnoIliNe(odgovorButtonTag: 2, senderZaDaCallFunc: sender)
        }
        // Da vidime dali e tocen i da ima soodvetna pozadina spored toa
        let trueIliFalse = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[2].tocnoIliNe
        changeColorNaOdgovorClickURedIliGreen(sender: sender, tocnoIliNe: trueIliFalse)
    }
    
    
    // MARK: Na click na odogovor proveri dali e tocno ili ne, animate image label i pusti audio
    
    func animateImageTocnoIliNe(odgovorButtonTag: Int, senderZaDaCallFunc: UIButton) {
        imageTocnoIliNe.isHidden = false
        
        if Nivo3GlobalStruct.nivo3Objects[tag].odgovori[odgovorButtonTag].tocnoIliNe == true {
            imageTocnoIliNe.image = UIImage(named: "Точен одговор")
            senderZaDaCallFunc.playAudio(audioName: "точен одговор")
        } else {
            imageTocnoIliNe.image = UIImage(named: "Погрешен одговор")!
            senderZaDaCallFunc.playAudio(audioName: "погрешен одговор")
        }
        if imageTocnoIliNe.frame.width != 240 {
            self.imageTocnoIliNe.frame.size.width -= 30
            self.imageTocnoIliNe.frame.size.height -= 30
        }
        
        UIView.animate(withDuration: 2, animations: {
            self.imageTocnoIliNe.frame.size.width += 30
            self.imageTocnoIliNe.frame.size.height += 30
        })
    }
    
    // MARK: Change bg color kaa ce click na odgovor
    
    func changeColorNaOdgovorClickURedIliGreen(sender: UIButton, tocnoIliNe: Bool) {
        
        // Add bg color na odgovor kopce so e kliknato
        
        UIView.animate(withDuration: 1.5) {
            sender.backgroundColor = tocnoIliNe == true ?  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.8159999847, green: 0.00800000038, blue: 0.1059999987, alpha: 1)
        }
        
        // Se oddeluvat tia buttons Odgovori so ne se kliknati i se add bg color na niv so animation
        
        let buttonsOdgovori = [buttonOdgovor1, buttonOdgovor2, buttonOdgovor3]
        let buttonsOdgovoriSoNeSeKliknati = buttonsOdgovori.filter({ $0?.tag != sender.tag })
        
        for button in buttonsOdgovoriSoNeSeKliknati {
            
            UIView.animate(withDuration: 1.5, animations: {
                button?.backgroundColor = Nivo3GlobalStruct.nivo3Objects[self.tag].odgovori[button!.tag].tocnoIliNe == true ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.8159999847, green: 0.00800000038, blue: 0.1059999987, alpha: 1)
            })
        }
    }
    
    // MARK: Buttons audio na odgovori are pressed
    
    @IBAction func buttonAudioOneIsPressed(_ sender: UIButton) {
        
        let audioNameClickedOdgovor = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[0].audioName
        sender.playAudio(audioName: audioNameClickedOdgovor)
        sender.runPulseAnimation()
    }
    
    @IBAction func buttonAudioTwoIsPressed(_ sender: UIButton) {
        
        let audioNameClickedOdgovor = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[1].audioName
        sender.playAudio(audioName: audioNameClickedOdgovor)
        sender.runPulseAnimation()
    }
    
    @IBAction func buttonAudioThreeIsPressed(_ sender: UIButton) {
        
        let audioNameClickedOdgovor = Nivo3GlobalStruct.nivo3Objects[tag].odgovori[2].audioName
        sender.playAudio(audioName: audioNameClickedOdgovor)
        sender.runPulseAnimation()
    }
    
    // MARK: Setup corner radius on odgovor buttons
    fileprivate func setupRounderBordersAnd2LinesOnButtons() {
        
        buttonImagePrasanje.titleLabel?.numberOfLines = 0
        buttonOdgovor1.titleLabel?.numberOfLines = 0
        buttonOdgovor2.titleLabel?.numberOfLines = 0
        buttonOdgovor3.titleLabel?.numberOfLines = 0
        
        buttonImagePrasanje.layer.cornerRadius = 12
        buttonOdgovor1.layer.cornerRadius = 15
        buttonOdgovor2.layer.cornerRadius = 15
        buttonOdgovor3.layer.cornerRadius = 15
    }
    // MARK: Setup spacing for different devices
    
    fileprivate func setupSpacingForDifferentDevices() {
        
        switch UIDevice.current.screenType.rawValue {
            
        case "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8":
            odgovoriStackView.spacing = 30
        case "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus":
            odgovoriStackView.spacing = 40
        case "iPhone X":
            odgovoriStackView.spacing = 40
        default:
            odgovoriStackView.spacing = 20
        }
    }

}







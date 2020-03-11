import UIKit
import AVFoundation

class CategoriiTableController: UITableViewController {
    
    var audioPlayer: AVAudioPlayer!
    var categorii = ["Животни", "Секојдневни работи", "Храна"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Категории"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "categoriiPozadina"))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorii.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorijaCell", for: indexPath) as! CategorijaTableViewCell
        
        cell.labelCategorijaIme.text = categorii[indexPath.row]
        cell.buttonAudio.tag = indexPath.row 

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: Site nizi od objects
    
    var sekojdnevniRabotiObjects: [Nivo1Object] = [
        Nivo1Object(objectName: "биро", image: UIImage(named: "биро")!, audioName: "биро"),
        Nivo1Object(objectName: "книга", image: UIImage(named: "книга")!, audioName: "книга"),
        Nivo1Object(objectName: "пенкало", image: UIImage(named: "пенкало")!, audioName: "пенкало"),
        Nivo1Object(objectName: "маса", image: UIImage(named: "маса")!, audioName: "маса"),
        Nivo1Object(objectName: "молив", image: UIImage(named: "молив")!, audioName: "молив"),
        Nivo1Object(objectName: "ранец", image: UIImage(named: "ранец")!, audioName: "ранец"),
        Nivo1Object(objectName: "стол", image: UIImage(named: "стол")!, audioName: "стол"),
        Nivo1Object(objectName: "чаша", image: UIImage(named: "чаша")!, audioName: "чаша")
    ]
    
    var zivotniObjects: [Nivo1Object] = [
        Nivo1Object(objectName: "лав", image: UIImage(named: "лав")!, audioName: "лав"),
        Nivo1Object(objectName: "зајак", image: UIImage(named: "зајак")!, audioName: "зајак"),
        Nivo1Object(objectName: "желка", image: UIImage(named: "желка")!, audioName: "желка"),
        Nivo1Object(objectName: "куче", image: UIImage(named: "куче")!, audioName: "куче"),
        Nivo1Object(objectName: "слон", image: UIImage(named: "слон")!, audioName: "слон"),
        Nivo1Object(objectName: "волк", image: UIImage(named: "волк")!, audioName: "волк"),
        Nivo1Object(objectName: "слон", image: UIImage(named: "слон")!, audioName: "слон"),
        Nivo1Object(objectName: "мачка", image: UIImage(named: "мачка")!, audioName: "мачка")
    ]
    
    var hranaObjects: [Nivo1Object] = [
        Nivo1Object(objectName: "круша", image: UIImage(named: "круша")!, audioName: "круша"),
        Nivo1Object(objectName: "киви", image: UIImage(named: "киви")!, audioName: "киви"),
        Nivo1Object(objectName: "јајце", image: UIImage(named: "јајце")!, audioName: "јајце"),
        Nivo1Object(objectName: "леб", image: UIImage(named: "леб")!, audioName: "леб"),
        Nivo1Object(objectName: "лимон", image: UIImage(named: "лимон")!, audioName: "лимон"),
        Nivo1Object(objectName: "пица", image: UIImage(named: "пица")!, audioName: "пица"),
        Nivo1Object(objectName: "помфрит", image: UIImage(named: "помфрит")!, audioName: "помфрит"),
        Nivo1Object(objectName: "сендвич", image: UIImage(named: "сендвич")!, audioName: "сендвич")
    ]
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedCategoryCell = sender as? CategorijaTableViewCell else {
            fatalError("sender in not selectedCategoryCell")
        }
        // Zavisno od toa so kje odbere se menja globalObjets u collectionCell i CollectionVC

        switch selectedCategoryCell.labelCategorijaIme.text {

        case "Животни"?:
            GlobalStuff.globalObjects = zivotniObjects
        case "Секојдневни работи"?:
            GlobalStuff.globalObjects = sekojdnevniRabotiObjects
        case "Храна"?:
            GlobalStuff.globalObjects = hranaObjects
        default:
            break
        }
    }
    
    // MARK: Audio za categorii
    
    @IBAction func buttonAudioZaCategorii(_ sender: UIButton) {
        print("sender.tag = ", sender.tag)
        
        switch sender.tag {
        case 0:
            playAudio(audioName: "животни")  // nema vakvo audio
            sender.runPulseAnimation()
        case 1:
            playAudio(audioName: "секојдневни работи") // nema vakvo audio
            sender.runPulseAnimation()
        case 2:
            playAudio(audioName: "храна") // nema vakvo audio
            sender.runPulseAnimation()
        default:
            print("default")
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
    
}
















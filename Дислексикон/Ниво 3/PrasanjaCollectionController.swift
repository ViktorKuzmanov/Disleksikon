import UIKit

struct Nivo3GlobalStruct {
    
    static var nivo3Objects: [Nivo3] = [
        
        Nivo3(audioNamePrasanje: "Што бараше лисицата?",
              odgovori: [
                Odgovor(tekst: "Храна" , audioName: "а", tocnoIliNe: true),
                Odgovor(tekst: "Вода", audioName: "б", tocnoIliNe: false),
                Odgovor(tekst: "Засолниште", audioName: "в", tocnoIliNe: false)
            ]),
        
        Nivo3(audioNamePrasanje: "Што виде лисицата?", odgovori: [
            Odgovor(tekst: "Лозје", audioName: "г", tocnoIliNe: true),
            Odgovor(tekst: "Куќа", audioName: "д", tocnoIliNe: false),
            Odgovor(tekst: "Зграда", audioName: "ѓ", tocnoIliNe: false)
            ]),
        
        Nivo3(audioNamePrasanje: "Каде отиде лисицата?", odgovori: [
            Odgovor(tekst: "Во паркот", audioName: "г", tocnoIliNe: false),
            Odgovor(tekst: "На лозјето", audioName: "д", tocnoIliNe: true),
            Odgovor(tekst: "Во куќата", audioName: "ѓ", tocnoIliNe: false)
            ]),
        
        Nivo3(audioNamePrasanje: "Зошто не го достигна грозјето?", odgovori: [
            Odgovor(tekst: "Не се обиде", audioName: "г", tocnoIliNe: false),
            Odgovor(tekst: "Беше изморена", audioName: "д", tocnoIliNe: false),
            Odgovor(tekst: "Грозјето беше високо", audioName: "ѓ", tocnoIliNe: true)
            ]),
        
        Nivo3(audioNamePrasanje: "Зошто таа си замина?", odgovori: [
            Odgovor(tekst: "Имаше работа", audioName: "г", tocnoIliNe: false),
            Odgovor(tekst: "Ја повика волкот", audioName: "д", tocnoIliNe: false),
            Odgovor(tekst: "Не можеше да го достигне грозјето", audioName: "ѓ", tocnoIliNe: true)
            ])
    ]
}

class PrasanjaCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.isPagingEnabled = true
        setupBottomControls()
        
        // Register cell classes
        collectionView?.register(UINib.init(nibName: "PrasanjeCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "prasanjeCell")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Nivo3GlobalStruct.nivo3Objects.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prasanjeCell", for: indexPath) as! PrasanjeCollectionViewCell
        
        let currentObject = Nivo3GlobalStruct.nivo3Objects[indexPath.row]
        
        cell.buttonImagePrasanje.setTitle(currentObject.audioNamePrasanje, for: .normal)
        cell.buttonOdgovor1.setTitle(currentObject.odgovori[0].tekst, for: .normal)
        cell.buttonOdgovor2.setTitle(currentObject.odgovori[1].tekst, for: .normal)
        cell.buttonOdgovor3.setTitle(currentObject.odgovori[2].tekst, for: .normal)
        
        // Add tags za da znam posle u collection view cell file za change bg color func
        cell.buttonOdgovor1.tag = 0
        cell.buttonOdgovor2.tag = 1
        cell.buttonOdgovor3.tag = 2
        
        let plavaBG = UIImageView(image: UIImage(named: "plavaBGNivo3"))
        let zelenaBG = UIImageView(image: UIImage(named: "zelenaBgNivo3"))
        
        cell.backgroundView = indexPath.row % 2 == 0 ? plavaBG : zelenaBG
        
        cell.buttonOdgovor1.backgroundColor = #colorLiteral(red: 0.37904495, green: 0.6140075326, blue: 0.8548992276, alpha: 1)
        cell.buttonOdgovor2.backgroundColor = #colorLiteral(red: 0.37904495, green: 0.6140075326, blue: 0.8548992276, alpha: 1)
        cell.buttonOdgovor3.backgroundColor = #colorLiteral(red: 0.37904495, green: 0.6140075326, blue: 0.8548992276, alpha: 1)
        cell.brojac = 0
        
        cell.imageTocnoIliNe.isHidden = true 
        
        cell.tag = indexPath.row 
    
        return cell
    }
    
    // MARK: Collection view cell size same as view
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // MARK: Make 0 spacing between cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Setup Buttom controls code
    
    @objc private func handleNext() {
        
        let nextIndex = min(pageControl.currentPage + 1, Nivo3GlobalStruct.nivo3Objects.count - 1)
        // ako slednata page e poslednata (predposledna = pages.count - 2) togi na slednata DONE da ima
        if pageControl.currentPage == Nivo3GlobalStruct.nivo3Objects.count - 2 {
            //            buttonNext.setTitle("КРАЈ", for: .normal)
            buttonNext.addTarget(self, action: #selector(cancelWalkthroughtController), for: .touchUpInside) // na fishish kopceto mu daame action da ispadne
        }
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        if nextIndex == 1 {
            buttonPrevious.removeTarget(nil, action: nil, for: .allEvents)
            //            buttonPrevious.setTitle("ПРЕД", for: .normal)
            buttonPrevious.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        }
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func cancelWalkthroughtController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePrevious() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        if pageControl.currentPage == Nivo3GlobalStruct.nivo3Objects.count - 1 {
            buttonNext.removeTarget(self, action: #selector(cancelWalkthroughtController), for: .touchUpInside)
            //            buttonNext.setTitle("СЛЕДНО", for: .normal)
        }
        pageControl.currentPage = nextIndex
        if nextIndex == 0 {
            //            buttonPrevious.setTitle("BACK", for: .normal)
            buttonPrevious.addTarget(self, action: #selector(cancelWalkthroughtController), for: .touchUpInside)
        }
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let buttonNext: UIButton = {
        let button = UIButton(type: .system)
        
        button.imageView?.contentMode = .scaleAspectFit
        let buttonImage = UIImage(named: "next2")
        button.setImage(buttonImage, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false // enable autolayout constraints
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private let buttonPrevious: UIButton = {
        let button = UIButton(type: .system)
        
        button.imageView?.contentMode = .scaleAspectFit
        let buttonImage = UIImage(named: "back2")
        button.setImage(buttonImage, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(cancelWalkthroughtController), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = Nivo3GlobalStruct.nivo3Objects.count
        pc.currentPageIndicatorTintColor = .blue
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.37904495, green: 0.6140075326, blue: 0.8548992276, alpha: 0.6549999714)
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        
        let stackViewBottomConstrols = UIStackView(arrangedSubviews: [buttonPrevious,pageControl,buttonNext])
        stackViewBottomConstrols.translatesAutoresizingMaskIntoConstraints = false
        stackViewBottomConstrols.distribution = .fillEqually
        view.addSubview(stackViewBottomConstrols)
        
        stackViewBottomConstrols.heightAnchor.constraint(equalToConstant: 50)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                stackViewBottomConstrols.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                stackViewBottomConstrols.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                stackViewBottomConstrols.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                ])
        } else {
            NSLayoutConstraint.activate([
                stackViewBottomConstrols.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
                stackViewBottomConstrols.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stackViewBottomConstrols.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
        }
    }

}

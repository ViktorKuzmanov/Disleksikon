import UIKit

struct GlobalStuff {
    
    static var globalObjects: [Nivo1Object] = []
}

class SlikoZborCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        collectionView?.isPagingEnabled = true
        collectionView?.register(UINib.init(nibName: "SlikoZborCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "slikoZborCell")
        
        setupBottomControls()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalStuff.globalObjects.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slikoZborCell", for: indexPath) as! SlikoZborCollectionViewCell
        
        cell.imageNaObject.image = GlobalStuff.globalObjects[indexPath.row].image

        cell.buttonAudio.tag = indexPath.row
        cell.buttonGotovo.tag = indexPath.row
        cell.tag = indexPath.row
        cell.buttonHint.tag = indexPath.row
        cell.textFieldZaObject.tag = indexPath.row
        
        cell.imageZaProverka.isHidden = true
        cell.buttonZaProverka.isHidden = true
        cell.textFieldZaObject.text = ""
        
        let prvaPozadina = UIColor(patternImage: UIImage(named: "Nijansa 1")!)
        let vtoraPozadina = UIColor(patternImage: UIImage(named: "Nijansa 2")!)
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? prvaPozadina : vtoraPozadina
        
        cell.brojac = 0
        
        
        // Za constraints na hint i prasalnik button da bidat pogolemi kaa userot ima iPhone X
        switch UIDevice.current.screenType.rawValue {
            
        case "iPhone X":
            cell.constraintHintBtnOnBottom.constant = 100
            cell.constraintPrasalnikBtnBottom.constant = 100
            
        default:
            cell.constraintHintBtnOnBottom.constant = 65
            cell.constraintPrasalnikBtnBottom.constant = 65
            
        }
    
        return cell
    }

    // MARK: Full size i da nema spacing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // MARK: Other functions
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, GlobalStuff.globalObjects.count - 1)
        // ako slednata page e poslednata (predposledna = pages.count - 2) togi na slednata DONE da ima
        if pageControl.currentPage == GlobalStuff.globalObjects.count - 2 {
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
        if pageControl.currentPage == GlobalStuff.globalObjects.count - 1 {
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
        pc.numberOfPages = GlobalStuff.globalObjects.count
        pc.currentPageIndicatorTintColor =  UIColor(red: 0.324044615, green: 0.4596852064, blue: 0.6928163171, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 0.5667652965, green: 0.8475571871, blue: 0.9928130507, alpha: 1)
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
    
    
    // MARK: Za Keyboard bug demek pomaga
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let newYOrigin = CGFloat(1) // or whatever new value you want
            self.collectionView?.frame.origin.y = newYOrigin
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let newYOrigin = CGFloat(0) // or whatever new value you want
            self.collectionView?.frame.origin.y = newYOrigin
        }
    }

}



// MARK: Za Keyboard bug demek pomaga

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//            let newYOrigin = CGFloat(1) // or whatever new value you want
//            self.collectionView?.frame.origin.y = newYOrigin
//        }
//
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//            let newYOrigin = CGFloat(0) // or whatever new value you want
//            self.collectionView?.frame.origin.y = newYOrigin
//        }
//    }


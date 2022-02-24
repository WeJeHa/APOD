//
//  ViewController.swift
//  APOD
//
//  Created by William Johanssen Hutama on 24/02/22.
//

import UIKit

class HomeViewController: UIViewController {
//MARK: Outlets
    @IBOutlet weak var viewApodButton: UIButton!
    @IBOutlet weak var randomApodButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
//MARK: Private funcs
    private func initUI(){
        //Forece dark mode
        overrideUserInterfaceStyle = .dark
        
        //Navbar
        title = "Welcome 🪐"
        
        let appearance = UINavigationBarAppearance()
        //appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = UIColor.systemBlue
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance;
        
        //Label
        let text = "Hello"
        let labelAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20)
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: labelAttributes)
        
        welcomeLabel.textAlignment = .center
        welcomeLabel.attributedText = attributedString
        
        //Buttons
        var mainButtonConfig = UIButton.Configuration.filled()
        mainButtonConfig.title = "View Latest Pictures"
        mainButtonConfig.image = UIImage(systemName: "sparkles",
          withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        mainButtonConfig.imagePlacement = .trailing
        mainButtonConfig.imagePadding = 5.0
        mainButtonConfig.buttonSize = .large
        viewApodButton.configuration = mainButtonConfig
        
        var secondButtonConfig = UIButton.Configuration.tinted()
        secondButtonConfig.title = "Surprise Me!"
        secondButtonConfig.subtitle = "Show Random Picture"
        secondButtonConfig.baseForegroundColor = .white
        secondButtonConfig.titleAlignment = .center
        randomApodButton.configuration = secondButtonConfig
    }
    
//MARK: Button Actions
    @IBAction func showApod(_ sender: Any) {
    }
    
    @IBAction func randomApod(_ sender: Any) {
    }
}


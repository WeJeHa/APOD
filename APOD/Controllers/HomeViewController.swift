//
//  ViewController.swift
//  APOD
//
//  Created by William Johanssen Hutama on 24/02/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
//MARK: Outlets
    @IBOutlet weak var viewApodButton: UIButton!
    @IBOutlet weak var randomApodButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
//MARK: Viewmodel connection
    let ViewModel = HomeViewModel()
    
//MARK: Variables
    var welcomeText: String = "checking date.."
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        ViewModel.getTime()
        
        //MARK: Subscription
        ViewModel._clock.subscribe{ event in
            self.timeLabel.text = event
        }
        
        ViewModel._date.subscribe{ event in
            self.updateTimeLabel(date: event.element ?? "")
        }.disposed(by: DisposeBag())
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
        let labelAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18)
        ]
        
        let attributedString = NSAttributedString(string: welcomeText, attributes: labelAttributes)
        
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
    
    private func updateTimeLabel(date: String){
        welcomeLabel.text = "Astronomy Picture Of the Day\n\nServer Time:\n\(date)"
    }
    
//MARK: Button Actions
    @IBAction func showApod(_ sender: Any) {
    }
    
    @IBAction func randomApod(_ sender: Any) {
    }
}


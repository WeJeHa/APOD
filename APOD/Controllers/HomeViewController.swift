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
    let VM = ApodListViewModel()
    
//MARK: Variables
    var welcomeText: String = "checking date.."
    var clockTimer: Timer?
    var buttonPressed: Bool = false
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        startTimer()
        
        //MARK: Subscription
        VM._pictures.subscribe{ event in
            if self.buttonPressed == true{
                self.attemptShowApod(status: true)
            }
        }
    }
    
//MARK: Private funcs
    private func initUI(){
        //Forece dark mode
        overrideUserInterfaceStyle = .dark
        
        //Navbar
        title = "Welcome 🪐"
        
        let appearance = UINavigationBarAppearance()
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
        timeLabel.text = ""
        
        //Buttons
        switchButtons(bool: false)
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
    
    private func switchButtons(bool: Bool){
        viewApodButton.isEnabled = bool
        randomApodButton.isEnabled = bool
    }
    
    private func startTimer(){
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(updateTime) , userInfo: nil, repeats: true)
    }
    
    private func stopTimer(){
        if clockTimer != nil {
            clockTimer!.invalidate()
            clockTimer = nil
          }
    }
        
    @objc private func updateTime(){
        //Format the date
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        
        //Get day, year-month-day
        dateFormatter.dateFormat = "EEEE, yyyy-MM-dd"
        var FormattedDate = dateFormatter.string(from: currentDate)
        welcomeLabel.text = "Astronomy Picture Of the Day\n\nServer Time:\n\(FormattedDate)"
        
        //Get hour:minute:second am/pm
        dateFormatter.dateFormat = "hh:mm:ss a"
        FormattedDate = dateFormatter.string(from: currentDate)
        timeLabel.text = "\(FormattedDate)"
        switchButtons(bool: true)
    }
    
    
//MARK: Button Actions
    @IBAction func showApod(_ sender: Any) {
        buttonPressed = true
        VM.getListOfPictures(date: Date(), numOfData: 4)
        attemptShowApod(status: false)
    }
    
    @IBAction func randomApod(_ sender: Any) {
        buttonPressed = true
    }
    
//MARK: Navigation
    private func attemptShowApod(status: Bool){
        switch status{
            case false:
                var buttonConfig = UIButton.Configuration.filled()
                buttonConfig.title = "View Latest Pictures"
                buttonConfig.buttonSize = .large
                buttonConfig.showsActivityIndicator = true
                buttonConfig.imagePadding = 5.0
                buttonConfig.imagePlacement = .trailing
                viewApodButton.configuration = buttonConfig
            
            case true:
                let destinationStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let VC = destinationStoryBoard.instantiateViewController(withIdentifier: "listOfApodVC") as! ApodListViewController
                navigationController?.pushViewController(VC, animated: true)
        }
    }
}

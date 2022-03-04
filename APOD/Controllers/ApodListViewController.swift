//
//  ApodListViewController.swift
//  APOD
//
//  Created by William Johanssen Hutama on 01/03/22.
//

import UIKit
import RxSwift

class ApodListViewController: UIViewController, UITableViewDataSource {
//MARK: Outlets
    @IBOutlet weak var apodTableView: UITableView!

//MARK: ViewModel
    let VM = ApodListViewModel()
    
//MARK: VAriables
    var apodData: [Picture]?
    
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        apodTableView.dataSource = self
        initUI()
        VM.getListOfPictures()
        
        VM._picture.subscribe{ event in
            let pictures: [Picture] = event.element ?? []
            self.apodData = pictures
            self.apodTableView.reloadData()
        }
    }
//MARK: Private funcs
    private func initUI(){
        //Forece dark mode
        overrideUserInterfaceStyle = .dark
        
    }
    
//MARK: Tableview funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if apodData == nil{
            return 0
        }else{
            return apodData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Declare reuseable tableview cell
        let apodCell = apodTableView.dequeueReusableCell(withIdentifier: "apodCell", for: indexPath) as! ApodTableViewCell
        apodCell.ApodCellImage.layer.cornerRadius = 20.0
        //Prep data
        let apod = apodData?[indexPath.row]
        
        //Image
        if apod?.media_type == "video"{
            apodCell.ApodCellImage.loadFrom(URLAddress: apod?.thumbnail_url ?? "")
        }else{
            apodCell.ApodCellImage.loadFrom(URLAddress: apod?.url ?? "")
        }
        
        //Title
        apodCell.ApodCellLabel.text = apod?.title
        
        return apodCell
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

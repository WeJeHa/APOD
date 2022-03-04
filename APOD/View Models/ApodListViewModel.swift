//
//  ApodListViewModel.swift
//  APOD
//
//  Created by William Johanssen Hutama on 01/03/22.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class ApodListViewModel{
//MARK: RxSwift
    var _pictures: BehaviorRelay<[Picture]> = BehaviorRelay(value: [])
    var pictures: Observable<[Picture]>{
        _pictures.asObservable()
    }
    
    @objc func setPictures(){
        _pictures.accept(listOfPictures ?? [])
    }
    
//MARK: Variables
    var listOfPictures: [Picture]?
    
//MARK: Function
    func getListOfPictures(date: Date, numOfData: Int){
        //Formats date for usage
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let endDate = dateFormatter.string(from: date)
        
        let substractDate = Calendar.current.date(byAdding: .day, value: -numOfData, to: Date())
        let startDate = dateFormatter.string(from: substractDate!)
        
        //Send API
        let parameters: Parameters = [
            "api_key": "59bM6fCewjFLCh7mZcTDA8PmfbNnOc3yc7n2DjOk"
            ,"start_date": startDate
            ,"end_date": endDate
            ,"thumbs": "true"
        ]
        let baseUrl = "https://api.nasa.gov/"
        let path = "planetary/apod"
        
        let urlToSend = baseUrl + path
        
        AF.request(urlToSend, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseDecodable(of: Picture.self) { response in
            guard let data = response.data else  {return}
                
            do{
                self.listOfPictures = try JSONDecoder().decode([Picture].self, from: data)
            }
            catch{
                print(error)
            }
            self.listOfPictures?.reverse()
            self.setPictures()
        }
    }
    /*
    func getRandomPicture(){
        let parameters: Parameters = [
            "api_key": "59bM6fCewjFLCh7mZcTDA8PmfbNnOc3yc7n2DjOk"
            ,"count": 1
            ,"thumbs": "true"
        ]
        let baseUrl = "https://api.nasa.gov/"
        let path = "planetary/apod"
        
        let urlToSend = baseUrl + path
        
        AF.request(urlToSend, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseDecodable(of: Picture.self) { response in
            
            guard let data = response.data else  {return}
                
            do{
                self.picture = try JSONDecoder().decode(Picture.self, from: data)
            }
            catch{
                print(error)
            }
        }
    }
    */
}

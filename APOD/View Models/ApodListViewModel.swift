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
    var _picture: BehaviorRelay<[Picture]> = BehaviorRelay(value: [])
    var picture: Observable<[Picture]>{
        _picture.asObservable()
    }
    
    @objc func setPicture(){
        _picture.accept(listOfPictures ?? [])
    }
    
//MARK: Function
    var listOfPictures: [Picture]?
    
    func getListOfPictures(){
        let parameters: Parameters = [
            "api_key": "59bM6fCewjFLCh7mZcTDA8PmfbNnOc3yc7n2DjOk"
            ,"count": 5
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
            self.setPicture()
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

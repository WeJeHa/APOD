//
//  HomeViewModel.swift
//  APOD
//
//  Created by William Johanssen Hutama on 24/02/22.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel{
//MARK: Observables
    //Clock, hour:minute:second in string
    var _clock: BehaviorRelay<String> = BehaviorRelay(value: "")
    var clock: Observable<String>{
        _clock.asObservable()
    }
    @objc func setClock(){
        _clock.accept(clockEST)
    }
    
    //Date, year:month:day in string
    var _date: BehaviorRelay<String> = BehaviorRelay(value: "")
    var date: Observable<String>{
        _date.asObservable()
    }
    @objc func setDate(){
        _date.accept(dateEST)
    }
    
//MARK: Variables
    var clockEST: String = ""
    var dateEST: String = ""
    
//MARK: Functions
    @objc func getTime(){
        //Calls itself every second (TO FIX: updating every second consumes too much RAM, need to dispose accordingly)
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector:#selector(self.getTime) , userInfo: nil, repeats: true)
        
        //Format the date
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "EEEE, yyyy-MM-dd"
        
        //Get day, year-month-day
        var FormattedDate = dateFormatter.string(from: currentDate)
        dateEST = FormattedDate
        setDate()
        
        //Get hour:minute:second am/pm
        dateFormatter.dateFormat = "hh:mm a"
        FormattedDate = dateFormatter.string(from: currentDate)
        clockEST = FormattedDate
        setClock()
    }
}

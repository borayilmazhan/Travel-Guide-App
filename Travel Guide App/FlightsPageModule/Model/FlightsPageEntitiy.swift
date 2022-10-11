//
//  FlightsPageEntitiy.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation



class FlightsPageCellViewModel {
        var departure: Departure?
        var arrival: Arrival?
        var airline: Airline?
        var flight: Flight?
    
    init (_ departure: Departure?, _ arrival: Arrival?, _ airline: Airline?, _ flight: Flight?) {
        self.departure = departure
        self.arrival = arrival
        self.airline = airline
        self.flight = flight
}
}

struct Flights: Codable {
//    var id: String{
//        get{
//            return flight?.number ?? ""
//        }
//    }
//    var type: String
    
    var departure: Departure?
    var arrival: Arrival?
    var airline: Airline?
    var flight: Flight?
    
    
}

struct Departure: Codable{
  
    var airport: String?
    var timezone: String?
    var iata: String?
    var icao: String?
    var terminal: String?
    var time :String?
}

struct Arrival: Codable {
    
    var airport: String?
    var timezone: String?
    var iata: String?
    var icao: String?
    var termina: String?
    var time: String?
    
}
struct Airline: Codable {
    var name: String?
    var callsign: String?
    var iata: String?
    var icao: String?
}
struct Flight: Codable {
    var number: String?
}


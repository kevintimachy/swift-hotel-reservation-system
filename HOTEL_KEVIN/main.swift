//
//  main.swift
//  HOTEL_KEVIN
//
//  Created by Kevin Timachy on 2024-09-18.
//

import Foundation

class Customer: CustomStringConvertible {
    let name: String
    var email: String {
        get {
            return "\(name)@gmail.com".lowercased()
        }
    }
    let city: String
    let creditCard: Int?
    var description: String {
        return "Name: \(name)\nCity: \(city)\nEmail: \(email)\n\(creditCard == nil ? "No credit card provided." : "Credit Card: \(creditCard!)")"

    }
    
    init(name: String, city: String, creditCard: Int) {
        self.name = name
        self.city = city
        self.creditCard = creditCard
    }
    init(name: String, city: String) {
        self.name = name
        self.city = city
        self.creditCard = nil
    }
}


class RoomReservation {
    let customer: Customer
    let dailyRate: Double
    let numDays: Int
    var taxRate: Double {
        return customer.city == "New York City" ? 5.875 : 2.0
    }
    var roomCost: Double {
        return Double(numDays) * dailyRate
    }
    var occupancyTax: Double{
        return (roomCost * taxRate)/100
    }
    var total: Double {
        return roomCost + occupancyTax
    }
    
    init(customer: Customer, dailyRate: Double, numberOfDays: Int){
        self.customer = customer
        self.dailyRate = dailyRate
        self.numDays = numberOfDays
       
    }
    
    func printInvoice() {
        print("===================\n===== INVOICE =====\n===================")
        print("---Customer Details---")
        print(self.customer)
        print("---Room Details---")
        print("Daily Rate: $\(self.dailyRate)\nLength of stay: \(self.numDays) day(s)\nSubtotal: $\(self.roomCost)\nTax (\(self.taxRate)%): $\(self.occupancyTax)\nTotal: $\(total)")
    }
}

class ConferenceRoomReservation : RoomReservation {
    let eventName: String
    let numAttendees: Int
    let additionalServices: [String:Double]?
    override var total: Double {
        return super.roomCost + super.occupancyTax
    }
}


let c1:Customer = Customer(name: "Kevin", city: "New York City", creditCard: 1001)
let c2:Customer = Customer(name: "Claudia", city: "Toronto")

let r1:RoomReservation = RoomReservation(customer: c2, dailyRate: 341.5, numberOfDays: 3)
r1.printInvoice()

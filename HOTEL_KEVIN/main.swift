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
        get {
            return "Name: \(name)\nCity: \(city)\nEmail: \(email)\n\(creditCard == nil ? "No credit card provided." : "Credit Card: \(creditCard!)")"
        }

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
        get {
            return customer.city == "New York City" ? 5.875 : 2.0
        }
    }
    var roomCost: Double {
        get {
            return Double(numDays) * dailyRate
        }
    }
    var occupancyTax: Double{
        get {
            return (roomCost * taxRate)/100
        }
    }
    var total: Double {
        get {
            return roomCost + occupancyTax
        }
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
    var additionalServices: [String:Double]?
    override var total: Double {
        get {
            var costServices: Double = 0
            if let services = additionalServices {
                for cost in services.values {
                    costServices += cost
                }
            }
            return super.roomCost + super.occupancyTax + costServices
        }
    }
    
    init(eventName: String, numAttendees: Int, additionalServices: [String : Double]? , customer: Customer, numberOfDays: Int) {
        self.eventName = eventName
        self.numAttendees = numAttendees
        self.additionalServices = additionalServices
        super.init(customer: customer, dailyRate: 105 * Double(numAttendees), numberOfDays: numberOfDays)
    }
    func addService(serviceName: String, cost: Double) {
        if (additionalServices?[serviceName]) != nil {
            return
        }
        else {
            additionalServices?[serviceName] = cost
        }
    }
    override func printInvoice() {
        print("===================\n===== INVOICE =====\n===================")
        print("---Customer Details---")
        print(super.customer)
        print("---Event Details---")
        print("Event Name: \(self.eventName)\nLength: \(super.numDays) day(s)\nAttendees: $\(self.numAttendees)\nOccupancy Tax (\(super.taxRate)%): $\(self.occupancyTax)")
        if let services = additionalServices{
            for (service, cost) in services {
                print(" + \(service): $\(cost)")
            }
        }
        print("Total: $\(self.total)")
    }
}








let c1:Customer = Customer(name: "Kevin", city: "New York City", creditCard: 1001)
let c2:Customer = Customer(name: "Claudia", city: "Toronto")

let r1:RoomReservation = RoomReservation(
    customer: c2,
    dailyRate: 341.5,
    numberOfDays: 3
)

r1.printInvoice()

let r2: ConferenceRoomReservation = ConferenceRoomReservation(
    eventName: "Toronto Codes",
    numAttendees: 35,
    additionalServices:
        ["Catering": 1375.99, "A/V Equipment": 250.0, "Printing Services": 80.5],
    customer: c1,
    numberOfDays: 2
)

r2.printInvoice()

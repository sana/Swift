//
//  Factory.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Intent: define an interface for creating an object, but let subclasses decide
 which class to instantiate. The Factory Method lets a class defer instantiation
 to subclasses.
 */

protocol Currency : CustomStringConvertible { }

protocol Country {
    func currency() -> Currency
}

protocol CountryFactory {
    func createRandomCountry() -> Country
}

// MARK :- Currency

class Euro : Currency {
    var description: String {
        return "euro"
    }
}

class USDollar : Currency {
    var description: String {
        return "usd"
    }
}

// MARK :- Country

class Romania : Country {
    func currency() -> Currency {
        return Euro()
    }
}

class US : Country {
    func currency() -> Currency {
        return USDollar()
    }
}

// MARK :- CountryFactory

class EuroCountryFactory : CountryFactory {
    func createRandomCountry() -> Country {
        return Romania()
    }
}

class USDollarCountryFactory : CountryFactory {
    func createRandomCountry() -> Country {
        return US()
    }
}

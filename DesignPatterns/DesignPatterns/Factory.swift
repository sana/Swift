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
 which class to instantiate. Factory Method lets a class defer instantiation to
 subclasses.
 */

protocol Currency : PrintableClass { }
protocol Country : PrintableClass {
    func currency() -> Currency
}
extension Country {
    func stringValue() -> String {
        return currency().stringValue()
    }
}

class Euro : Currency {
    func stringValue() -> String {
        return "euro"
    }
}

class USDollar : Currency {
    func stringValue() -> String {
        return "usd"
    }
}

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

protocol CountryFactory {
    func createRandomCountry() -> Country
}

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

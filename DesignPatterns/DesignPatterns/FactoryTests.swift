//
//  FactoryTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class FactoryTests : SampleTest {
    class func getCountryCurrency(factory : CountryFactory) -> Currency {
        let country: Country = factory.createRandomCountry()
        let currency: Currency = country.currency()
        return currency
    }
    
    class func runSamples() {
        print(getCountryCurrency(EuroCountryFactory()))
        print(getCountryCurrency(USDollarCountryFactory()))
    }
}

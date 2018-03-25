//
//  FactoryTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/28/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class FactoryTests: XCTestCase {
    func testEuroCountryFactory() {
        let factory = EuroCountryFactory()
        let currency = factory.countryCurrency()
        XCTAssertEqual(currency.description, "euro")
    }

    func testUSCountryFactory() {
        let factory = USDollarCountryFactory()
        let currency = factory.countryCurrency()
        XCTAssertEqual(currency.description, "usd")
    }
}

extension CountryFactory {
    func countryCurrency() -> Currency {
        let country: Country = self.createRandomCountry()
        let currency: Currency = country.currency()
        return currency
    }
}

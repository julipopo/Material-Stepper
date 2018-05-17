//
//  Data.swift
//  MaterialStepper
//
//  Created by julien on 16/05/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

struct Color {
    static let smoothWhite = UIColor(white: 0.9, alpha: 1)
    static let grey800 = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
}

struct Element {
    let title: String
    var isActivate: Bool
}

struct Section {
    let index: Int
    let title: String
    let elements: [Element]
    
    static func initStatic() -> [Section] {
        let firstSection = Section(index: 0, title: "Checkout", elements: [Element(title: "Passeport", isActivate: true),
                                                                           Element(title: "Visa", isActivate: false),
                                                                           Element(title: "Vaccination", isActivate: false),
                                                                           Element(title: "Prepaid", isActivate: false),
                                                                           Element(title: "ID Card", isActivate: false),
                                                                           Element(title: "Visa Card", isActivate: false),
                                                                           Element(title: "Cash On board", isActivate: false),
                                                                           Element(title: "Bitcoin", isActivate: false),
                                                                           Element(title: "Children", isActivate: false),
                                                                           Element(title: "Suitcase", isActivate: false),
                                                                           Element(title: "Insurance", isActivate: true)])
        let secondSection = Section(index: 1, title: "Seat Selection", elements: [Element(title: "Window", isActivate: false),
                                                                                  Element(title: "Aisle", isActivate: false),
                                                                                  Element(title: "Reclining", isActivate: false),
                                                                                  Element(title: "Leg Space", isActivate: true),
                                                                                  Element(title: "Cover", isActivate: true),
                                                                                  Element(title: "Heated", isActivate: true),
                                                                                  Element(title: "Cleaned", isActivate: false),
                                                                                  Element(title: "Leather", isActivate: false)])
        let thirdSection = Section(index: 2, title: "Services", elements: [Element(title: "TV & Series", isActivate: true),
                                                                           Element(title: "Books and Magazines", isActivate: false),
                                                                           Element(title: "Foods & Drinks", isActivate: false),
                                                                           Element(title: "Massage", isActivate: false),
                                                                           Element(title: "Society games", isActivate: false),
                                                                           Element(title: "Shopping", isActivate: false)])
        return [firstSection, secondSection, thirdSection]
    }
}

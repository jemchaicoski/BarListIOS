//
//  deBarEmBarTests.swift
//  deBarEmBarTests
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//

import XCTest
@testable import deBarEmBar

class deBarEmBarTests: XCTestCase {
//MARK Bar Class Test
    @IBOutlet weak var ImageBar: UIImageView!
    
    //Confirm the Bar initializer returns a correct Bar object with valid parameters
    func testBarInicializationSucceds(){
        //zero rating
        let zeroRatingBar = Bar(nome: "ZeroRating", foto: ImageBar.image!, telefone: "999867273",endereco: "Sua Mãe", coordenadaX: 0.0, coordenadaY: 0.0, rating: 0)
        XCTAssertNotNil(zeroRatingBar)
        
        // Highest positive rating
        let positiveRatingBar = Bar.init(nome: "MaxRating", foto: nil, telefone: "999867273", endereco: "Sua Mãe", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5)
        XCTAssertNotNil(positiveRatingBar)
        
    }
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testBarInitializationFails() {
        // Negative rating
        let negativeRatingBar = Bar.init(nome: "NegativeRating", foto: nil, telefone: "999867273", endereco: "Sua Mãe",coordenadaX: 0.0, coordenadaY: 0.0, rating: -1)
        XCTAssertNil(negativeRatingBar)
        
        // Empty String
        let emptyStringBar = Bar.init(nome: "", foto: nil, telefone: "999867273", endereco: "Sua Mãe", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5)
        XCTAssertNil(emptyStringBar)
        
    }
}


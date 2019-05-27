//
//  ImportantStructures.swift
//  UI-Home Application
//
//  Created by Developer on 22/03/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

struct Person{
    var name : String
    var photo : UIImage
}

class Session {
    static let instance = Session()
    
    private init(){
    }
    
    var token: String = "Not Initialized"
    var userID: Int = 404
    var applicationID: String = "6995401"
    
}


struct FriendData {
    var privateUserData = [
        Person(name: "Rihanna", photo: UIImage(imageLiteralResourceName: "friend1.jpg")),
        Person(name: "Jeff Bezos", photo: UIImage(imageLiteralResourceName: "friend2.jpg")),
        Person(name: "Bill Atkinson", photo: UIImage(imageLiteralResourceName: "friend3.jpg")),
        Person(name: "Steve P. Jobs", photo: UIImage(imageLiteralResourceName: "friend4.jpg")),
        Person(name: "Jane Woodsilgton", photo: UIImage(imageLiteralResourceName: "friend5.jpg")),
        Person(name: "Lisa Jobs", photo: UIImage(imageLiteralResourceName: "friend6.jpg")),
    ]
    
    var publicUserData = [String : [Person]]()
    var tableLitterals = [String]()
    
    private mutating func preparePublicUserData(){
        
        publicUserData.removeAll()
        tableLitterals.removeAll()
        self.privateUserData.sort(by: literalSort(_:_:))
        
        if privateUserData.isEmpty {
            print("Fatal Error. No users Found.")
            tableLitterals.append("Found")
            var noOne = [Person]()
            noOne.append(Person(name: "No users found", photo: UIImage(imageLiteralResourceName: "friend6.jpg")))
            publicUserData.updateValue(noOne, forKey: "Found")
            return
        }
        
        var currentSymbol = privateUserData[0].name.lowercased().first!
        tableLitterals.append(String(currentSymbol))
        var currentSection = [Person]()
        
        for elements in privateUserData {
            if elements.name.lowercased().first! == currentSymbol {
                currentSection.append(elements)
            } else {
                publicUserData.updateValue(currentSection, forKey: String(currentSymbol))
                currentSymbol = elements.name.lowercased().first!
                tableLitterals.append(String(currentSymbol))
                currentSection.removeAll()
                currentSection.append(elements)
            }
        }
        
        if !currentSection.isEmpty {
            tableLitterals.append(String(currentSymbol))
            publicUserData.updateValue(currentSection, forKey: String(currentSymbol))
            currentSection.removeAll()
        }
    }
    
    private func literalSort(_ first: Person, _ second: Person) -> Bool {
        return first.name > second.name ? false : true
    }
    
    public mutating func updataPublicData(){
        self.preparePublicUserData()
    }
    
    public mutating func nilData(){
        self.privateUserData.removeAll()
        self.publicUserData.removeAll()
        self.tableLitterals.removeAll()
    }
    
    init(){
        self.preparePublicUserData()
    }
    
}

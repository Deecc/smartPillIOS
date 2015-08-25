//
//  SmartPillTests.swift
//  SmartPillTests
//
//  Created by Dennis da Silva Nunes on 16/05/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import XCTest
import SmartPill
import CoreData


class SmartPillTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        createMedicines()
        getQuantityOfMedicines(8)
        removeAllMedicines()
        getQuantityOfMedicines(0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func createMedicines(){
        Medicine.createMedicine("Cloridrato de Fexofenadina",availability:"Comprimido",manufacturer:"EMS",name:"Allexofedrin",quantity:NSNumber(integer: 10),recipe:nil,reminder:nil)
        Medicine.createMedicine("Topiramato",availability:"Comprimido",manufacturer:"Eurofarma",name:"Amato",quantity:NSNumber(integer: 12),recipe:nil,reminder:nil)
        Medicine.createMedicine("Ácido Ascórbico",availability:"Efervescente",manufacturer:"Sanofi Aventis",name:"Cewin",quantity:NSNumber(integer: 10),recipe:nil,reminder:nil)
        Medicine.createMedicine("Topiramato",availability:"Comprimido",manufacturer:"Libbs",name:"Égide",quantity:NSNumber(integer: 10),recipe:nil,reminder:nil)
        Medicine.createMedicine("Diazepam",availability:"Comprimido",manufacturer:"Roche",name:"Valium",quantity:NSNumber(integer: 30),recipe:nil,reminder:nil)
        Medicine.createMedicine("Clordiazepóxido + Cloridrato de Amitriptilina",availability:"Capsula",manufacturer:"Valeant",name:"Limbitrol",quantity:NSNumber(integer: 10),recipe:nil,reminder:nil)
        Medicine.createMedicine("Alprazolam",availability:"Comprimido",manufacturer:"Pfizer",name:"Frontal",quantity:NSNumber(integer: 30),recipe:nil,reminder:nil)
        Medicine.createMedicine("Estradiol",availability:"Adesivo Transdérmico",manufacturer:"Janssen",name:"Systen",quantity:NSNumber(integer: 8),recipe:nil,reminder:nil)
    }
    
    func getQuantityOfMedicines(quant:Int){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine]
        XCTAssertEqual(array.count, quant, "Medicine number wrong")
    }
    
    func createMedicinesTaken(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine]
        for med:Medicine in array{
            Medicine_Taken.createTakenMedFromMed(med,today:TimeManager.getStartDayHour())
        }
    }
    
    func getQuantityOfMedicinesTaken(quant:Int){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine_Taken")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        XCTAssertEqual(array.count, quant, "Medicine taken number wrong")
    }
    
    func removeAllMedicines(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine]
        for med:Medicine in array{
            context.deleteObject(med)
        }
    }
    
    func removeAllMedicinesTaken(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine_Taken")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        for med:Medicine_Taken in array{
            context.deleteObject(med)
        }
    }

    
}

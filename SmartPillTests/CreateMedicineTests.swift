//
//  CreateMedicineTests.swift
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 06/07/15.
//  Copyright (c) 2015 Dennis da Silva Nunes. All rights reserved.
//

import UIKit
import XCTest
@testable import SmartPill

class CreateMedicineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //Método chamado antes de qualquer outro
        print("setUp\n")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //Método que vem depois de cada método
        print("tearDown\n")
        super.tearDown()
    }
    
    func createMedicines(){
        Medicine.createMedicine(activeIngredient:"Cloridrato de Fexofenadina",availability:"Comprimido",manufacturer:"EMS",name:"Allexofedrin",quantity:NSNumber(integer: 10)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Topiramato",availability:"Comprimido",manufacturer:"Eurofarma",name:"Amato",quantity:NSNumber(integer: 12)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Ácido Ascórbico",availability:"Efervescente",manufacturer:"Sanofi Aventis",name:"Cewin",quantity:NSNumber(integer: 10)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Topiramato",availability:"Comprimido",manufacturer:"Libbs",name:"Égide",quantity:NSNumber(integer: 10)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Diazepam",availability:"Comprimido",manufacturer:"Roche",name:"Valium",quantity:NSNumber(integer: 30)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Clordiazepóxido + Cloridrato de Amitriptilina",availability:"Capsula",manufacturer:"Valeant",name:"Limbitrol",quantity:NSNumber(integer: 10)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Alprazolam",availability:"Comprimido",manufacturer:"Pfizer",name:"Frontal",quantity:NSNumber(integer: 30)),recipe:nil,reminder:nil)
        Medicine.createMedicine(activeIngredient:"Estradiol",availability:"Adesivo Transdérmico",manufacturer:"Janssen",name:"Systen",quantity:NSNumber(integer: 8)),recipe:nil,reminder:nil)
    }
    
    func getQuantityOfMedicines(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine]
        XCTAssertEqual(array.count, 8, "Medicine well created")
    }
    
    func createMedicinesTaken(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        for med:Medicine in array{
            Medicine_Taken.createTakenMedFromMed(med:med,today:TimeManager.getStartDayHour())
        }
    }
    
    func getQuantityOfMedicinesTaken(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine_Taken")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        XCTAssertEqual(array.count, 8, "MedicineTaken well created")
    }

    func removeAllMedicines(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine]
        for med:Medicine in array{
            context.delete(med)
        }
    }
    
    func removeAllMedicinesTaken(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Medicine")
        var array = context.executeFetchRequest(fetch, error: nil) as! [Medicine_Taken]
        for med:Medicine_Taken in array{
            context.delete(med)
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    

}

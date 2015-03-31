//: Playground - noun: a place where people can play

import Cocoa

let nomes = ["Danilo", "Gabriel", "Hélcio"]

func inverteAlfabeto(nome1: String, nome2: String) -> Bool {
    return nome1 > nome2
}

var nomesInverso = nomes.sorted(inverteAlfabeto)

nomesInverso
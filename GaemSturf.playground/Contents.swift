//
//  Tutorial.swift
//  GaemSturf
//
//  Created by Jonathan Willis on 9/10/19.
//  Copyright © 2019 WillisWare, LLC. All rights reserved.
//
import UIKit

print("Hello, world!")

var myVariable = 42
myVariable = 43
let myConstant = 42

let implicitInteger = 7
let implicitDouble = 7.0
let explicitDouble: Double = 7

let label = "The width is "
let width = 94
let widthLabel = label + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

let quotation = """
I said, "I have \(apples) apples."
Then I said, "I have \(apples + oranges) pieces of fruit."
"""

//ERROR: let emptyImplicitArray = []
let emptyExplicitArray = [String]()
var shoppingList = [ "catfish", "water", "tulips" ]
shoppingList[1] = "bottle of water"
shoppingList.append("blue paint")
print(shoppingList)

//ERROR: let emptyImplicitDictionary = [:]
let emptyExplicitDictionary = [String: Float]()
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic"
]
occupations["Jayne"] = "Public Relations"

let individualScores = [ 75, 43, 103, 87, 12 ]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

var optionalString: String? = "Hello"
print(optionalString == nil)
var optionalName: String? = "Jon"
var greeting = "Hey there!"
if let name = optionalName {
    greeting = "Hi, \(name)."
}
print(greeting)

let nickName: String? = nil
let fullName: String = "Jon Willis"
let informalGreeting = "Hi, \(nickName ?? fullName)."

let vegetable = "Red Pepper"
switch vegetable {
case "celery":
    print("This should not happen.")
case "cucumber", "watercress":
    print("Wut even is dis?")
case let x where x.hasSuffix("Pepper"):
    print("Is it a spicy \(x)?")
default:
    print("I guess it's just a vegetable.")
}

let interestingNumbers = [
    "Prime": [ 2, 3, 5, 7, 11, 13 ],
    "Fibonacci": [ 1, 1, 2, 3, 5, 8 ],
    "Square": [ 1, 4, 9, 16, 25, 36 ]
]
var largest = 0
var largestKind: String = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKind = kind
        }
    }
}
print("The \(largestKind) number \(largest) is the largest.")

var n = 2
while n < 100 {
    n *= 2
}
print(n)
repeat {
    n -= 2
} while n < 100
print(n)

var total = 0
for i in 0..<4 {
    total += i
}
print(total)

func greet(person: String, day: String) -> String {
    return "Hello, \(person). Today is \(day)."
}
greeting = greet(person: "Jon", day: "Monday")
print(greeting)

func regreet(_ person: String, on day: String) -> String {
    return greet(person: person, day: day)
}
greeting = regreet("Jon", on: "Tuesday")
print(greeting)

// Returns a Tuple
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [ 5, 3, 100, 3, 9 ])
print(statistics.sum)
print(statistics.2) // Index for the "sum" property

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
print(returnFifteen())

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}
var incrementer = makeIncrementer()
total = incrementer(10)
print(total)

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
let numbers = [ 20, 19, 7, 12 ]
var myBoolean = hasAnyMatches(list: numbers, condition: lessThanTen)
print(myBoolean)

numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
print(numbers)

let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
var shape = Shape()
shape.numberOfSides = 8
print(shape.simpleDescription())

class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }
    func simpleDescription() -> String {
        return "A \(name) shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    func area() -> Double {
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {
        return "A square with a side length of \(sideLength) and an area of \(area())."
    }
}
let square = Square(sideLength: 5.2, name: "Test Square")
print(square.simpleDescription())

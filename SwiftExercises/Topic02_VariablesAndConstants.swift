import Foundation

let studentName = "Thamaraichandhiran"
let rollNumber: Int = 2301
var semester = 7
var cgpa: Double = 8.2
let isHosteller = true

print("Name: \(studentName), Roll: \(rollNumber), Semester: \(semester)")

semester += 1
cgpa = 8.4
print("Name: \(studentName), Roll: \(rollNumber), Semester: \(semester), CGPA: \(cgpa)")

print(type(of: studentName))
print(type(of: rollNumber))
print(type(of: semester))
print(type(of: cgpa))
print(type(of: isHosteller))

var celsius = 36.6
let fahrenheitFactor = 9.0 / 5.0
let fahrenheitOffset = 32.0
let kelvinOffset = 273.15

func printConversions(for temperature: Double) {
    let fahrenheit = temperature * fahrenheitFactor + fahrenheitOffset
    let kelvin = temperature + kelvinOffset
    print("Celsius: \(String(format: "%.1f", temperature))")
    print("Fahrenheit: \(String(format: "%.1f", fahrenheit))")
    print("Kelvin: \(String(format: "%.1f", kelvin))")
}

printConversions(for: celsius)
celsius = 100
printConversions(for: celsius)

var price = 250
var quantity: Int = 3
let taxRate = 0.18
price = 300
let total = Double(price * quantity) * (1 + taxRate)
var title = "Order"
title = "Order 42"
print("\(title) total: \(String(format: "%.2f", total))")

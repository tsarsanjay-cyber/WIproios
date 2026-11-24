import Foundation

struct Address {
    var city: String?
}

struct User {
    var name: String
    var age: Int?
    var address: Address?
}

func describe(_ user: User) -> String {
    guard let age = user.age else {
        return "\(user.name): age is unknown"
    }
    let city = user.address?.city ?? "unknown city"
    return "\(user.name), \(age) years old, lives in \(city)"
}

let completeUser = User(name: "Asha", age: 21, address: Address(city: "Coimbatore"))
let noAgeUser = User(name: "Ravi", age: nil, address: Address(city: "Chennai"))
let noCityUser = User(name: "Meena", age: 22, address: Address(city: nil))

print(describe(completeUser))
print(describe(noAgeUser))
print(describe(noCityUser))

print(Int("42") as Any)
print(Int("abc") as Any)

let formEntries = ["10", "x", "25", "", "7.5", "40"]
let validNumbers = formEntries.compactMap { Int($0) }
let validSum = validNumbers.reduce(0, +)
let invalidCount = formEntries.count - validNumbers.count
let firstDoubled = validNumbers.first.map { $0 * 2 }

print("Valid integers: \(validNumbers)")
print("Sum: \(validSum)")
print("Invalid entries: \(invalidCount)")
print("First valid doubled: \(firstDoubled ?? 0)")

let scores = ["Asha": 90, "Ravi": 72]

if let kiran = scores["Kiran"] {
    print("Kiran scored \(kiran)")
} else {
    print("No score found for Kiran")
}

if let number = Int("12a") {
    print("Parsed number: \(number)")
} else {
    print("12a is not a valid number")
}

if let kiran = scores["Kiran"], let number = Int("12a") {
    print(kiran + number)
} else {
    print("Cannot add: one of the values is missing")
}

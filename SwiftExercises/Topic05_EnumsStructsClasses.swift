import Foundation

enum BookStatus {
    case available
    case borrowed(by: String, dueIn: Int)
    case reserved(for: String)

    var label: String {
        switch self {
        case .available:
            return "Available"
        case .borrowed(let name, let days):
            return "Borrowed by \(name), due in \(days) days"
        case .reserved(let name):
            return "Reserved for \(name)"
        }
    }
}

struct Book {
    let title: String
    var status: BookStatus = .available
}

class Member {
    var name: String
    var borrowedBooks: [Book] = []

    init(name: String) {
        self.name = name
    }
}

let original = Book(title: "Swift Basics")
var bookCopy = original
bookCopy.status = .borrowed(by: "Anu", dueIn: 14)
print("Original: \(original.status.label)")
print("Copy: \(bookCopy.status.label)")

let member = Member(name: "Ben")
let sameMember = member
sameMember.name = "Benjamin"
print(member.name)
print(sameMember.name)

enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)
    case triangle(base: Double, height: Double)

    var area: Double {
        switch self {
        case .circle(let radius):
            return Double.pi * radius * radius
        case .rectangle(let width, let height):
            return width * height
        case .triangle(let base, let height):
            return 0.5 * base * height
        }
    }
}

struct Rectangle {
    var width: Double
    var height: Double

    var perimeter: Double {
        2 * (width + height)
    }

    mutating func scale(by factor: Double) {
        width *= factor
        height *= factor
    }
}

let shapes: [Shape] = [
    .circle(radius: 3),
    .rectangle(width: 4, height: 5),
    .triangle(base: 6, height: 2)
]
for shape in shapes {
    print(String(format: "%.2f", shape.area))
}

let firstRectangle = Rectangle(width: 4, height: 3)
var scaledRectangle = firstRectangle
scaledRectangle.scale(by: 2)
print("Original: \(firstRectangle.width) x \(firstRectangle.height), perimeter \(firstRectangle.perimeter)")
print("Scaled: \(scaledRectangle.width) x \(scaledRectangle.height), perimeter \(scaledRectangle.perimeter)")

struct Counter {
    var value = 0
    mutating func increment() { value += 1 }
}

class Box {
    var value = 0
    func increment() { value += 1 }
}

var c = Counter()
c.increment()
print(c.value)

let b = Box()
b.increment()
let anotherB = b
anotherB.increment()
print(b.value)
print(b === anotherB)

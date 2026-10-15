import Foundation

protocol Payable {
    var name: String { get }
    func monthlyPay() -> Double
}

extension Payable {
    func payslip() -> String {
        "\(name): Rs. \(String(format: "%.2f", monthlyPay())) this month"
    }
}

struct FullTimeEmployee: Payable {
    let name: String
    let salary: Double

    func monthlyPay() -> Double {
        salary / 12
    }
}

struct Intern: Payable {
    let name: String
    let stipend: Double

    func monthlyPay() -> Double {
        stipend
    }
}

struct Contractor: Payable {
    let name: String
    let hourlyRate: Double
    let hours: Double

    func monthlyPay() -> Double {
        hourlyRate * hours
    }
}

let team: [any Payable] = [
    FullTimeEmployee(name: "Asha", salary: 600000),
    Intern(name: "Ravi", stipend: 15000),
    Contractor(name: "Meena", hourlyRate: 800, hours: 60)
]

for member in team {
    print(member.payslip())
}

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }

    func squared() -> Int {
        self * self
    }
}

extension Array where Element == Int {
    var sum: Int {
        reduce(0, +)
    }
}

extension String {
    var wordCount: Int {
        split { !$0.isLetter }.count
    }
}

struct Version {
    let major: Int
    let minor: Int
}

extension Version: Comparable {
    static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major != rhs.major {
            return lhs.major < rhs.major
        }
        return lhs.minor < rhs.minor
    }
}

print(8.isEven, 7.isEven)
print(9.squared())
print([1, 2, 3, 4].sum)
print("Swift makes extensions easy".wordCount)
print(Version(major: 1, minor: 9) < Version(major: 2, minor: 0))

let versions = [
    Version(major: 2, minor: 0),
    Version(major: 1, minor: 9),
    Version(major: 1, minor: 2)
]
for version in versions.sorted() {
    print("\(version.major).\(version.minor)")
}

protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

struct Duck: Flyable, Swimmable {
    func fly() { print("Duck flies") }
    func swim() { print("Duck swims") }
}

struct Eagle: Flyable {
    func fly() { print("Eagle flies") }
}

struct Fish: Swimmable {
    func swim() { print("Fish swims") }
}

func showOff(_ animal: any Flyable & Swimmable) {
    animal.fly()
    animal.swim()
}

showOff(Duck())

import Foundation

struct Student {
    let name: String
    let marks: Int
    let dept: String

    var passed: Bool {
        marks >= 40
    }
}

let students = [
    Student(name: "Asha", marks: 82, dept: "IT"),
    Student(name: "Ravi", marks: 35, dept: "CSE"),
    Student(name: "Meena", marks: 91, dept: "IT"),
    Student(name: "Kiran", marks: 56, dept: "ECE"),
    Student(name: "Divya", marks: 67, dept: "CSE"),
    Student(name: "Arjun", marks: 40, dept: "IT")
]

let passedFull = students.filter { (student: Student) -> Bool in
    return student.marks >= 40
}
let passedShort = students.filter { $0.marks >= 40 }
let passedKeyPath = students.filter(\.passed)

print(passedFull.count, passedShort.count, passedKeyPath.count)

let names = passedShort.map { $0.name }
print(names)

let totalMarks = students.map { $0.marks }.reduce(0, +)
let classAverage = Double(totalMarks) / Double(students.count)
print("Class average: \(String(format: "%.2f", classAverage))")

let ranking = students.sorted { $0.marks > $1.marks }
for (position, student) in ranking.enumerated() {
    print("\(position + 1). \(student.name) - \(student.marks)")
}

let byDepartment = Dictionary(grouping: students, by: { $0.dept })
for dept in byDepartment.keys.sorted() {
    let members = byDepartment[dept, default: []].map { $0.name }
    print("\(dept): \(members)")
}

func myFilter(_ items: [Int], _ predicate: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for item in items {
        if predicate(item) {
            result.append(item)
        }
    }
    return result
}

func applyTwice(_ value: Int, _ f: (Int) -> Int) -> Int {
    f(f(value))
}

class Button {
    private var handlers: [() -> Void] = []

    func onTap(_ handler: @escaping () -> Void) {
        handlers.append(handler)
    }

    func tap() {
        for handler in handlers {
            handler()
        }
    }
}

print(myFilter([1, 2, 3, 4, 5, 6], { $0 % 2 == 0 }))
print(applyTwice(3, { $0 * 5 }))

let button = Button()
button.onTap { print("First handler") }
button.onTap { print("Second handler") }
button.tap()

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let a = makeCounter()
let b = makeCounter()
print(a(), a(), b(), a())

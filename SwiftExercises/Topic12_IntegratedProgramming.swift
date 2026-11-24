import Foundation

protocol Borrowable {
    var id: Int { get }
    var title: String { get }
    var isAvailable: Bool { get set }
}

struct Book: Borrowable {
    let id: Int
    let title: String
    let author: String
    var isAvailable = true
}

struct Magazine: Borrowable {
    let id: Int
    let title: String
    let issue: Int
    var isAvailable = true
}

enum LibraryError: Error {
    case itemNotFound(id: Int)
    case alreadyBorrowed(title: String)
    case limitReached(max: Int)
}

final class Member {
    static let limit = 2

    let name: String
    private(set) var borrowedIDs: [Int] = []

    init(name: String) {
        self.name = name
    }

    func recordBorrow(_ id: Int) throws {
        guard borrowedIDs.count < Member.limit else {
            throw LibraryError.limitReached(max: Member.limit)
        }
        borrowedIDs.append(id)
    }

    func recordReturn(_ id: Int) {
        borrowedIDs.removeAll { $0 == id }
    }
}

struct Catalog<Item: Borrowable> {
    private var items: [Int: Item] = [:]

    mutating func add(_ item: Item) {
        items[item.id] = item
    }

    mutating func checkout(id: Int, to member: Member) throws {
        guard var item = items[id] else {
            throw LibraryError.itemNotFound(id: id)
        }
        guard item.isAvailable else {
            throw LibraryError.alreadyBorrowed(title: item.title)
        }
        try member.recordBorrow(id)
        item.isAvailable = false
        items[id] = item
    }
}

func describe(_ error: Error) -> String {
    guard let libraryError = error as? LibraryError else {
        return "Unexpected error: \(error)"
    }
    switch libraryError {
    case .itemNotFound(let id):
        return "No item with id \(id)"
    case .alreadyBorrowed(let title):
        return "\(title) is already borrowed"
    case .limitReached(let max):
        return "Borrowing limit of \(max) items reached"
    }
}

var catalog = Catalog<Book>()
catalog.add(Book(id: 1, title: "Swift Basics", author: "Asha"))
catalog.add(Book(id: 2, title: "SwiftUI Guide", author: "Ravi"))
catalog.add(Book(id: 3, title: "Clean Code", author: "Meena"))

let reader = Member(name: "Kiran")

for id in [1, 1, 2, 3, 9] {
    do {
        try catalog.checkout(id: id, to: reader)
        print("Issued item \(id) to \(reader.name)")
    } catch {
        print(describe(error))
    }
}
print("Borrowed ids: \(reader.borrowedIDs)")

var magazines = Catalog<Magazine>()
magazines.add(Magazine(id: 10, title: "Tech Monthly", issue: 42))
let magazineReader = Member(name: "Divya")
do {
    try magazines.checkout(id: 10, to: magazineReader)
    print("Issued magazine to \(magazineReader.name)")
} catch {
    print(describe(error))
}

protocol Entity {
    var id: Int { get }
}

enum RepositoryError: Error {
    case duplicateID(Int)
    case notFound(Int)
}

struct Repository<T: Entity> {
    private var storage: [Int: T] = [:]

    mutating func add(_ item: T) throws {
        guard storage[item.id] == nil else {
            throw RepositoryError.duplicateID(item.id)
        }
        storage[item.id] = item
    }

    func find(_ id: Int) -> T? {
        storage[id]
    }

    mutating func remove(_ id: Int) throws {
        guard storage.removeValue(forKey: id) != nil else {
            throw RepositoryError.notFound(id)
        }
    }

    func all(where predicate: (T) -> Bool = { _ in true }) -> [T] {
        storage.values.filter(predicate).sorted { $0.id < $1.id }
    }
}

struct Student: Entity {
    let id: Int
    let name: String
    let marks: Int
}

struct Course: Entity {
    let id: Int
    let title: String
}

var students = Repository<Student>()
do {
    try students.add(Student(id: 3, name: "Meena", marks: 91))
    try students.add(Student(id: 1, name: "Asha", marks: 82))
    try students.add(Student(id: 2, name: "Ravi", marks: 35))
    try students.add(Student(id: 1, name: "Duplicate", marks: 0))
} catch RepositoryError.duplicateID(let id) {
    print("Duplicate id \(id)")
} catch {
    print("Unexpected error: \(error)")
}

print(students.find(2)?.name ?? "not found")
print(students.all(where: { $0.marks >= 40 }).map { $0.name })

do {
    try students.remove(2)
    try students.remove(2)
} catch RepositoryError.notFound(let id) {
    print("No student with id \(id)")
} catch {
    print("Unexpected error: \(error)")
}

var courses = Repository<Course>()
do {
    try courses.add(Course(id: 101, title: "Swift Fundamentals"))
    try courses.add(Course(id: 102, title: "iOS Development"))
} catch {
    print("Unexpected error: \(error)")
}
print(courses.all().map { $0.title })

protocol Describable {
    var summary: String { get }
}

extension Student: Describable {
    var summary: String {
        "\(name) scored \(marks)"
    }
}

extension Course: Describable {
    var summary: String {
        "Course \(id): \(title)"
    }
}

extension Repository where T: Describable {
    func printReport() {
        for item in all() {
            print(item.summary)
        }
    }
}

students.printReport()
courses.printReport()

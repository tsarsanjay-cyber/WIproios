import Foundation

struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        items.popLast()
    }

    var top: Element? {
        items.last
    }

    var isEmpty: Bool {
        items.isEmpty
    }

    var count: Int {
        items.count
    }
}

var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
intStack.push(30)
print(intStack.top as Any, intStack.count)
print(intStack.pop() as Any)
print(intStack.count, intStack.isEmpty)

var stringStack = Stack<String>()
stringStack.push("Swift")
stringStack.push("Generics")
print(stringStack.pop() as Any)
print(stringStack.top as Any)

func largest<T: Comparable>(in items: [T]) -> T? {
    guard var best = items.first else { return nil }
    for item in items where item > best {
        best = item
    }
    return best
}

print(largest(in: [4, 9, 2]) as Any)
print(largest(in: ["pear", "apple", "mango"]) as Any)
print(largest(in: [Int]()) as Any)

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temporary = a
    a = b
    b = temporary
}

var first = "left"
var second = "right"
swapValues(&first, &second)
print(first, second)

enum ATMError: Error {
    case insufficientFunds(shortBy: Double)
    case invalidAmount
    case dailyLimitExceeded
}

struct Account {
    static let dailyLimit = 20000.0

    private(set) var balance: Double
    private var withdrawnToday = 0.0

    init(balance: Double) {
        self.balance = balance
    }

    mutating func withdraw(_ amount: Double) throws {
        guard amount > 0 else {
            throw ATMError.invalidAmount
        }
        guard withdrawnToday + amount <= Account.dailyLimit else {
            throw ATMError.dailyLimitExceeded
        }
        guard amount <= balance else {
            throw ATMError.insufficientFunds(shortBy: amount - balance)
        }
        balance -= amount
        withdrawnToday += amount
    }
}

var account = Account(balance: 10000)

for amount in [500.0, -10.0, 25000.0, 15000.0] {
    do {
        try account.withdraw(amount)
        print("Withdrew \(amount), balance \(account.balance)")
    } catch ATMError.invalidAmount {
        print("\(amount) is not a valid amount")
    } catch ATMError.dailyLimitExceeded {
        print("\(amount) exceeds the daily limit of \(Account.dailyLimit)")
    } catch ATMError.insufficientFunds(let shortBy) {
        print("Not enough balance, short by \(shortBy)")
    } catch {
        print("Unexpected error: \(error)")
    }
}

let worked = (try? account.withdraw(100)) != nil
print("Withdrawal of 100 worked: \(worked)")

enum AgeError: Error {
    case empty
    case notANumber
    case outOfRange
}

func parseAge(_ text: String) throws -> Int {
    guard !text.isEmpty else {
        throw AgeError.empty
    }
    guard let age = Int(text) else {
        throw AgeError.notANumber
    }
    guard (1...120).contains(age) else {
        throw AgeError.outOfRange
    }
    return age
}

for input in ["25", "", "abc", "150"] {
    let result = Result { try parseAge(input) }
    switch result {
    case .success(let age):
        print("Valid age: \(age)")
    case .failure(let error):
        print("Invalid age '\(input)': \(error)")
    }
}

enum ReportError: Error {
    case writeFailed
}

func saveReport(shouldFail: Bool) throws {
    print("Opening file")
    defer {
        print("Closing file")
    }
    if shouldFail {
        throw ReportError.writeFailed
    }
    print("Report saved")
}

do {
    try saveReport(shouldFail: false)
    try saveReport(shouldFail: true)
} catch {
    print("Save failed: \(error)")
}

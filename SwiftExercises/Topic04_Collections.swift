import Foundation

var subjects = ["Swift", "UIKit", "SwiftUI"]
subjects.append("Networking")
subjects.insert("Testing", at: 1)
subjects.removeAll { $0 == "UIKit" }
print(subjects.sorted())

var registered: Set<String> = ["Anu"]
registered.insert("Ben")
registered.insert("Ben")
print(registered.count)

var marks: [String: Int] = ["Anu": 78, "Ben": 64, "Chitra": 91]
marks["Dev"] = 55
marks["Ben"] = 70
print(marks["Esha"] as Any)
print(marks["Esha", default: 0])

for (name, mark) in marks.sorted(by: { $0.key < $1.key }) {
    print("\(name): \(mark)")
}

if let top = marks.max(by: { $0.value < $1.value }) {
    print("Highest mark: \(top.value) by \(top.key)")
}

let sentence = "swift is fun and swift is fast"
let words = sentence.split(separator: " ").map(String.init)
print("Number of words: \(words.count)")

let uniqueWords = Set(words)
print("Unique words: \(uniqueWords.sorted())")

var frequency: [String: Int] = [:]
for word in words {
    frequency[word, default: 0] += 1
}
print(frequency.sorted { $0.key < $1.key })

let ranked = frequency.sorted {
    $0.value != $1.value ? $0.value > $1.value : $0.key < $1.key
}
for (word, count) in ranked {
    print("\(word): \(count)")
}

let swiftClub: Set<String> = ["Anu", "Ben", "Chitra", "Dev"]
let uiClub: Set<String> = ["Chitra", "Dev", "Esha"]

print("In both clubs: \(swiftClub.intersection(uiClub).sorted())")
print("Only Swift club: \(swiftClub.subtracting(uiClub).sorted())")
print("Everyone: \(swiftClub.union(uiClub).sorted())")
print("Exactly one club: \(swiftClub.symmetricDifference(uiClub).sorted())")

let numbers = [3, 1, 3, 2, 1, 4]
var seen = Set<Int>()
let withoutDuplicates = numbers.filter { seen.insert($0).inserted }
print(withoutDuplicates)

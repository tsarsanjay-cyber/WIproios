import Foundation

func average(of marks: Int...) -> Double {
    guard !marks.isEmpty else { return 0 }
    return Double(marks.reduce(0, +)) / Double(marks.count)
}

func grade(for average: Double) -> String {
    switch average {
    case 90...:
        return "O"
    case 80..<90:
        return "A+"
    case 70..<80:
        return "A"
    case 60..<70:
        return "B"
    default:
        return "RA"
    }
}

func stats(of marks: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let lowest = marks.min(), let highest = marks.max() else { return nil }
    let mean = Double(marks.reduce(0, +)) / Double(marks.count)
    return (lowest, highest, mean)
}

func curve(_ marks: inout [Int], by bonus: Int = 5) {
    for index in marks.indices {
        marks[index] = min(marks[index] + bonus, 100)
    }
}

let mean = average(of: 82, 91, 67, 56)
print("Average: \(mean)")
print("Average with no marks: \(average())")
print("Grade: \(grade(for: mean))")

if let summary = stats(of: [82, 91, 67, 56]) {
    print("Min \(summary.min), Max \(summary.max), Average \(summary.average)")
}
print(stats(of: []) as Any)

var classMarks = [82, 97, 67, 56]
curve(&classMarks)
print(classMarks)
curve(&classMarks, by: 10)
print(classMarks)

func isPalindrome(_ text: String) -> Bool {
    let cleaned = text.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleaned == String(cleaned.reversed())
}

func vowelCount(in text: String) -> Int {
    text.lowercased().filter { "aeiou".contains($0) }.count
}

func wordCount(in text: String) -> Int {
    text.split { !$0.isLetter }.count
}

func wordCount(in text: String, minLength: Int) -> Int {
    text.split { !$0.isLetter }.filter { $0.count >= minLength }.count
}

let sample = "A man, a plan, a canal: Panama"
print("Palindrome: \(isPalindrome(sample))")
print("Vowels: \(vowelCount(in: sample))")
print("Words: \(wordCount(in: sample))")
print("Words of 4 or more letters: \(wordCount(in: sample, minLength: 4))")

func makeMultiplier(_ factor: Int) -> (Int) -> Int {
    return { number in number * factor }
}

func apply(_ values: [Int], using transform: (Int) -> Int) -> [Int] {
    var result: [Int] = []
    for value in values {
        result.append(transform(value))
    }
    return result
}

let double = makeMultiplier(2)
let triple = makeMultiplier(3)
let numbers = [1, 2, 3, 4, 5]

print(apply(numbers, using: double))
print(apply(numbers, using: triple))
print(apply(numbers, using: { $0 * $0 }))

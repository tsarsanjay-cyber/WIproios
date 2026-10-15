import Foundation

class LeakyPerson {
    let name: String
    var apartment: LeakyApartment?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("LeakyPerson \(name) is freed")
    }
}

class LeakyApartment {
    let unit: String
    var tenant: LeakyPerson?

    init(unit: String) {
        self.unit = unit
    }

    deinit {
        print("LeakyApartment \(unit) is freed")
    }
}

print("--- strong cycle ---")
var leakyPerson: LeakyPerson? = LeakyPerson(name: "Asha")
var leakyApartment: LeakyApartment? = LeakyApartment(unit: "4B")
leakyPerson?.apartment = leakyApartment
leakyApartment?.tenant = leakyPerson
leakyPerson = nil
leakyApartment = nil

class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Person \(name) is freed")
    }
}

class Apartment {
    let unit: String
    weak var tenant: Person?

    init(unit: String) {
        self.unit = unit
    }

    deinit {
        print("Apartment \(unit) is freed")
    }
}

print("--- weak tenant ---")
var person: Person? = Person(name: "Ravi")
var apartment: Apartment? = Apartment(unit: "7A")
person?.apartment = apartment
apartment?.tenant = person
person = nil
apartment = nil

class LeakyDownloader {
    let name: String
    var onFinish: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func start() {
        onFinish = {
            print("Finished \(self.name)")
        }
    }

    deinit {
        print("LeakyDownloader \(name) is freed")
    }
}

class Downloader {
    let name: String
    var onFinish: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    func start() {
        onFinish = { [weak self] in
            guard let self = self else { return }
            print("Finished \(self.name)")
        }
    }

    deinit {
        print("Downloader \(name) is freed")
    }
}

print("--- closure cycle ---")
var leakyDownloader: LeakyDownloader? = LeakyDownloader(name: "leaky.zip")
leakyDownloader?.start()
leakyDownloader?.onFinish?()
leakyDownloader = nil

print("--- fixed closure ---")
var downloader: Downloader? = Downloader(name: "fixed.zip")
downloader?.start()
downloader?.onFinish?()
downloader = nil

class Box {
    deinit {
        print("Box gone")
    }
}

print("--- when does it die ---")
var a: Box? = Box()
var b = a
var c = a
a = nil
b = nil
print("before c")
c = nil
print("end")

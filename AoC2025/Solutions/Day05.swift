enum Day05: Day {
    static let input = ""

    static func part1() -> Int {
        var sum = 0

        let split = input.split(separator: "\n\n")
        let ranges = split[0].split(separator: "\n").map {
            let rangeSplit = $0.split(separator: "-")

            return ClosedRange<Int>(
                uncheckedBounds: (
                    lower: Int(String(rangeSplit[0]))!,
                    upper: Int(String(rangeSplit[1]))!
                )
            )
        }
        let indices = split[1].split(separator: "\n").map { Int($0)! }

        for i in indices {
            if ranges.contains(where: { $0.contains(i) }) {
                sum += 1
            }
        }

        return sum
    }

    static func part2() -> Int {
        let ranges = input
            .split(separator: "\n\n")[0]
            .split(separator: "\n")
            .map { $0.split(separator: "-") }
            .map { Int(String($0[0]))!...Int(String($0[1]))! }

        let uniqueSortedRanges = Array(Set(ranges)).sorted(by: { $0.lowerBound < $1.lowerBound })

        var filteredRanges = [ClosedRange<Int>]()

        for range in uniqueSortedRanges {
            if !uniqueSortedRanges.contains(where: { $0.contains(range) && $0 != range }) {
                filteredRanges.append(range)
            }
        }

        var newRanges = [ClosedRange<Int>]()

        for i in 0..<filteredRanges.count {
            if let last = newRanges.last, filteredRanges[i].lowerBound <= last.upperBound {
                newRanges.removeLast()
                newRanges.append(last.lowerBound...filteredRanges[i].upperBound)
            } else {
                newRanges.append(filteredRanges[i])
            }
        }

        return newRanges.reduce(0) { partialResult, range in
            partialResult + range.count
        }
    }
}

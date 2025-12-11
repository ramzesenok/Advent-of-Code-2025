import Foundation

enum Day09: Day {
    static let input = ""

    struct Coordinate: Equatable {
        let x, y: Int
    }

    static func part1() -> Int {
        let coordinates = input
            .split(separator: "\n")
            .map {
                let split = $0.split(separator: ",")

                return Coordinate(x: Int(split[0])!, y: Int(split[1])!)
            }

        var maxArea = 0

        for i in 0..<coordinates.count-1 {
            let c1 = coordinates[i]

            for k in i+1..<coordinates.count {
                let c2 = coordinates[k]
                
                let a = area(between: c1, and: c2)

                if a > maxArea {
                    maxArea = a
                }
            }
        }

        return maxArea
    }

    static func area(between coordinate1: Coordinate, and coordinate2: Coordinate) -> Int {
        (abs(coordinate2.x - coordinate1.x) + 1) * (abs(coordinate2.y - coordinate1.y) + 1)
    }

    static func part2() -> Int {
        0
    }
}

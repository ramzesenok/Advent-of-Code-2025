enum Day04: Day {
    static let input = ""

    static func part1() -> Int {
        let matrix = input.split(separator: "\n").map { Array($0) }

        var sum = 0

        checkTiles(in: matrix) { _ in
            sum += 1
        }

        return sum
    }

    static func part2() -> Int {
        var matrix = input.split(separator: "\n").map { Array($0) }

        var sum = 0

        while true {
            var toRemove = [(Int, Int)]()

            checkTiles(in: matrix) { indices in
                toRemove.append(indices)
            }

            if toRemove.isEmpty {
                break
            }

            toRemove.forEach { i, j in
                matrix[i][j] = "."
            }

            sum += toRemove.count
        }

        return sum
    }

    private static func checkTiles(in matrix: [[String.Element]], onSuccess: ((Int, Int)) -> Void) {
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == "@" {
                    let adjacentRollsCount = adjacentIndices(i: i, j: j).count { isRoll(in: matrix, at: $0) }

                    if adjacentRollsCount < 4 {
                        onSuccess((i, j))
                    }
                }
            }
        }
    }

    private static func adjacentIndices(i: Int, j: Int) -> [(Int, Int)] {
        [(i-1, j-1), (i-1, j), (i-1, j+1),
         (i,   j-1),           (i,   j+1),
         (i+1, j-1), (i+1, j), (i+1, j+1)]
    }

    private static func isRoll(in matrix: [[String.Element]], at indices: (Int, Int)) -> Bool {
        guard 0..<matrix.count ~= indices.0,
              0..<matrix[indices.0].count ~= indices.1
        else { return false }

        return matrix[indices.0][indices.1] == "@"
    }
}

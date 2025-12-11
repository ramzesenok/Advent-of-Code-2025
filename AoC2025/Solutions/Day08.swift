enum Day08: Day {
    static let input = ""

    struct Junction: Equatable, Hashable {
        let x, y, z: Int
    }

    class Node: Hashable {
        let junction: Junction

        var neighbors: Set<Node>

        private(set) var circuit = Set<Node>()

        init(junction: Junction, neighbors: Set<Node> = []) {
            self.junction = junction
            self.neighbors = neighbors

            circuit = [self]
        }

        func addNeighbor(_ node: Node) {
            neighbors.insert(node)
            node.neighbors.insert(self)

            updateCircuit()
        }

        private func updateCircuit() {
            let newCircuit = getCircuit()

            for node in newCircuit {
                node.setCircuit(newCircuit)
            }
        }

        private func setCircuit(_ newCircuit: Set<Node>) {
            circuit = newCircuit
        }

        private func getCircuit(exclude: Set<Node> = []) -> Set<Node> {
            neighbors.subtracting(exclude).reduce([self], { partialResult, node in
                partialResult.union(node.getCircuit(exclude: exclude.union([self])))
            })
        }

        static func == (lhs: Day08.Node, rhs: Day08.Node) -> Bool {
            lhs.junction == rhs.junction
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(junction)
        }
    }

    static func part1() -> Int {
        let pairsToConnect = 1000

        var circuits = input
            .split(separator: "\n")
            .map {
                let split = $0.split(separator: ",")

                return Node(junction: Junction(x: Int(split[0])!, y: Int(split[1])!, z: Int(split[2])!))
            }

        var distances = [Int: (Node, Node)]()

        for i in 0..<circuits.count-1 {
            let j1 = circuits[i]

            for k in i+1..<circuits.count {
                let j2 = circuits[k]

                distances[distance(between: j1.junction, and: j2.junction)] = (j1, j2)
            }
        }

        let sortedDistances = distances.keys.sorted()

        for distance in sortedDistances.prefix(pairsToConnect) {
            let (j1, j2) = distances[distance]!

            if j1.neighbors.contains(j2) {
                continue
            }

            if !j1.circuit.contains(j2), let idxToDelete = circuits.firstIndex(where: { j2.circuit.contains($0) }) {
                circuits.remove(at: idxToDelete)
            }

            j1.addNeighbor(j2)
        }

        return circuits
            .map(\.circuit.count)
            .sorted()
            .suffix(3)
            .reduce(1, *)
    }

    static func distance(between junction1: Junction, and junction2: Junction) -> Int {
        let dx = junction1.x - junction2.x
        let dy = junction1.y - junction2.y
        let dz = junction1.z - junction2.z

        return dx*dx + dy*dy + dz*dz
    }

    static func part2() -> Int {
        0
    }
}

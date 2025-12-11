enum Day11: Day {
    static let input = ""

    struct Node {
        let name: String
        let connections: [String]
    }

    static func part1() -> Int {
        let nodes = input
            .split(separator: "\n")
            .map {
                let split = $0.split(separator: ": ")
                let name = String(split[0])
                let connections = split[1].split(separator: " ").map(String.init)

                return Node(name: name, connections: connections)
            }

        guard let start = nodes.first(where: { $0.name == "you" }) else {
            fatalError()
        }

        return followPath1(from: start, nodes: nodes)
    }

    static var cache = [String: Int]()

    private static func followPath1(from node: Node, nodes: [Node], visitedNames: [String] = []) -> Int {
        if let res = cache[node.name] {
            return res
        }


        let res = node.connections.reduce(0) { partialResult, connection in
            guard !visitedNames.contains(connection) else { return partialResult }

            if connection == "out" {
                return 1
            }

            guard let nextNode = nodes.first(where: { $0.name == connection }) else {
                fatalError()
            }

            return partialResult + followPath1(from: nextNode, nodes: nodes, visitedNames: visitedNames + [node.name])
        }

        cache[node.name] = res

        return res
    }

    static func part2() -> Int {
        let nodes = input
            .split(separator: "\n")
            .map {
                let split = $0.split(separator: ": ")
                let name = String(split[0])
                let connections = split[1].split(separator: " ").map(String.init)

                return Node(name: name, connections: connections)
            }

        guard let start = nodes.first(where: { $0.name == "svr" }) else {
            fatalError()
        }

        return followPath2(from: start, nodes: nodes)
    }

    private static func followPath2(
        from node: Node,
        nodes: [Node],
        hasVisitedFFT: Bool = false,
        hasVisitedDAC: Bool = false,
        visitedNames: [String] = []
    ) -> Int {
        if let res = cache["\(node.name)_\(hasVisitedFFT)_\(hasVisitedDAC)"] {
            return res
        }

        let res = node.connections.reduce(0) { partialResult, connection in
            guard !visitedNames.contains(connection) else { return partialResult }

            if connection == "out" {
                return hasVisitedFFT && hasVisitedDAC ? 1 : 0
            }

            guard let nextNode = nodes.first(where: { $0.name == connection }) else {
                fatalError()
            }

            return partialResult + followPath2(
                from: nextNode,
                nodes: nodes,
                hasVisitedFFT: hasVisitedFFT || connection == "fft",
                hasVisitedDAC: hasVisitedDAC || connection == "dac",
                visitedNames: visitedNames + [node.name]
            )
        }

        cache["\(node.name)_\(hasVisitedFFT)_\(hasVisitedDAC)"] = res

        return res
    }
}


# Floyd_Warshall Algorithm

**Background:**

*Floyd-Warshall* is a recursive algorithm for finding the shortest path, if one exists, between each pair of nodes on a weighted graph. The graph can be directed or non-directed but must not have negative cycles. That is, the sum of the edge distances (weights) in a cycle must not be negative.

The algorithm uses a matrix ***dist*** of path distances between each pair of nodes. The matrix is initialized with infinity for the distance between all pairs. Then known distances are filled into the matrix.

For i & j in (0 .. n-1) where n is the number of nodes in the graph

 - `dist[i][i] = 0`  the shortest distance from a node to itself is `0`
 - `dist[[i][j] = known_pair_distance` for nearest neighbors

For i, j, & k in (0 .. n-1) where n is the number of nodes in the graph,
k is the index of a possible intermediate step in the path from node[i] to node[j]

    if dist[i][j] > dist[i][k] + dist [k][j]
    then dist[i][j] = dist[i][k] + dist [k][j]
which improves the distance estimate for the path from `node[i]` to `node[j]`.

Cycling through all values for indices k, i, & j fills the matrix with the shortest path between each node pair. It is possible to reconstruct the list of nodes visited in the shortest path. The methods `fwa_traced` and `fwa_ut` provide that.

Note that for an undirected graph the distance from `node[i]` to `node [j]` equals the distance from `node[j]` to `node[i] `. The matrix is symmetric about the diagonal from `dist[0][0]` to `dist[n-1][n-1]` which allows additional optimization. The method `fwa_undirected` provides that. Path reconstruction (trace) does not work properly with the undirected graph optimization. Do not know why.

[Wikipedia reference.](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)

**Demo:**

A short demo of this implementation of the Floyd Warshall Algorithm is included in the demo folder.

    cd FloydWarshall/demo
    ruby runner.rb

The structured data input, the cost matrix output, and the shortest path from node JJ to node HH are the output. This demo is taken from a portion of a solution to the [Advent of Code 2022 Day 16](https://adventofcode.com/2022) puzzle.

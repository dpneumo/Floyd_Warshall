
# Floyd_Warshall Algorithm

**Motivation**
I recently found [Advent of Code](https://adventofcode.com/). While working through the puzzles I needed to use various algorithms for solving various aspects of the puzzles. Algorithms for which I had never written code nor, in many instances, had more than a minimal understanding of the logic behind the algorithm. I love Ruby for allowing me to express ideas in code without a lot of cruft unrelated to the underlying ideas. I use the coding process to gain understanding of the algorithm's logic. I will publish the results of my exercises here in the hope of being useful to my future self and to others.

**Background**

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

Cycling through all values for indices k, i, & j fills the matrix with the shortest path between each node pair. It is possible to reconstruct the list of nodes visited in the shortest path. The method `fwa_traced` provides that.

Note that for an undirected graph the distance from `node[i]` to `node [j]` equals the distance from `node[j]` to `node[i] `. The matrix is symmetric about the diagonal from `dist[0][0]` to `dist[n-1][n-1]` which allows additional optimization. The method `fwa_undirected` provides that.

Path reconstruction (trace) does not work with the undirected graph optimization. Path reconstruction recovers the lowest cost path from A to B: A -> X -> Y -> B. That is not the same as the path B to A: B -> Y -> X -> A. The nxt matrix is NOT symmetric about the diagonal.

[Wikipedia reference.](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)

**Demo:**

A short demo of this implementation of the Floyd Warshall Algorithm is included in the demo folder.

    cd FloydWarshall/demo
    ruby runner.rb

The structured data input, the cost matrix output, and the shortest path from node JJ to node HH are the output. This demo is taken from a portion of a solution to the [Advent of Code 2022 Day 16](https://adventofcode.com/2022) puzzle.

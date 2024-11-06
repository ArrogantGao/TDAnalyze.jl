using Graphs, TDAnalyze, OMEinsum, GenericTensorNetworks, TreeWidthSolver
using TDAnalyze: eincode2order, eincode2graph

g0 = random_regular_graph(100, 3)

prob = GenericTensorNetwork(IndependentSet(g0); optimizer=TreeSA(; ntrials=5, niters=10))
code = prob.code.eins

contraction_complexity(code, uniformsize(code, 2^10))
tree = decompose(code)
width(tree) + 1

@assert is_treedecomposition(g0, tree)

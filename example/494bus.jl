using TreeWidthSolver, TreeWidthSolver.AbstractTrees
using TDAnalyze
using TDAnalyze.OMEinsum, GenericTensorNetworks, Graphs
using KaHyPar
using Plots
using GraphIO

g_494 = loadgraph("494bus.g6")

prob = GenericTensorNetwork(IndependentSet(g_494); optimizer=TreeSA(; ntrials=1, niters=30))
code = prob.code.eins

cc = contraction_complexity(code, uniformsize(code, 2))
tree = decompose(code)
mb = max_bag(tree)


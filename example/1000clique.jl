using TreeWidthSolver, TreeWidthSolver.AbstractTrees
using TDAnalyze
using TDAnalyze.OMEinsum, GenericTensorNetworks, Graphs
using GraphIO

g = loadgraph("1000clique.g6")

prob = GenericTensorNetwork(IndependentSet(g); optimizer=TreeSA(; ntrials=1, niters=30))
code = prob.code.eins

cc = contraction_complexity(code, uniformsize(code, 2))
tree = decompose(code)
mb = max_bag(tree)
sub_graph, vmap = induced_subgraph(g, [i for i in mb.bag])

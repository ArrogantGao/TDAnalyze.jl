module TDAnalyze

using OMEinsum, TreeWidthSolver, GenericTensorNetworks
using TreeWidthSolver.Graphs, TreeWidthSolver.AbstractTrees

export decompose, max_bag

include("tree_decomposition.jl")

end

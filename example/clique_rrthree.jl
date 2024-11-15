using TreeWidthSolver, TreeWidthSolver.AbstractTrees
using TDAnalyze
using TDAnalyze.OMEinsum, GenericTensorNetworks, Graphs
using Plots
using GraphIO

function clique_with_rrthree(clique_size::Int, rrthree_size::Int, rrthree_num::Int)
    g = SimpleGraph(clique_size + rrthree_size * rrthree_num)
    for i in 1:clique_size - 1
        for j in i + 1:clique_size
            add_edge!(g, i, j)
        end
    end
    for i in 1:rrthree_num
        g_sub = random_regular_graph(rrthree_size, 3)
        for e in edges(g_sub)
            add_edge!(g, clique_size + (i - 1) * rrthree_size + src(e), clique_size + (i - 1) * rrthree_size + dst(e))
        end
        add_edge!(g, rand(1:clique_size), clique_size + (i - 1) * rrthree_size + 1)
    end
    return g
end


g = clique_with_rrthree(20, 10, 10)

prob = GenericTensorNetwork(IndependentSet(g); optimizer=TreeSA(; ntrials=1, niters=30))
code = prob.code.eins

cc = contraction_complexity(code, uniformsize(code, 2))
tree = decompose(code)
mb = max_bag(tree)
sub_graph, vmap = induced_subgraph(g, [i for i in mb.bag])

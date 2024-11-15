using TreeWidthSolver, TreeWidthSolver.AbstractTrees
using OMEinsum, GenericTensorNetworks, Graphs
using TDAnalyze
using Plots

g0 = random_regular_graph(150, 3)

prob = GenericTensorNetwork(IndependentSet(g0); optimizer=TreeSA(; ntrials=1, niters=10))
code = prob.code.eins

cc = contraction_complexity(code, uniformsize(code, 2))
tree = decompose(code)

# treebags = [node.bag for node in PostOrderDFS(tree)]

# length(treebags)
# bagsizes = sort(length.(treebags))

# histogram(bagsizes)

mnode = max_bag(tree)
sub_graph_maxbag, vmap = induced_subgraph(g0, [i for i in mnode.bag])


neighbors_bags = [[j for j in i.bag] for i in mnode.children]
push!(neighbors_bags, [j for j in AbstractTrees.parent(mnode).bag])

intersect(neighbors_bags[1], mnode.bag)
intersect(neighbors_bags[2], mnode.bag)
intersect(neighbors_bags[3], mnode.bag)

function grid_graph(m::Int, n::Int)
    g = SimpleGraph(m*n)
    for i in 1:m
        for j in 1:n
            for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)]
                if (i + dx) > 0 && (i + dx) <= m && (j + dy) > 0 && (j + dy) <= n
                    !has_edge(g, i + (j-1)*m, (i+dx) + (j+dy-1)*m) && add_edge!(g, i + (j-1)*m, (i+dx) + (j+dy-1)*m)
                end
            end
        end
    end
    return g
end
gg = grid_graph(10, 10)


prob = GenericTensorNetwork(IndependentSet(gg); optimizer=TreeSA(; ntrials=1, niters=10))
code = prob.code.eins

cc = contraction_complexity(code, uniformsize(code, 2))
tree = decompose(code)
mnode = max_bag(tree)

sub_graph_maxbag, vmap = induced_subgraph(gg, [i for i in mnode.bag])
using OMEinsum: isleaf, getixsv, getiyv, LeafString, flatten

# transform optimized eincode to elimination order
function eincode2order(code::NestedEinsum{L}) where {L}
    elimination_order = Vector{L}()
    isleaf(code) && return elimination_order
    for node in PostOrderDFS(code)
        (node isa LeafString) && continue
        for id in setdiff(vcat(getixsv(node.eins)...), getiyv(node.eins))
            push!(elimination_order, id)
        end
    end
    return reverse(elimination_order)
end


function eincode2graph(code::Union{NestedEinsum, EinCode})
    fcode = code isa NestedEinsum ? flatten(code) : code
    indices = uniquelabels(fcode)
    g = SimpleGraph(length(indices))
    id_dict = Dict(id => i for (i, id) in enumerate(indices))
    for xs in [getixsv(fcode); getiyv(fcode)]
        for i in 1:length(xs)-1
            for j in i+1:length(xs)
                add_edge!(g, id_dict[xs[i]], id_dict[xs[j]])
            end
        end
    end
    return g, id_dict
end

function decompose(code::NestedEinsum{L}) where {L}
    g, id_dict = eincode2graph(code)
    order = eincode2order(code)
    labels = [id_dict[id] for id in order]
    return decomposition_tree(g, labels)
end

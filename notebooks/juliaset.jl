# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.1
#   kernelspec:
#     display_name: Julia 1.2.0
#     language: julia
#     name: julia-1.2
# ---

# # Julia sets

using Plots
plotlyjs()

f(z::Complex,c::Complex) = z^2 + c

function level(z::Complex,c,f::Function,n::Int64=500,R::Float64=10.0)
    i = 0
    while( (i<N) & (abs(z)<R) )
        z = f(z,c)
        i += 1
    end
    return i/(n+1)
end

logit(x) = log(x/(1-x))

N = 500
x = y = ((-N):N)/N
z = complex.(x,y')
c0 = complex(-1.0,0.0)
c1 = complex(-0.75,0.3)
c2 = complex(-0.65,0.45)
w = abs.(logit.(level.(z,c2,f)));

# colorschemes https://makie.juliaplots.org/stable/colors.html
heatmap(x,y,w',size=(500,500),xaxis=false,yaxis=false,legend=false,color=:blues)

savefig("juliaset.png")

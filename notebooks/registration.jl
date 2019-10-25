# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.4'
#       jupytext_version: 1.2.4
#   kernelspec:
#     display_name: Julia 1.2.0
#     language: julia
#     name: julia-1.2
# ---

using CSV, StatsBase, UnicodePlots

hdr = ["respType","r","python","matlab","c","java","sas","fortran","other"]
regis = CSV.read("../data/registrants.csv",datarow=5,header=hdr)
first(regis,10)

# +
sumnotmissing(x) = length(x) - sum(ismissing.(x))

prop = sumnotmissing.(eachcol(regis[:,2:(end)]))./size(regis,1)
pct = round.(prop*100)
langs = hdr[2:(end)];
# -

barplot(langs,pct)

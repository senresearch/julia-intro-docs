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

# # Languages used by Julia seminar registrants

# add packages
using CSV, StatsBase, UnicodePlots

# header for filke
hdr = ["respType","r","python","matlab","c","java","sas","fortran","other"]
# read data
regis = CSV.read("../data/registrants.csv",datarow=5,header=hdr)
# examine first few lines
first(regis,10)

# calculate non-missing responses
sumnotmissing(x) = length(x) - sum(ismissing.(x))
# proportion of registrants with non-missing (know language)
prop = sumnotmissing.(eachcol(regis[:,2:(end)]))./size(regis,1)
# convert to percent
pct = round.(prop*100)
# names of languages
langs = hdr[2:(end)];

# barplot
barplot(langs,pct)

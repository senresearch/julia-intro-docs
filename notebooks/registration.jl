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

using CSV, StatsBase, UnicodePlots

dt = readlines("data/registrants.csv")

hdr = ["respType","r","python","matlab","c","java","sas","fortran","other"]
regis = CSV.read("data/registrants.csv",datarow=5,header=hdr)
first(regis,10)

using StatsBase
sum.(skipmissing.(eachcol(regis[:,2:(end-1)])))

pct = round.(sum.(skipmissing.(eachcol(regis[:,2:(end-1)])))./(33/100))
langs = hdr[2:(end-1)]

using UnicodePlots

barplot(langs,pct)

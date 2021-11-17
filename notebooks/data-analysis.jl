# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.11.0
#   kernelspec:
#     display_name: Julia 1.6.3
#     language: julia
#     name: julia-1.6
# ---

# + [markdown] slideshow={"slide_type": "slide"}
# # Basic data analysis tasks
#
# - Data: Fitness in Arabidopsis recombinant inbred lines
# - Data input: CSV files, missing data
# - Data description: Summary statistics, plots
# - Modeling: Linear regression

# + [markdown] slideshow={"slide_type": "slide"}
# ## Example: Fitness measured in Arabidopsis recombinant inbred lines
#
# Topics: Reading data, JIT compiler, missing data, summary statistics, plots, linear regression 
# -

using Statistics, CSV, Plots, DataFrames, GLM

# ## Reading data

agrenURL = "https://raw.githubusercontent.com/sens/smalldata/master/arabidopsis/agren2013.csv"
agren = CSV.read(download(agrenURL),DataFrame,missingstring="NA");
first(agren,10)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Data description
# -

describe(agren)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Calculating summary statistics
# -

mean(skipmissing(agren.it09))

mean.(skipmissing.(eachcol(agren)))

?skipmissing

# + [markdown] slideshow={"slide_type": "slide"}
# ## Visualization: histogram
# -

histogram(Float64.(skipmissing(agren.it09)),lab="")
# display.(histogram.(eachcol(agren)))

# + [markdown] slideshow={"slide_type": "slide"}
# ## Visualization: scatterplot
# -

scatter(log2.(agren.it09),log2.(agren.it10),lab="")

# + [markdown] slideshow={"slide_type": "slide"}
# ## Modeling: linear regression
# -

out0 = lm(@formula(it11~it09+flc),agren)

# ## Extracting information

coef(out0)

vcov(out0)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Residual plots
# -

scatter(residuals(out0),predict(out0),lab="")

# ## GLM

out1 = glm(@formula( it11 ~ log(it09) ),agren,Normal(),LogLink())

# ## Chaining and automation of model fitting

# + jupyter={"outputs_hidden": true} tags=[]
yr = ["09","10","11"]
sw = ("sw" .* yr);
it = ("it" .* yr);
models = Term.(Symbol.(sw)) .~ Term.(Symbol.(it)) .+ Term.(:flc)

broadcast( m->glm(m,agren,Normal(),LogLink()), models ) .|> coeftable

# + tags=[]
( Term.(Symbol.(sw)) .~ permutedims(Term.(Symbol.(it))) .+ Term.(:flc) )  .|> 
                     ( m->glm(m,agren,Normal(),LogLink()) ) .|>
                     print;
# -

# ## Generating random numbers

using Random
using Distributions

# initialize random number generator
rnd = MersenneTwister(100)
# Draw uniform (0,1) numbers in 4x4 matrix
rand(Cauchy(),4,4)

# ## Calculating probabilities and densities

# Calculating the CDF of the normal distribution

cdf(Cauchy(0,1),1.96)

# Quantiles of the normal distribution.

quantile(Normal(),0.95)

# Generating random normal variables with mean 0.3 and standard deviation 0.5.

x = rand(Normal(0.3,0.5),1000)

# We now fit the MLE assuming a normal distribution.

normFit = fit_mle(Laplace,x)

# We generate normal variables with parameters equal to the estimated ones.

rand(normFit,10)

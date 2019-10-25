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

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # Basic data analysis tasks
#
# - Data: Fitness in Arabidopsis recombinant inbred lines
# - Data input: CSV files, missing data
# - Data description: Summary statistics, plots
# - Modeling: Linear regression

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Example: Fitness measured in Arabidopsis recombinant inbred lines
#
# Topics: Reading data, JIT compiler, missing data, summary statistics, plots, linear regression 
# -

using Statistics, CSV, Plots, DataFrames, GLM

# ## Reading data

agrenURL = "https://bitbucket.org/linen/smalldata/raw/3c9bcd603b67a16d02c5dc23e7e3e637758d4d5f/arabidopsis/agren2013.csv"
agren = CSV.read(download(agrenURL),missingstring="NA")
first(agren,10)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Data description
# -

describe(agren)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Calculating summary statistics
# -

mean(skipmissing(agren.it09))

mean.(skipmissing.(eachcol(agren)))

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Visualization: histogram
# -

histogram(agren.it09,lab="")
# display.(histogram.(eachcol(agren)))

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Visualization: scatterplot
# -

scatter(log2.(agren.it09),log2.(agren.it10),lab="")

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Modeling: linear regression
# -

out0 = lm(@formula(it11~it09+flc),agren)

# ## Extracting information

coef(out0)

vcov(out0)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ## Residual plots
# -

scatter(residuals(out0),predict(out0),lab="")

# ## GLM

out1 = glm(@formula( it11 ~ log(it09) ),agren,Normal(),LogLink())

# ## Generating random numbers

using Random
using Distributions

# initialize random number generator
rnd = MersenneTwister(100)
# Draw uniform (0,1) numbers in 4x4 matrix
rand(Uniform(),4,4)

# ## Calculating probabilities and densities

# Calculating the CDF of the normal distribution

cdf(Normal(0,1),1.96)

# Quantiles of the normal distribution.

quantile(Normal(),0.95)

# Generating random normal variables with mean 0.3 and standard deviation 0.5.

x = rand(Normal(0.3,0.5),1000)

# We now fit the MLE assuming a normal distribution.

normFit = fit_mle(Normal,x)

# We generate normal variables with parameters equal to the estimated ones.

rand(normFit,10)

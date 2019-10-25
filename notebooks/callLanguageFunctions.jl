# -*- coding: utf-8 -*-
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
# # Language Binding
#
# The purpose of this notebook is for you to see as simple it is to call function or libraries from other programming languages. We show you few examples how to directly call and fully interoperate with Python and R from the Julia language, with the packages `PyCall` and `RCall`.
#
#
# *References for this notebook:*
# * PyCall Documentation: https://pkg.julialang.org/docs/PyCall/GkzkC/1.91.2/
# * RCall Documentation: http://juliainterop.github.io/RCall.jl/stable/
# * Excelling at Julia Basics and Beyond (Huda Nassar, Jane Herriman): 
#     https://github.com/xorJane/Excelling-at-Julia-Basics-and-Beyond

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# # Outline of this notebook
#
#
# - Calling python built-in function 
# - Calling python hand-written function 
# - Importing python libraries
# - Calling R built-in function
# - Calling R hand-written function

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # Let choose an easy enough function to understand calling mechanisms: `sum`

# + {"slideshow": {"slide_type": "-"}, "cell_type": "markdown"}
# Consider the  **sum** function `sum(x)`, which computes
# $$
# \mathrm{sum}(x) = \sum_{i=1}^n x_i,
# $$
# where $n$ is the length of `x`.

# + {"slideshow": {"slide_type": "subslide"}}
# Generate avector of random numbers, uniform on [0,1)
a = rand(10^3);

# + {"slideshow": {"slide_type": "-"}, "cell_type": "markdown"}
#     The expected result is 0.5 * 10^4, since the mean of each entry is 0.5

# + {"slideshow": {"slide_type": "-"}}
 sum(a)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # 1. Calling Python's built-in `sum` 

# + {"slideshow": {"slide_type": "-"}, "cell_type": "markdown"}
# The `PyCall` package provides a Julia interface to Python:

# + {"slideshow": {"slide_type": "-"}}
# Using Pkg; Pkg.add("PyCall")
using PyCall

# + {"slideshow": {"slide_type": "-"}}
# Get the Python built-in "sum" function:
pysum = pybuiltin("sum")

# + {"slideshow": {"slide_type": "-"}}
pysum(a)

# + {"slideshow": {"slide_type": "-"}}
# Confirm that the results of Julia and Python built in sum function are approximatly the same    
pysum(a) ≈ sum(a)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # 2. Calling Python hand-written `sum` function 
#
# We can also write an easy Python code from within Julia.

# + {"slideshow": {"slide_type": "-"}, "cell_type": "markdown"}
# ### We can take an existing python function and wrap it into a julia function
# _filename: python_sum.py_
#
# ```python
# def py_sum(A):
#     s = 0.0
#     for a in A:
#         s += a
#     return s
# ```

# + {"slideshow": {"slide_type": "-"}}
pushfirst!(PyVector(pyimport("sys")."path"), ""); #to tell pyimport search in the local directory

# + {"slideshow": {"slide_type": "subslide"}}
python_sum = pyimport("python_sum") # wrote a function outside julia

# + {"slideshow": {"slide_type": "-"}}
python_sum.py_sum(a)

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# ### We can directly write the python function and wrap it into a julia function
# -

py"""
def py_sum(A):
    s = 0.0
    for a in A:
        s += a
    return s
"""
sum_py = py"py_sum"

# + {"slideshow": {"slide_type": "-"}}
sum_py(a)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # 3. Importing Python libraries 
#
# Here is a simple example to call Python `math` library and its sinus function `math.sin`:

# + {"slideshow": {"slide_type": "-"}}
math = pyimport("math")
math.sin(math.pi / 4) 

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# ## `numpy` takes advantage of  hardware "SIMD"
#
# `numpy` is an optimized C library, callable from Python.
# It may be installed within Julia as follows:

# + {"slideshow": {"slide_type": "-"}}
# using Pkg; Pkg.add("Conda")
using Conda
# In case numpy is not already installed run:
Conda.add("numpy")

# + {"slideshow": {"slide_type": "subslide"}}
# We can use now the sum function from the `numpy` library
numpy_sum = pyimport("numpy")."sum"

# + {"slideshow": {"slide_type": "-"}}
numpy_sum(a)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # 4. Calling R built-in `sum` 
#
# Since it is true that Julia still lacks the depth and scale of the R package environment, let see how to interoperate R and Julia with `RCall`.

# + {"slideshow": {"slide_type": "-"}}
# using Pkg; Pkg.add("RCall")
using RCall

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# We are able use directly base R function and pass arguments easily, as in the next example: 

# + {"slideshow": {"slide_type": "-"}}
# Syntax Option 1
R"sum($a)"

# + {"slideshow": {"slide_type": "-"}}
# Syntax Option 2
rcall(:sum, a)

# + {"slideshow": {"slide_type": "-"}}
sum_R = convert(Float64, rcall(:sum, a))

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # 5. Calling R hand-written function
#
# ### We can directly write the R function and wrap it into a julia function.

# + {"slideshow": {"slide_type": "-"}}
R"""
library(vioplot); agrenViolinPlot <- function(){
agrenURL <- "https://bitbucket.org/linen/smalldata/raw/3c9bcd603b67a16d02c5dc23e7e3e637758d4d5f/arabidopsis/agren2013.csv"
agren <- read.csv(agrenURL); agrenFit <- agren[,c(1,2,3,4,5,6)]
vioplot(agrenFit, names=names(agrenFit), main = "ViolinPlot of Fitness Values per site and year", xlab ="Site", ylab =  "Fitness Values",col = rainbow(6))}
"""
R"agrenViolinPlot"();

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# ### We can even use summary function from directly on our Julia dataframes

# + {"slideshow": {"slide_type": "-"}}
using CSV, DataFrames
agrenURL = "https://bitbucket.org/linen/smalldata/raw/3c9bcd603b67a16d02c5dc23e7e3e637758d4d5f/arabidopsis/agren2013.csv"
agren = CSV.read(download(agrenURL),missingstring="NA");
 agren = dropmissing(agren, disallowmissing=true);

# + {"slideshow": {"slide_type": "-"}}
rcall(:summary, agren)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # Summary
# ### Similar packages exists also for Java, C++ and C. Call function packages makes programming in Julia more productive and flexible. 

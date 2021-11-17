# -*- coding: utf-8 -*-
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

# # Optimization and linear algebra
#
# Topics: Linear algebra, functions, optimization, Unicode support, pass by reference, arrays, types

# ## Example: Least squares
#
# We will write a simple linear regression routine that will use linear algebra functions.  Recall that we want to fit a model of the form
#
# $$ y = X\beta + \epsilon,$$ 
#
# where $y$ is the response vector, $X$ is the matrix of predictors (design matrix) and $\epsilon$ are the errors.  We assume homoscedastic error, so that $V(\epsilon) = \sigma^2 I$.

# load packages we will be using
using LinearAlgebra, DataFrames, CSV, GLM, BenchmarkTools

# We download the Arabidopsis data from the web URL.

agrenURL = "https://bitbucket.org/linen/smalldata/raw/3c9bcd603b67a16d02c5dc23e7e3e637758d4d5f/arabidopsis/agren2013.csv"
agren = CSV.read(download(agrenURL),missingstring="NA");

# For convenience we subset the data to those without any missing data.  We will also convert the data frame into a matrix so that the linear regression routine does not have to handle missing data.

# drop the rows with missing data
agren1 = dropmissing(agren)
# check how many rows are left
nrow(agren1)
# few rows
first(agren1,4)

# Next, we conver the data into a matrix (from a data frame); we will do the linear regression of fitness in Italy for 2010 using the 2009 data as the predictor.

# convert data frame to matrix
agrenMat = convert(Matrix,agren1[:,1:6])
# convert outcome/response vector to a matrix with one column
y = reshape(agrenMat[:,2],:,1)
# make the predictor matrix including an intercept
X = [ ones(nrow(agren1)) agrenMat[:,1] ]

# We use the standard function to do the linear regression.

# run linear regression using built-in function
# @btime
out = lm(@formula(it10~it09),agren1)

# We will create a data structure called `Ls` to store the results of linear regression.

# define new data structure (object)
struct Ls
    β::Matrix{Float64} # regression coefficients
    V::Matrix{Float64} # variance covariance of estimates
end

# Next we write a function to calculate the least squares estimate and variance-covariance matrix.  Note that we specify the types of the arguments.  This is important for the compiler to optimize for speed.
#
# It is well-known that the least squares estimates have closed-form formulas.
# $$\hat{\beta} = (X^\prime X)^{{-}1} X^\prime y,$$
# $$\hat{y} = X\hat{\beta}$$
# $$\hat{\sigma^2} = \|y-\hat{y}\|^2 /(n-p)$$
# $$ V(\hat{\beta}) = \sigma^2 (X^\prime X)^{{-}1}$$

"""
ls: function for least squares estimation

y = response (matrix with one column)
X = matrix of predictors (assumed to be of full rank)
"""
function ls( y::Matrix{Float64}, X::Matrix{Float64} )
    n,p = size(X)   # dimensions of design matrix (predictors)
    β = (X'X)\(X'y) # least squares estimate
    ŷ = X*β      # calculate fitted values
    σ² = norm(y-ŷ)^2/(n-p)  # calculate residual standard deviation
    return Ls(β,(σ²*inv(X'X))) # return estimate and variance/covariance
end

# We now examine the estimates and compare with the values of the standard implementation.

# @btime
lsout = ls(y,X)

hcat( lsout.β, coef(out) )

# We compare the variance covariances as well, which are also essentially identical.

lsout.V

vcov(out)

# ## Example: Gradient descent
#
# Now we examine writing a simple minimizer using gradient descent for a convex function that is a squared error loss with a L$_1$ penalty.  We import a package to perform symbolic differentiation.
#
# We consider minimizing the with respect to $x$, the function $$f(x) = (x-2)^2 + 2\|x\|.$$

using Calculus, Plots
f(x) = (x-2.0)^2 + 2.0*abs(x)
plot(f,-1,4,lab="")

# We calculate the derivative and assign the the function a name.

plot(derivative(f),-1,4,lab="")

# We write the gradient descent solver that takes as input the function, its gradient, an initial value, a stepsize, and a tolerance value to determine convergence.  The block of text within triple quotes before a function definition is interpreted as Markdown for documenting the function.
#
# The function is very easy to understand, and almost looks like pseudocode.

"""
gradientDescent: Minimizer of a one-dimensional function using gradient descent

- f = function to minimize (scalar arguments)   
- ∇f = derivative of f   
- x0 = starting value  
- stepsize = step size for gradient descent  
- tol = tolerance for determining convergence
"""
function gradientDescent( f::Function, ∇f::Function, x0::Float64, stepsize::Float64, tol::Float64)
    change = 10.0*tol # initialize change variable
    x1 = x0 # intialize current value
    while( abs(change)>tol ) # repeat loop while convergence criterion unmet
        x1 = x0 - stepsize*∇f(x0) # new value is old value in the direction of the gradient
        change = f(x1)-f(x0) # calculate change
        x0 = x1 # update old value
    end
    return x1, f(x1) # return minimizer and function value
end

?gradientDescent

# Now we are ready to apply this function to the LASSO like function.

gradientDescent( f , derivative(f), 1.0, 0.5, 1e-5)

f(0)

# ## Pass by reference
#
# When dealing with large datasets, it is useful to avoid copying the data too much.  In Julia, arrays are passed by reference, by default.  This may take some getting used to for R or Matlab users, as the following example shows.
#
# We define an array with three values.

men = ["tom","dick","harry"]

# We make a copy called `horsemen`, which is just a copy of the pointer, so is still referring to the same data as `men`.
#
# The variable `footmen` holds a copy of the data into a new array.

horsemen = men
footmen = copy(men)
hcat( men, horsemen, footmen )

# Not let's change the name of the first element of `men`, and see what happens.

horsemen[1] = "john"
hcat(men,horsemen,footmen)

# We see that both `men` and `horsemen` have changed, but `footmen` has not (because it is a copy of the original data).

# Not copying data saves a lot of time, as the following timing example shows.

@time x0 = randn(10000,10000);

@time x1 = x0; # copy pointer

@time x2 = copy(x0); # copy data

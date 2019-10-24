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
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide1.png)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide2.png)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide3.png)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide4.png)
# -

#JIT slide


# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # Multiple Dispatch + Type Inference
#
# - Namespace level (eg: select)
# - Different strutures
# - Different input type
# - Different assembly

# + {"slideshow": {"slide_type": "subslide"}}
my_square(x) = x^2
@code_typed my_square(1)
# -

@code_typed my_square(1.0)

# Of course, if you know the type of your input, it is always best practice to specify it. 
my_int_square(x::Int64) = x^2
@code_typed my_int_square(1)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# # Cache and reuse compiled code.  
# This is an easy concept. 
# The code is only compiled once and then cached, so that you don't pay the compilation time again at the next call. 
# -

@time 2^30

@time 2^30

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide6.png)

# + {"slideshow": {"slide_type": "slide"}}
@macroexpand 1+2
# -

@code_lowered 1+2

@code_typed 1+2

# + {"slideshow": {"slide_type": "subslide"}}
@code_llvm 1+2
# -

# If you really want to see assembly code, do this:
@code_native 1+2

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide7.png)
# -

# So, in order to find out why is Julia fast, we need to be asking a question: what makes a language slow?
# let me give you a real life example: which one can you drive faster on, high way or local roads? 
# On local roads, there are pedestrians and bikers, and all kinds of businesses that you need to be going to. 
# The traffic condition is a lot more complicated than highway, where you only have to worry about the car ahead of you. 
#
# Same goes for language, for a dynamic language, the compiler or interpreter have to be able to handle all types of input, floating point, integer, even user defined type. 
# There is no way to predict what kind of input you will give, until the compiler evaluates that line of code. 
# So you lose all the wonderful benefit of code optimization from the compiler. 
# If you like to change variable types on the fly, mostly likely, that's why your code runs slow. 
#
# # Essentially, type stability is the key to making a language fast. 
#
# Julia achieves this type stability with JIT compiler and multiple dispatch. 
# A compiler is a translator that turns source code to machine code. It is statically typed, but does not take in account runtime information 
# An interpreter runs your code line by line. You can change the type of your variable on the fly, but is very slow. 
# # JIT compiler:
# JIT is a hybrid approach of the two. 
# It compiles your code at runtime, so that it provide compiler runtime information for better optimization, and compiles the code to run very fast. 
#
# Now that we understand the compiler choice of Julia, let's view some awesome design features that helps you understand your code better. 
# - Multiple Dispatch: dynamic type achieved through type inference for easy use, static compile for speed 
# - Cached compilation: don't invent wheel twice
# - Easy code introspect with macro of every compilation stage.
#
#
# Multiple dispatch means a function or method can be dynamically dispatched based on the run time (dynamic) type. 
# The easist way to understand multiple dispatch is that it is very much like function overload. 
# Function overload is two functions that has the same name, but have different argument, either by type, or by number of argument.
# This allows code to run the most efficient way for a specific type of input. 
# But this is a lot of work to implement the same method for every possible data type, and a lot of time, it is redundant. 
# Julia takes over the tedious task, and uses type inference to determin the type and generate efficient compiled code. It takes the burden of writing efficient code off your shoulder, let the compiler help you. 
#
#

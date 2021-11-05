# ---
# jupyter:
#   jupytext:
#     cell_metadata_json: true
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

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide1.png)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide2.png)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide3.png)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide4.png)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide5.png)


# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide6.png)

# + {"slideshow": {"slide_type": "slide"}}
methods(+)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# # Type Inference 
#
# - the process of deducing the types of later values from the types of input values.

# + {"slideshow": {"slide_type": "subslide"}}
my_square(x) = x^2
@code_typed my_square(1)

# -

@code_typed my_square(1.0)

# Of course, if you know the type of your input, it is always best practice to specify it. 
my_int_square(x::Int64) = x^2
@code_typed my_int_square(1)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# # Cached Compilation  
#
# Compilation is cached and reused for future runs. 
# -

@time 2^30

@time 2^30

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide7.png)

# + {"slideshow": {"slide_type": "slide"}}
#macro expansion
@macroexpand 1+2
# -

#Abstract Syntac Tree
@code_lowered 1+2

#Julia Intermediate Representation
@code_typed 1+2

# + {"slideshow": {"slide_type": "subslide"}}
#LLVM Intermediate Representation
@code_llvm 1+2
# -

#Assembly
@code_native 1+2

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide8.png)
# -
# ![](xiaoqi-images/xiaoqi-why-julia-fast/Slide9.png)





# -*- coding: utf-8 -*-
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

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# <center> <img src=images/KeyFeaturesOverview.png width="200% > </center><br>

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# <center> <img src=images/JuliaSyntax.png width="200% > </center><br>

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# <center><div class="container-syntax">
#   <img src=images/JuliaSyntax2.png alt="Snow" style="width:100%;">
#   
#   <div class=link-1><a style="text-decoration:none" href="https://docs.julialang.org/en/v1/manual/noteworthy-differences/"><span style="color:#E5E5E5">Noteworthy</span></a></div>
#   
#   <div class=link-2><a style="text-decoration:none" href="https://datascience-enthusiast.com/R/R_Julia_cheat_sheet.html"><span style="color:#E5E5E5">Julia Vs R Comparison</span></a></div>
#   
#   <div class=link-3><a style="text-decoration:none" href="https://cheatsheets.quantecon.org/"><span style="color:#E5E5E5">MATLAB–Python–Julia</span></a></div>
#     
#   <div class=link-4><a style="text-decoration:none" href="https://sebastianraschka.com/blog/2014/matrix_cheatsheet_table.html"><span style="color:#E5E5E5">Matlab–Python-R–Julia</span></a></div>
#   
# </div></center>
#
#

# + {"slideshow": {"slide_type": "subslide"}}
function ∑(A)   
    total = zero(eltype(A))
    for a in A
        total += a
    end
    total
end

# + {"slideshow": {"slide_type": "fragment"}}
x = rand(collect(0:100), 10)
∑(x)

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# <center><div class="container-packages">
#   <img src=images/JuliaPackages.png alt="Snow" style="width:100%;">
#   
#   <div class=link-5><a style="text-decoration:none" href="https://pkg.julialang.org/docs/"><span style="color:white">Registered Packages Doc</span></a></div>
#   
#   <div class=link-6><a style="text-decoration:none" href="http://localhost:8888/terminals/1"><span style="color:white">Example</span></a></div>
#   
#   
# </div></center>
#
#

# + {"slideshow": {"slide_type": "subslide"}, "cell_type": "markdown"}
# <center> <img src=images/JuliaPackages2.png width="200% > </center><br>

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# <center> <img src=images/LanguageBinding.png width="200% > </center><br>

# + {"slideshow": {"slide_type": "slide"}, "cell_type": "markdown"}
# <center> <img src=images/benchmarks1.png width="200% > </center><br>

# + {"slideshow": {"slide_type": "subslide"}}
versioninfo()

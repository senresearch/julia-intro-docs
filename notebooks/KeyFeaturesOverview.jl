# -*- coding: utf-8 -*-
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

# + [markdown] {"slideshow": {"slide_type": "slide"}, "tags": []}
# <center> <img src=images/KeyFeaturesOverview.png width="200%" > </center><br>

# + [markdown] {"slideshow": {"slide_type": "slide"}, "tags": []}
# <center> <img src=images/JuliaSyntax.png width="200%" > </center><br>

# + {"slideshow": {"slide_type": "subslide"}}
function MySum(x::Vector{Float64})  
    total = 0.0
    for i in 1:length(x)
        total += x[i]
    end
    total
end

# + {"slideshow": {"slide_type": "-"}}
a = randn(100)
MySum(a)

# + {"slideshow": {"slide_type": "subslide"}}
# Notes: No extra Package to be installed to write with symbol character.
function ∑(X)   
    total = zero(eltype(X))
    for xᵢ in X
        total += xᵢ
    end
    total
end

# + {"slideshow": {"slide_type": "-"}}
a = randn(100)
∑(a)

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# ### Matlab, Python and Julia syntax comparison
# <center><img src=images/mpjComp1.png alt="Cheat sheet" style="width:80%;"></center>

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# ### Matlab, Python and Julia syntax comparison
# <center><img src=images/mpjComp2.png alt="Cheat sheet" style="width:80%;"></center>

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
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

# + [markdown] {"slideshow": {"slide_type": "slide"}}
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

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# <center> <img src=images/JuliaPackages2.png width="200%" > </center><br>

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# <center> <img src=images/LanguageBinding.png width="200%" > </center><br>

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# <center> <img src=images/benchmarks1.png width="200%" > </center><br>
# + [markdown] {"slideshow": {"slide_type": "slide"}}
# <center> <img src=images/JuliaTypes.png width="200%" > </center><br>


# + [markdown] {"slideshow": {"slide_type": "slide"}}
# <center> <img src=images/OOJulia.png height= "1000px" > </center><br>

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# In more conventional object oriented languages like C++, classes could include functions (and methods) in data type definition. The  main difference with Julia is that methods do not belong to any object. The concept of the object orientation in Julia is that functions operate on data, and they are not part of the data.

# + [markdown] {"slideshow": {"slide_type": "fragment"}}
# Objects in Julia can only be inherited from Abstract types. This is similar to interfaces in Java, classes containing pure virtual methods in C++, or abstract classes in Python. 

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
#
# ### Object orientation analogy between Python and Julia
#
# ---
#
#
#
#
# | Python | Julia|
# |:-------|:-----|
# |Class<br>class Lion:   <br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; family = "Felidae"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def \__init\__\(self, name\):<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  self\.name = name<br> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def sounds\(self\):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print\(self.name, "roars."\) <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def description\(self\):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message = '\{\} is a lion from the family of \{\}.'<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print(message.format(self.name, self.family))<br><br>class Cardinal:   <br>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; family = "Cardinalidae"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def \__init\__\(self, name\):<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  self\.name = name<br> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def sounds\(self\):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print\(self.name, "sings."\) <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  def description\(self\):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message = '\{\} is a bird from the family of \{\}.'<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print(message.format(self.name, self.family))<br><br>########################################### <br><br> bigCat = Lion\("Simba"\)<br> bird = Cardinal\("Red"\)<br><br>  bigCat.sounds\(\)<br> bigCat.description\(\)<br><br>  bird.sounds\(\)<br> bird.description\(\) <br> |abstract type Felidae end  <br>abstract type Cardinalidae end<br><br> struct Lion <:Felidae<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name::String<br>end <br><br>struct Cardinal <:Cardinalidae <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name::String<br>end <br><br>family\(x::Felidae\) = "Felidae"<br>family\(x::Cardinalidae\) = "Cardinalidae"<br><br> sounds\(animal::Lion\) =  println\(animal.name * " roars."\)<br>description\(animal::Lion\) = println\(animal.name * " is a lion from the family of " * family\(animal\) * "."\)<br><br> sounds\(animal::Cardinal\) = println\(animal.name * " sings."\)<br>description\(animal::Cardinal\) = println\(animal.name * " is a bird from the family of " * family\(animal\) * "."\)<br><br>########################################### <br><br>    bigCat = Lion\("Simba"\)<br> bird = Cardinal\("Red"\)<br><br>sounds\(bigCat\)<br> description\(bigCat\)<br><br>  sounds\(bird\)<br> description\(bird\) <br><br><br><br><br>
# |
#

# + {"slideshow": {"slide_type": "subslide"}}
# Create abstract type for feline and cardinalids
abstract type Felidae end
abstract type Cardinalidae end

# + {"slideshow": {"slide_type": "fragment"}}
# Composite type for lions
struct Lion <:Felidae
    name::String
end
# Composite type for cardinals
struct Cardinal <:Cardinalidae
    name::String
end

# + {"slideshow": {"slide_type": "fragment"}}
# Methods returning species family name
# Feline
family(x::Felidae) = "Felidae"
# Cardinalids
family(x::Cardinalidae) = "Cardinalidae"

# + {"slideshow": {"slide_type": "fragment"}}
# Methods associated with the Lion and Cardinal types
# Lion methods
sounds(animal::Lion) =  println(animal.name * " roars.")
description(animal::Lion) = println(animal.name * " is a lion from the family of " * family(animal) * ".")
# Cardinal methods
sounds(animal::Cardinal) = println(animal.name * " roars.")
description(animal::Cardinal) = println(animal.name * " is a bird from the family of " * family(animal) * ".")

# + {"slideshow": {"slide_type": "subslide"}}
bigCat = Lion("Simba")
bird = Cardinal("Red");

# + {"slideshow": {"slide_type": "fragment"}}
sounds(bigCat) 
description(bigCat) 

# + {"slideshow": {"slide_type": "fragment"}}
sounds(bird) 
description(bird) 

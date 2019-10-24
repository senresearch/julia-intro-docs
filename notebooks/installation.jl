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

# # Julia and IDE Installation
#
# ---
#
# To dive into the world of Julia, we are suggesting you to set up your environment with the necessary development tools and packages/libraries.   
# We are recommending Jupyter notebook as a development environment for this introduction in Julia since we will present Julia examples in a notebook format. Jupyter is userfriendly and useful for fast experimenting.    
# As an alternative environment for Julia, we advise you to install JuliaPro, from Julia Computing. JuliaPro is free to download and come with already preloaded libraries. JupiaPro, in some way, is analog to RStudio with R. But we recommend to stick with the notebook if possible. Let's look at how we can set up the Julia environment.
#
# ## Jupyter Notebook environment (recommended):
# #### Installing Julia
# * Download the current stable release Julia (v1.2.0) for your specific operating system (OS) from here: https://julialang.org/downloads/
# * Follow the platform-specific instructions to install Julia on your OS from here: https://julialang.org/downloads/platform.html
# * If you have done everything correctly, you could launch Julia prompt from:
#     * Win OS: Right click the Julia shortcut, run as admin:   
#     
#     </br><center> <img src=images/windowsJulia.png  width="500"/> </center>
#     * Mac OS: Go to launchpad, find Julia and run it:   
#     
#     </br><center> <img src=images/macJulia.png  width="500"/> </center>
#     * Linux: run `julia` from the terminal.    
#     <br> 
#     
# * You'll get a Julia prompt similar to this image:    
#     <br><center> <img src=images/terminal.png  width="500"/> </center><br>
#
# **Notes:** To exit from Julia terminal, you can run the command `exit()`.
#
# #### Installing Julia kernel for Jupyter Notebook
# The following steps are identical if you have already installed Jupyter or not.
#
# * Go to the Julia prompt and type the following code  
# ```julia
#  julia> using Pkg
#  julia> Pkg.add(“IJulia”)
# ```
# <br><center> <img src=images/pkgAddIJulia.png  width="500"/> </center><br>
#     If you don't have Jupyter already installed, it will prompt you for whether it should install Conda. Hit enter to have it use the Conda.jl package to install a minimal Python+Jupyter distribution (via Miniconda) that is private to Julia (not in your PATH).
#
# * After you installed IJulia successfully, you can type the following code to run it:
# ```julia
#  julia> using IJulia 
#  julia> notebook()
# ```
# <br><center> <img src=images/notebookJulia.png  width="500"/> </center><br>
#
# **Notes:** By default, the notebook “dashboard” opens in your home directory ( homedir() ), but you can open the dashboard in a different directory with notebook(dir=”/some/path”).
#
#
# * At this stage, you should be able to open Jupyter and use notebook. For futher information about Jupyter, please go to the documention website of Jupyter: https://jupyter-notebook.readthedocs.io/en/stable/notebook.html
#
# ## JuliaPro environment (alternative IDE):
# #### Installing JuliaPro
#
# The best alternative way to get all the capabilities from the current stable release Julia (v1.2.0) language in a convenient environment
# is to install JuliaPro from Julia Computing. JuliaPro is a free bundled
# distribution of Atom and Juno and it comes with extra material, including a profiler and many
# useful packages. The webpage of Julia Computing provides with
# more detailed installation instructions for your OS and the different ways in which you can
# interact with Julia, from here : https://juliacomputing.com/products/juliapro.
#
# ---
#
# # Installing Julia Packages
# A simple way of installing any package in Julia is using the command Pkg.add(). We prepared a julia script that will install the packages that will be used in the examples. Please run the following code in your Julia prompt:
#
# ```julia
# julia> include(download("preloadPackages.jl"))
# ```
#

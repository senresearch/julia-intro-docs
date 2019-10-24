
#=
preloadPackages.jl add a list of packages to the Julia environment.
=#

# Load Pkg package
using Pkg

# Install ProgressMeter package if it is not already installed
if Base.find_package("ProgressMeter") == nothing
        Pkg.add("ProgressMeter");
end

# Load ProgressMeter package
using ProgressMeter

# Create a list of packages to install
pkgList = ["CSV", "Plots", "DataFrames", "GLM",
           "PlotlyJS", "BenchmarkTools", "Calculus",
            "PyCall", "RCall", "Conda"];

n = length(pkgList)

# Install each package if necessary
@showprogress "Adding packages..." for i in 1:n
    if Base.find_package(pkgList[i]) == nothing
        Pkg.add(pkgList[i]);
    end
    sleep(0.1)
end


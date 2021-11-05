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

# + [markdown] tags=[]
# # Deep Learning with `Flux.jl`
# ---
# -

# The purpose of this notebook is to showcase one of the most popular deep learning framework in Julia: `Flux.jl`. 
#    
#    
# *References for this notebook:*
# *  Flux Neural Network tutorial: [Deep Learning with Julia](https://medium.com/coffee-in-a-klein-bottle/deep-learning-with-julia-e7f15ad5080b)(DSB)
# *  Flux Neural Network example: [Deep learning on "the iris data-set" in Julia](https://dev.to/bionboy/deep-learning-on-the-iris-data-set-in-julia-3pbe)(Luke Floden)

# + [markdown] slideshow={"slide_type": "subslide"}
# ## Outline of this notebook
#
#
# - Calling python built-in function 
# - Calling python hand-written function 
# - Importing python libraries
# - Calling R built-in function
# - Calling R hand-written function
# -

# ## Libraries

# Packages
using Plots
using Statistics, Random
using Flux
using RDatasets

# External source
include("notebookFormatting.jl");

# ## Load data set

# We will use the "Iris" data set that contains 150 samples iris flower. This data set was originally introduced by the British statistician and biologist Ronald Fisher in his 1936. The variables in each sample are defined as:
# * length of the iris petal in centimeter
# * length of the iris sepal in centimeter
# * width of the iris petal in centimeter
# * width of the iris sepal in centimeter
# * species of iris (*Setosa, Virginica, Versicolor*)   
#
# ![](images/iris-278x300.png)   
#
# Iris features illustrated    
#
# credits to https://gallery.azure.ai/Experiment/Classify-Iris-Dataset-using-Decision-Forest-1

# Load Data
iris = dataset("datasets", "iris");

names(iris)

# + tags=[] jupyter={"outputs_hidden": true}
dfSpecies = groupby(iris, :Species);
dfSpecies
# -

# ### Visualizations

scatter(title="Length vs width", xlabel = "Length", ylabel="Width",
        iris.SepalLength, iris.SepalWidth,  color="blue", label="sepal")
scatter!(iris.PetalLength, iris.PetalWidth, color="red", label="petal", 
         legend = :outertopright, markerstrokewidth = 0)

# Convert df to array
data = convert(Array, iris)

Random.seed!(123);    
# Shuffle
data = data[shuffle(1:end), :];

# train/test split
train_test_ratio = .7
idx = Int(floor(size(iris, 1) * train_test_ratio))
data_train = data[1:idx,:]
data_test = data[idx+1:end, :];

# Get feature vectors
get_feat(d) = transpose(convert(Array{Float32},d[:, 1:end-1]))
x_train = get_feat(data_train)
x_test = get_feat(data_test)

# One hot labels
#   onehot(d) = [Flux.onehot(v, unique(df.class)) for v in d[:,end]]
onehot(d) = Flux.onehotbatch(d[:,end], unique(iris.Species))
y_train = onehot(data_train)
y_test = onehot(data_test)

# ## Creating the Neural Network

function NeuralNetwork()
    return Chain(
            # layer 1: 4 inputs, 8 outputs, 
            #          activation function: relu(Rectified Linear Unit function f(x) = max(0, x))
            Dense(4, 8,relu),
            # layer 2: 8 inputs, 3 outputs, 
            #          activation function: soft max
            Dense(8,3,softmax)
            )
end

# ## Train model

# Create batches by generating an object that iterates over mini-batches of data, 
# each mini-batch containing batchsize observations 
# (except possibly the last one).
data = Flux.Data.DataLoader((X, Y'), batchsize=100,shuffle=true);

batch_size= 1
train_dl = Flux.Data.DataLoader((x_train, y_train), batchsize=batch_size, shuffle=true)
test_dl = Flux.Data.DataLoader((x_test, y_test), batchsize=batch_size)

# Define our model
m = NeuralNetwork()
# Define optimization algorithm
# Gradient descent with a learning η = 0.05
lr = 0.01
opt  = ADAM(lr, (0.9, 0.999))
# Define loss function
loss(x, y) = Flux.Losses.logitbinarycrossentropy(model(x), y) # m(x), predicted values;

# ### Training Method 1

# Declare what parameters are going to be trained:

# we can select what specific layers need to be trained, useful for transfer learning.
ps = Flux.params(m);

# Define how many epochs will be used:    

# hyperparameter that defines the number of times that a learning algorithm will handle the entire training data set.
numEpochs = 30;

# Training:

for i in 1:numEpochs
    Flux.train!(loss, ps, data, opt)
end

outputModel = [mean(m(real)) mean(m(fake))]
println(round.(outputModel; digits = 4)) # Print model prediction

# ### Training Method 2

# +
m2    = NeuralNetwork()
epochs = 20
loss2(x, y) = sum(Flux.Losses.binarycrossentropy(m2(x), y)) # m(x), predicted values
for epoch = 1:epochs
    for batch in data
        # compute gradient according to parameters values and 
        # apply results to the loss function for the batch d
        gs = Flux.gradient(Flux.params(m2)) do
            l = loss2(batch...)
        end
        # update the new parameters values according the gradients from 
        # the last iteration.
        Flux.Optimise.update!(opt, Flux.params(m2), gs)
    end
end

outputModel = [mean(m2(real)) mean(m2(fake))]
println(round.(outputModel; digits = 4)) # Print model prediction

# -

fieldnames(typeof(data))

# ## Results Visualization

scatter(real[1,1:100],real[2,1:100],zcolor=m(real)')
scatter!(fake[1,1:100],fake[2,1:100],zcolor=m(fake)',legend=false)

scatter(real[1,1:100],real[2,1:100],zcolor=m2(real)')
scatter!(fake[1,1:100],fake[2,1:100],zcolor=m2(fake)',legend=false)



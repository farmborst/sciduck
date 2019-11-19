using Pkg

Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("PyCall")
Pkg.add("PyPlot")
Pkg.add("IJulia")
using IJulia
IJulia.default_jupyter_data_dir()=ENV["JUPYTER_IPYKERNEL"]
kernelpath = IJulia.installkernel("Julia")
mv(kernelpath, split(kernelpath, "-")[1])
Pkg.add("DataFrames")
Pkg.add("DifferentialEquations")
Pkg.add("TensorFlow")
Pkg.add("Gadfly")
Pkg.add("JuMP")
Pkg.add("Optim")
Pkg.add("Turing")
Pkg.add("Interact")

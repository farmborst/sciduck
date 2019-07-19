using Pkg

ENV["PYTHON"] = "/opt/python/venv_python3.7.4/bin/python"
ENV["JUPYTER"] = "/opt/python/venv_python3.7.4/bin/jupyter"

Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("PyCall")
Pkg.add("PyPlot")
Pkg.add("IJulia")
using IJulia
IJulia.default_jupyter_data_dir()="/opt/python/venv_python3.7.4/share/jupyter"
IJulia.installkernel("Julia")
Pkg.add("DataFrames")
Pkg.add("DifferentialEquations")
Pkg.add("TensorFlow")
Pkg.add("Gadfly")
Pkg.add("JuMP")
Pkg.add("Optim")
Pkg.add("Turing")
Pkg.add("Interact")

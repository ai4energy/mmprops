# 第一英里检查：水状态点与饱和态。
#
#     export MMPROPS_BIN=/path/to/mmprops
#     julia -e 'using Pkg; Pkg.add(url="https://github.com/ai4energy/MMProps.jl")'
#     julia quickstart/julia_quickstart.jl

using MMProps

water = props("water", "300 K", "1 bar")
println("rho = ", water.values["rho"], " ", water.units["rho"])
println("h   = ", water.values["h"], " ", water.units["h"])

boiling = sat("water", "373.15 K")
println("psat = ", boiling.values["psat"], " ", boiling.units["psat"])

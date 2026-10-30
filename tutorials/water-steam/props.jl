# 水蒸汽与二元相包络：Julia 客户端一次性调用。
#
#     export MMPROPS_HOME=/path/to/mmprops-academic-0.6.0-linux-x86_64
#     julia props.jl "$MMPROPS_HOME"

using MMProps

home = length(ARGS) >= 1 ? ARGS[1] : get(ENV, "MMPROPS_HOME", ".")
binary = joinpath(home, "mmprops")
isfile(binary) || error("找不到引擎：$binary（把 MMPROPS_HOME 指向解包后的学术版目录）")

water = props("water", "300 K", "1 bar"; binary = binary)
println("rho  = ", round(water.values["rho"]; digits = 6), " ", water.units["rho"])
println("h    = ", round(water.values["h"]; digits = 6), " ", water.units["h"])

boiling = sat("water", "373.15 K"; binary = binary)
println("psat = ", round(boiling.values["psat"]; digits = 6), " ", boiling.units["psat"])

two_phase = flash("water"; p = "1 bar", h = "1000 kJ/kg", binary = binary)
println("flash: T = ", round(two_phase.values["t"]; digits = 6),
        " K, x = ", round(two_phase.values["x"]; digits = 6))

point = vle("bubble", ["methane", "ethane"], "220 K"; x = [0.5, 0.5], binary = binary)
println("VLE: p = ", round(point.p; digits = 3), " Pa, y1 = ", round(point.y[1]; digits = 6))

curve = envelope(["methane", "ethane"], "220 K"; points = 5, binary = binary)
println("包络: ", length(curve.rows), " 行（示例 x1/y1 = ",
        round(curve.rows[1]["x1"]; digits = 3), "/",
        round(curve.rows[1]["y1"]; digits = 6), "）")

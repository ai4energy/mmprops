# 十分钟跑通水蒸汽与二元相包络

目标：用学术版 MMPROPS 做四类计算——水状态点、饱和态、闪蒸、甲烷-乙烷 VLE 与
T-x-y 包络；分别走 **命令行**、**Python 客户端**、**Julia 客户端**。

## 准备

```bash
tar -xzf mmprops-academic-0.6.0-linux-x86_64.tar.gz
export MMPROPS_HOME="$PWD/mmprops-academic-0.6.0-linux-x86_64"
"$MMPROPS_HOME/mmprops" --version
```

数据包默认使用内嵌基线；自定义数据包用 `--data DIR` 或 `MMPROPS_DATA`。

## 命令行

```bash
# 水状态点：300 K、1 bar
"$MMPROPS_HOME/mmprops" props --fluid water --t "300 K" --p "1 bar" --format json

# 饱和态：373.15 K
"$MMPROPS_HOME/mmprops" sat --fluid water --t "373.15 K" --format json

# 闪蒸：1 bar、1000 kJ/kg
"$MMPROPS_HOME/mmprops" flash --fluid water --spec ph --p "1 bar" \
  --h "1000 kJ/kg" --format json

# 二元 VLE 泡点：甲烷/乙烷，220 K，x1 = 0.5
"$MMPROPS_HOME/mmprops" vle --kind bubble --components methane,ethane \
  --x 0.5,0.5 --t "220 K" --format json

# T-x-y 包络
"$MMPROPS_HOME/mmprops" envelope --components methane,ethane --t "220 K" \
  --points 5 --format json
```

参考值（本机实测）：

| 量 | 值 |
| --- | --- |
| 水 `rho`（300 K / 1 bar） | `996.556338 kg/m3` |
| 水 `h` | `112653.679689 J/kg` |
| 水 `psat`（373.15 K） | `101417.996368 Pa` |
| 闪蒸 `t` / `x` | `372.755929 K` / `0.258033` |
| VLE `p` / `y1`（220 K） | `3993218.99 Pa` / `0.847911` |

也可以是脚本：

```bash
sh run_cli.sh "$MMPROPS_HOME"
```

## Python

```bash
pip install git+https://github.com/ai4energy/mmprops-python
python props.py "$MMPROPS_HOME"
```

```python
from mmprops import flash, props, sat, vle

water = props("water", "300 K", "1 bar", binary=".../mmprops")
print(water.values["rho"], water.units["rho"])

boiling = sat("water", "373.15 K", binary=".../mmprops")
print(boiling.values["psat"])

two_phase = flash("water", p="1 bar", h="1000 kJ/kg", binary=".../mmprops")
print(two_phase.values["t"], two_phase.values["x"])

point = vle("bubble", ["methane", "ethane"], "220 K", x=[0.5, 0.5],
            binary=".../mmprops")
print(point.p, point.y)
```

## Julia

```julia
using Pkg
Pkg.add(url = "https://github.com/ai4energy/MMProps.jl")
```

```bash
julia props.jl "$MMPROPS_HOME"
```

## 说明

- 输入可以是纯数字（按 SI 解释），也可以是带单位字符串（`K`、`bar`、`kJ/kg` 等）。
- 两相下无定义的量（如两相 `rho`）返回 `null` / `None` / `nothing`，不是 0。
- 未收敛或超出范围会**响亮失败**，不会静默返回替代值；请把完整报错发到 issue。
- 学术版仅限非商业用途免费；商业用途需取得商业许可（mingtao.li@gmail.com）。

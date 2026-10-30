# MMPROPS — 物性引擎

面向能源系统与流程模拟的独立物性引擎：水/蒸汽（IF97）、制冷剂、二元混合物
（GERG），提供状态点物性、饱和态、闪蒸、VLE 泡/露点与 T-x-y 相包络。命令行输出
支持 `text` / `csv` / `json`（SI 值，带单位）。

本仓是 MMPROPS 的**公开主页**：学术版二进制、快速上手、授权说明与反馈入口。

## 安装

从 [最新发布](https://github.com/ai4energy/mmprops/releases) 下载学术版：

```bash
tar -xzf mmprops-academic-*-linux-x86_64.tar.gz
export PATH="$PWD/mmprops-academic-0.6.0-linux-x86_64:$PATH"
mmprops --version
```

包内包含 `mmprops` 命令行与 `libesml_mmprops_ffi.so`（供 ESML 引擎加载的物性后端）。
数据包默认使用内嵌基线；自定义数据包用 `--data DIR` 或 `MMPROPS_DATA`。

## 命令行

```bash
mmprops props  --fluid water --t "300 K" --p "1 bar" --format json
mmprops sat    --fluid water --t "373.15 K" --format json
mmprops flash  --fluid water --spec ph --p "1 bar" --h "1000 kJ/kg" --format json
mmprops vle    --kind bubble --components methane,ethane --x 0.5,0.5 --t "220 K" --format json
mmprops envelope --components methane,ethane --t "220 K" --points 21 --format csv
mmprops db props
```

输入数值可带单位（`K` / `C` / `F`、`Pa` / `kPa` / `MPa` / `bar` / `atm`、
`J/kg` / `kJ/kg`、`J/(kg·K)` / `kJ/(kg·K)`）；纯数字按 SI 解释。
未收敛或超范围会**响亮失败**，不会静默返回替代值。

## Python 与 Julia

两个客户端均为 **MIT**，通过公开的 JSON 命令行协议调用引擎，不含引擎代码：

```bash
pip install git+https://github.com/ai4energy/mmprops-python
```

```julia
using Pkg
Pkg.add(url = "https://github.com/ai4energy/MMProps.jl")
```

```python
from mmprops import props, sat

water = props("water", "300 K", "1 bar")
print(water.values["rho"], water.units["rho"])

boiling = sat("water", "373.15 K")
print(boiling.values["psat"])
```

```julia
using MMProps

water = props("water", "300 K", "1 bar")
println(water.values["rho"], " ", water.units["rho"])

boiling = sat("water", "373.15 K")
println(boiling.values["psat"])
```

## 教程与文档

- [十分钟跑通水蒸汽与二元相包络](tutorials/water-steam/README.md)：状态点 / 饱和 / 闪蒸 / VLE / 包络，命令行与两个客户端。
- [常见问题](FAQ.md)：学术/商业授权、流体、数据包、再分发。
- [排错](TROUBLESHOOTING.md)：找不到二进制、数据包、两相 `null`、未收敛。
- 烟测：`sh scripts/smoke.sh "$MMPROPS_HOME"`（状态点 / 饱和 / 闪蒸 / VLE / 数据库 / 响亮失败）。

## 版本

| 版本 | 能力 |
| --- | --- |
| **学术版**（公开下载） | 完整物性能力；学术/教学/个人非商业用途免费 |
| **商业版** | 同一能力的商业使用许可；商业用途需授权 |

学术版与商业版**共用同一二进制**，区别在授权范围：商业用途须取得商业许可。
客户端（Python / Julia）均为 MIT。

## 许可

- **Python 客户端** [`mmprops-python`](https://github.com/ai4energy/mmprops-python)：MIT。
- **Julia 客户端** [`MMProps.jl`](https://github.com/ai4energy/MMProps.jl)：MIT。
- **MMPROPS 引擎**（本仓分发的二进制）：**商业软件，不是 MIT**。学术/教学/个人
  非商业用途免费；商业用途需取得商业许可 —— **mingtao.li@gmail.com**。

完整条款见 [`LICENSE.md`](LICENSE.md)。

## 反馈与路线

- [提交反馈 issue](https://github.com/ai4energy/mmprops/issues/new?template=feedback.md)
- [Discussions](https://github.com/ai4energy/mmprops/discussions) 提问、投票与交流
- [Roadmap](ROADMAP.md)：按真实需求排序的下一步
- 邮件 **mingtao.li@gmail.com**

数值问题请附：模型/流体、状态点（T/p 或 p/h）、期望值与实际值、`mmprops --version`。
「第一英里」（安装、第一个查询、第一条报错）问题按 bug 处理。

## 状态

首发目标平台为 Linux x86_64。Windows / macOS 构建、更多流体与数据包在路线图上。

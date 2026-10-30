# 排错

## 找不到 `mmprops`

客户端按 `MMPROPS_BIN` → `PATH` 查找；显式路径不可执行会直接报错。

```bash
export MMPROPS_BIN=/path/to/mmprops-academic-0.6.0-linux-x86_64/mmprops
"$MMPROPS_BIN" --version
```

## 数据包

默认使用内嵌基线。自定义数据包：

```bash
mmprops --data /path/to/pack props --fluid water --t "300 K" --p "1 bar"
# 或 export MMPROPS_DATA=/path/to/pack
mmprops db pack          # 查看当前 pack_id@version#sha256
```

显式给出坏数据包会返回 code 5（响亮失败），不会退回内嵌基线。

## 两相下某量为 `null`

两相区没有单相定义的量（如 `rho`）返回 `null`（Python `None`、Julia `nothing`），
不是 0；请用 `h_l/h_v`、`s_l/s_v` 等两相量。

## 未收敛 / 超范围

引擎会**响亮失败**（非零退出 + 报错），不会静默返回替代值。请附完整命令与输出。
VLE 目前只支持**二元**混合物；`x`/`y` 长度必须与组分数一致。

## 单位

数值可直接给（按 SI），也可给字符串：`K` / `C` / `F`、`Pa` / `kPa` / `MPa` / `bar` /
`atm`、`J/kg` / `kJ/kg`、`J/(kg·K)` / `kJ/(kg·K)`。

## Python / Julia 客户端

- Python：`pip install git+https://github.com/ai4energy/mmprops-python@v0.1.0`
- Julia：`Pkg.add(url="https://github.com/ai4energy/MMProps.jl", rev="v0.1.0")`

## 报 bug 需要带什么

1. `mmprops --version`；
2. 完整命令与 `--format json` 输出；
3. 流体/组分、状态点、期望值；
4. 操作系统与 CPU 架构。

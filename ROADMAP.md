# Roadmap

原则：**反馈驱动，能力慢慢长**。按真实需求的频次排序。
投票/补充需求请到 [Discussions](https://github.com/ai4energy/mmprops/discussions)
或 [反馈页](https://www.ai4energy.cn/feedback/)。

## 已交付

- MMPROPS 学术版（Linux x86_64）：props / sat / flash / vle / envelope / db
- 水蒸汽 + 甲烷-乙烷教程、FAQ、排错、烟测
- MIT Python / Julia 客户端
- 物性后端 `libesml_mmprops_ffi.so`（ESML 引擎可直接加载）

## 下一步候选（按需求投票）

1. **Windows / macOS 二进制**
2. **更多流体与混合物** —— 按用户给出的工质/工况补
3. **数据包工具链** —— 打包、校验、版本化、回归夹具
4. **多组分 VLE** —— 目前只支持二元；按需求决定
5. **物性壳的更多语言** —— 已有 Python / Julia；其他语言按需求

## 不在公开范围

- 引擎源码；
- 商业版专属支持与 SLA（需授权）。

## 怎么影响这个列表

- 在 Discussions 里说明工质、状态点、精度要求；
- 开 issue 附输入与期望值/实际值；
- 邮件 mingtao.li@gmail.com。

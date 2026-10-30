#!/bin/sh
# 水蒸汽与二元相包络：命令行一次性计算。
#   sh run_cli.sh /path/to/mmprops-academic-0.6.0-linux-x86_64
set -eu
home=${1:?usage: run_cli.sh /path/to/mmprops-academic-0.6.0-linux-x86_64}
mm="$home/mmprops"
"$mm" props --fluid water --t "300 K" --p "1 bar" --format json
"$mm" sat --fluid water --t "373.15 K" --format json
"$mm" flash --fluid water --spec ph --p "1 bar" --h "1000 kJ/kg" --format json
"$mm" vle --kind bubble --components methane,ethane --x 0.5,0.5 --t "220 K" --format json
"$mm" envelope --components methane,ethane --t "220 K" --points 5 --format json

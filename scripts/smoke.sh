#!/bin/sh
# 学术版端到端烟测：状态点 / 饱和 / 闪蒸 / VLE / 数据库 / 响亮失败。
#   sh scripts/smoke.sh /path/to/mmprops-academic-0.6.0-linux-x86_64
set -eu
home=${1:?usage: smoke.sh /path/to/mmprops-academic-0.6.0-linux-x86_64}
mm="$home/mmprops"

"$mm" --version | grep -q '0.6.0'
echo "version: OK"

out=$("$mm" props --fluid water --t "300 K" --p "1 bar" --format json)
printf '%s' "$out" | grep -q '"rho"'
printf '%s' "$out" | grep -q '996.5563'
echo "water state point: OK"

out=$("$mm" sat --fluid water --t "373.15 K" --format json)
printf '%s' "$out" | grep -q '"psat"'
echo "water saturation: OK"

out=$("$mm" flash --fluid water --spec ph --p "1 bar" --h "1000 kJ/kg" --format json)
printf '%s' "$out" | grep -q '"name": "x"'
echo "flash: OK"

out=$("$mm" vle --kind bubble --components methane,ethane --x 0.5,0.5 --t "220 K" --format json)
printf '%s' "$out" | grep -q '"converged": true'
echo "VLE: OK"

"$mm" db props | grep -q 'T_sat_water'
echo "database: OK"

if "$mm" props --fluid no-such-fluid --t "300 K" --p "1 bar" >/dev/null 2>&1; then
    echo "FAIL: 未知流体没有响亮失败"; exit 1
fi
echo "loud failure: OK"

test -f "$home/libesml_mmprops_ffi.so"
echo "engine FFI present: OK"

echo "SMOKE OK"

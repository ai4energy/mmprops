"""水蒸汽与二元相包络：Python 客户端一次性调用。

    export MMPROPS_HOME=/path/to/mmprops-academic-0.6.0-linux-x86_64
    pip install git+https://github.com/ai4energy/mmprops-python
    python props.py "$MMPROPS_HOME"
"""

from __future__ import annotations

import os
import pathlib
import sys

from mmprops import envelope, flash, props, sat, vle


def main() -> None:
    home = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else os.environ.get("MMPROPS_HOME", "."))
    binary = home / "mmprops"
    if not binary.is_file():
        raise SystemExit(f"找不到引擎：{binary}（把 MMPROPS_HOME 指向解包后的学术版目录）")

    water = props("water", "300 K", "1 bar", binary=binary)
    print(f"rho  = {water.values['rho']:.6f} {water.units['rho']}")
    print(f"h    = {water.values['h']:.6f} {water.units['h']}")

    boiling = sat("water", "373.15 K", binary=binary)
    print(f"psat = {boiling.values['psat']:.6f} {boiling.units['psat']}")

    two_phase = flash("water", p="1 bar", h="1000 kJ/kg", binary=binary)
    print(f"flash: T = {two_phase.values['t']:.6f} K, x = {two_phase.values['x']:.6f}")

    point = vle("bubble", ["methane", "ethane"], "220 K", x=[0.5, 0.5], binary=binary)
    print(f"VLE: p = {point.p:.3f} Pa, y1 = {point.y[0]:.6f}")

    curve = envelope(["methane", "ethane"], "220 K", points=5, binary=binary)
    print(f"包络: {len(curve.rows)} 行（示例 x1/y1 = "
          f"{curve.rows[0]['x1']:.3f}/{curve.rows[0]['y1']:.6f}）")


if __name__ == "__main__":
    main()

"""第一英里检查：水状态点与饱和态。

    export MMPROPS_BIN=/path/to/mmprops
    pip install git+https://github.com/ai4energy/mmprops-python
    python quickstart/python_quickstart.py
"""

from __future__ import annotations

from mmprops import props, sat


def main() -> None:
    water = props("water", "300 K", "1 bar")
    print(f"rho = {water.values['rho']:.6f} {water.units['rho']}")
    print(f"h   = {water.values['h']:.6f} {water.units['h']}")

    boiling = sat("water", "373.15 K")
    print(f"psat = {boiling.values['psat']:.6f} {boiling.units['psat']}")


if __name__ == "__main__":
    main()

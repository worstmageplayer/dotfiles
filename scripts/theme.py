#!/usr/bin/env python3
"""Generate theme files from the Catppuccin palettes in palette/.

Usage:
    scripts/theme.py                # generate for the flavour named in palette/ACTIVE
    scripts/theme.py <flavour>      # set ACTIVE and generate (mocha|macchiato|frappe|latte)

Outputs one generated file per consumer, next to its config:

    quickshell/ThemeColors.qml
    waybar/color.css
    rofi/colors.rasi
    hypr/colors.conf          (sourced by hyprland.lua via hl.source)
    hypr/hyprlock-colors.conf (sourced by hyprlock.conf)
"""

import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
PALETTE_DIR = REPO / "palette"
ACTIVE_FILE = PALETTE_DIR / "ACTIVE"
FLAVOURS = ["mocha", "macchiato", "frappe", "latte"]

HEADER = """\
# !!! GENERATED FILE — DO NOT EDIT !!!
# Regenerate with: scripts/theme.py
"""

HEADER_QML = """\
// !!! GENERATED FILE — DO NOT EDIT !!!
// Regenerate with: scripts/theme.py
"""

HEADER_CSS = """\
/* !!! GENERATED FILE — DO NOT EDIT !!!
   Regenerate with: scripts/theme.py */
"""


def load(flavour: str) -> dict:
    path = PALETTE_DIR / f"{flavour}.json"
    data = json.loads(path.read_text())
    data["flavour"] = flavour
    return data


def write(path: Path, text: str) -> None:
    path.write_text(text)
    print(f"  wrote {path.relative_to(REPO)}")


# --- semantic roles shared by every generator -------------------------------
# Lavender is the accent everywhere; overlay0 stands in for muted gray.
def roles(c: dict) -> dict:
    return {
        # quickshell bar
        "bg":     c["base"],
        "fg":     c["text"],
        "hov":    c["lavender"],
        # waybar
        "base":   c["base"],
        "white":  c["text"],
        # rofi
        "bg":            c["mantle"],
        "bg_alpha":      "11",
        "fg":            c["text"],
        "accent":        c["lavender"],
        "red_dark":      c["maroon"],
        "red_light":     c["red"],
        "yellow_dark":   c["yellow"],
        "yellow_light":  c["rosewater"],
        "entry":         c["overlay0"],
        # hyprland borders
        "border_active":   c["lavender"],
        "border_inactive": c["overlay0"],
        # hyprlock
        "lock_outer": c["sapphire"],
        "lock_check": c["green"],
        "lock_fail":  c["red"],
        "lock_font":  c["overlay1"],
    }


def r(roles_dict: dict, key: str) -> str:
    return roles_dict[key].lstrip("#")


# --- generators ---------------------------------------------------------------

def gen_quickshell(p: dict) -> None:
    t = roles(p["colors"])
    body = f"""\
pragma Singleton
import QtQuick

QtObject {{
    property color colBg:  "{t['bg']}"
    property color colFg:  "{t['fg']}"
    property color colHov: "{t['hov']}"

    property string fontFamily: "JetBrainsMonoNLNerdFontPropo"
    property int fontSize: 16
}}
"""
    write(REPO / "quickshell" / "ThemeColors.qml", HEADER_QML.format(**p) + "\n" + body)


def gen_waybar(p: dict) -> None:
    t = roles(p["colors"])
    # primary1 keeps its old name for style.css compatibility but is now lavender.
    lines = [
        f"@define-color base {t['base']};",
        f"@define-color primary1 {t['hov']};",
        f"@define-color white {t['white']};",
    ]
    write(REPO / "waybar" / "color.css", HEADER_CSS.format(**p) + "\n" + "\n".join(lines) + "\n")


def gen_rofi(p: dict) -> None:
    t = roles(p["colors"])
    body = f"""* {{
    background:             {t['bg']}{t['bg_alpha']};
    foreground:             {t['fg']};
    accent:                 {t['accent']};

    yellow:                 {t['yellow_dark']};
    yellow-light:           {t['yellow_light']};
    red-dark:               {t['red_dark']};
    red-light:              {t['red_light']};

    entry-placeholder:      {t['entry']};
    selected-bg:            {t['accent']}45;
}}
"""
    header = "\n".join("// " + line for line in HEADER_QML.format(**p).strip().splitlines())
    header = header.replace("// // ", "// ")
    write(REPO / "rofi" / "colors.rasi", header + "\n" + body)


def gen_hypr(p: dict) -> None:
    t = roles(p["colors"])
    body = f"""\
general {{
    col.active_border   = rgba({r(t, 'border_active')}ee)
    col.inactive_border = rgba({r(t, 'border_inactive')}aa)
}}
"""
    write(REPO / "hypr" / "colors.conf", HEADER.format(**p) + "\n" + body)


def gen_hyprlock(p: dict) -> None:
    t = roles(p["colors"])
    body = f"""\
input-field {{
    outer_color = rgba({r(t, 'lock_outer')}ee)
    check_color = rgba({r(t, 'lock_check')}00)
    fail_color  = rgba({r(t, 'lock_fail')}00)

    font_color = rgb({r(t, 'lock_font')})
}}
"""
    write(REPO / "hypr" / "hyprlock-colors.conf", HEADER.format(**p) + "\n" + body)


GENERATORS = [
    gen_quickshell,
    gen_waybar,
    gen_rofi,
    gen_hypr,
    gen_hyprlock,
]


def main() -> int:
    args = sys.argv[1:]
    if len(args) > 1 or (args and args[0] not in FLAVOURS):
        print(f"usage: scripts/theme.py [{'|'.join(FLAVOURS)}]", file=sys.stderr)
        return 2

    if args:
        ACTIVE_FILE.write_text(args[0] + "\n")
        print(f"active flavour: {args[0]}")

    if not ACTIVE_FILE.exists():
        ACTIVE_FILE.write_text("mocha\n")
        print("active flavour: mocha (default)")
    flavour = ACTIVE_FILE.read_text().strip()

    p = load(flavour)
    print(f"generating theme files for {flavour}:")
    for gen in GENERATORS:
        gen(p)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

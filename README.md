# genoQs Octopus — Max for Live (WIP)

MIDI effect device: dict-backed state, JS engine, JSUI matrix, and a **packaged Live device** (`Octopus.amxd`).

## Quick start in Ableton

1. Keep **all** `.js` files in the **same folder** as `Octopus.amxd` (Max resolves `octopus_*.js` next to the device).
2. Drag **`Octopus.amxd`** onto a MIDI track (or use Places → your project folder).
3. If you change `octopus_ui_main.maxpat`, rebuild the device (below) or open the `.amxd` in Max and **Save**.

## Rebuild `Octopus.amxd` from the template

The `.amxd` format is Ableton’s `ampf` wrapper around embedded JSON. This repo builds it from Live’s stock **Max MIDI Effect** shell + our `octopus_ui_main.maxpat`.

```bash
cd /Users/macbook/Projects/genoqs-octopus-m4l
python3 tools/build_amxd.py
```

- Output: `Octopus.amxd`
- Backup of the raw template copy: `Octopus.amxd.bak-template` (safe to delete)
- If the script can’t find Live, edit `LIVE_APP` in `tools/build_amxd.py`.

## Lofi UI mock (tweak layout before hard-coding JSUI)

Open in a browser:

- `ui-mock/index.html`

Adjust the **CSS variables** in `:root` (faceplate, LED greens/reds, accent orange, panel size). When you like the proportions, mirror them in `octopus_matrix_ui.js` and Live presentation rects.

## Source files

| File | Role |
|------|------|
| `octopus_data.js` | Dict schema, defaults, small setters |
| `octopus_engine.js` | Tick engine, scheduling, chains, chords/strum |
| `octopus_scale.js` | Force-to-scale quantization |
| `octopus_matrix_ui.js` | JSUI matrix + PAGE/TRACK/STEP/GRID views |
| `octopus_ui.js` | Bridges `live.tab` → JSUI |
| `octopus_ui_main.maxpat` | Main patcher (also embedded into `Octopus.amxd`) |

## Note

`npm` / `package.json` are **not** required; this is Max JS, not Node.

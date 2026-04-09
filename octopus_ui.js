autowatch = 1;

// Simple UI controller: maps Live UI controls to JSUI + data model messages.
// Outlets:
// 0 -> to jsui (set_mode/select_track/select_step/set_attr/bang)

inlets = 1;
outlets = 2;

var modeNames = ["page", "track", "step", "grid"];

function msg_int(v) {
  // Default int input maps to mode index (from live.tab)
  mode_index(v);
}

function mode_index(i) {
  i = Math.max(0, Math.min(3, Math.round(Number(i) || 0)));
  outlet(0, "set_mode", modeNames[i]);
  outlet(0, "bang");
}

function select_track(i) {
  i = Math.max(0, Math.min(9, Math.round(Number(i) || 0)));
  outlet(0, "select_track", i);
  outlet(0, "bang");
}

function select_step(i) {
  i = Math.max(0, Math.min(15, Math.round(Number(i) || 0)));
  outlet(0, "select_step", i);
  outlet(0, "bang");
}

function set_attr(name) {
  outlet(0, "set_attr", String(name));
  outlet(0, "bang");
}


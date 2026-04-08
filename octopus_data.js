autowatch = 1;

/**
 * Octopus state is stored in a Max Dict named by STATE_DICT_NAME.
 * This file provides:
 * - deterministic default state creation
 * - schema enforcement (best-effort) + range clamping helpers
 * - small set of getters/setters for engine/UI
 *
 * NOTE: Max's JS runtime is not Node; avoid require(). Use include() from other JS files.
 */

var STATE_DICT_NAME = "octopus_state";

// ---------- Utilities ----------

function clampInt(v, min, max) {
  v = Math.round(Number(v));
  if (isNaN(v)) v = min;
  if (v < min) return min;
  if (v > max) return max;
  return v;
}

function clampFloat(v, min, max) {
  v = Number(v);
  if (isNaN(v)) v = min;
  if (v < min) return min;
  if (v > max) return max;
  return v;
}

function asBool(v) {
  return !!v;
}

function deepCopy(obj) {
  return JSON.parse(JSON.stringify(obj));
}

function ensureArrayLen(arr, len, fillValue) {
  if (!Array.isArray(arr)) arr = [];
  if (arr.length > len) arr = arr.slice(0, len);
  while (arr.length < len) arr.push(deepCopy(fillValue));
  return arr;
}

// ---------- Defaults (deterministic) ----------

function defaultGlobalScale() {
  return {
    enabled: false,
    root: 0,
    intervals: [0, 2, 4, 5, 7, 9, 11],
  };
}

function defaultPageScale() {
  return {
    enabled: false,
    locked: false,
    root: 60,
    intervals: [0, 2, 4, 5, 7, 9, 11],
  };
}

function defaultStep() {
  return {
    active: false,
    skip: false,
    pit_offset: 0,
    vel_offset: 0,
    len: 12, // 12 ticks = 1/16 at 192 PPQN
    len_multiplier: 1,
    sta_offset: 0,
    amt: 0,
    grv: 0,
    pos: 8,
    mcc_value: null,
    chords: [],
    polyphony: 1,
    ghost: false,
    hyperstep: null,
    strum: 0, // Phase 1: used by chord engine; 0..9 (negative supported in UI layer)
  };
}

function defaultTrack(trackIndex) {
  // Manual default PIT values for tracks 9..0:
  // C3, D3, E3, G3, A3, C5, D5, E5, G5, A5
  // Track indices in this spec are 0..9; we store same ordering as Octopus rows (0 bottom, 9 top).
  var pitsByIndex = [69, 67, 64, 62, 60, 57, 55, 52, 50, 48]; // A5,G5,E5,D5,C5,A3,G3,E3,D3,C3? (reverse)
  // Above mapping is easy to get wrong; store explicit map from manual list.
  var manual = [57, 55, 52, 50, 48, 60, 62, 64, 67, 69]; // index 0..9 = [C3,D3,E3,G3,A3,C5,D5,E5,G5,A5]

  return {
    pit: clampInt(manual[trackIndex] != null ? manual[trackIndex] : 60, 0, 127),
    vel: 100,
    len_factor: 8,
    sta_factor: 8,
    dir: 1,
    amt: 0,
    grv: 0,
    mcc: null, // null | 0..127 | "bend" | "pressure"
    mch: 1, // 1..16 port1, 17..32 port2
    multiplier: "1",
    paused: false,
    muted: false,
    soloed: false,
    chain_head: null,
    chain_members: [],
    chain_base: "individual", // "individual" | "head"
    program_change: 0,
    bank_change: null,
    transpose_mch: null,
    transpose_mode: "relative",
    steps: ensureArrayLen([], 16, defaultStep()),
  };
}

function defaultPage() {
  var tracks = [];
  for (var i = 0; i < 10; i++) tracks.push(defaultTrack(i));

  return {
    pit_offset: 0,
    vel_factor: 8,
    len: 16,
    sta: 1,
    scale: defaultPageScale(),
    cluster_mode: false,
    mute_pattern: ensureArrayLen([], 10, false),
    tracks: tracks,
  };
}

function defaultBank() {
  var pages = [];
  for (var i = 0; i < 16; i++) pages.push(defaultPage());
  return { pages: pages };
}

function defaultGrid() {
  var banks = [];
  for (var i = 0; i < 10; i++) banks.push(defaultBank());

  // page_sets: 16 slots, each an array of {bank,page} pairs
  var pageSets = [];
  for (var s = 0; s < 16; s++) pageSets.push([]);

  return {
    tempo_bpm: 120.0,
    midi_port1_channel: 1,
    active_page: { bank: 0, page: 0 },
    page_sets: pageSets,
    global_scale: defaultGlobalScale(),
    banks: banks,
    // routing mode: "octopus" | "fixed"
    midi_routing_mode: "octopus",
    fixed_routing: { base_channel_port1: 1, base_channel_port2: 1 },
  };
}

// ---------- Dict access ----------

function getStateDict() {
  return new Dict(STATE_DICT_NAME);
}

function reset_state() {
  var d = getStateDict();
  d.parse(JSON.stringify(defaultGrid()));
  outlet(0, "state_reset");
}

function ensure_state() {
  var d = getStateDict();
  if (!d.getkeys || d.getkeys() === null) {
    reset_state();
    return;
  }
  // Best-effort: if key missing, reset entire state for now.
  if (d.get("banks") == null || d.get("active_page") == null) {
    reset_state();
    return;
  }
  outlet(0, "state_ok");
}

function get_active_page() {
  var d = getStateDict();
  var ap = d.get("active_page");
  if (!ap) ap = { bank: 0, page: 0 };
  var bank = clampInt(ap.bank, 0, 9);
  var page = clampInt(ap.page, 0, 15);
  outlet(0, "active_page", bank, page);
}

function set_active_page(bank, page) {
  bank = clampInt(bank, 0, 9);
  page = clampInt(page, 0, 15);
  var d = getStateDict();
  d.set("active_page", { bank: bank, page: page });
  outlet(0, "active_page", bank, page);
}

function set_midi_routing_mode(mode) {
  var m = String(mode || "octopus").toLowerCase();
  if (m !== "octopus" && m !== "fixed") m = "octopus";
  var d = getStateDict();
  d.set("midi_routing_mode", m);
  outlet(0, "midi_routing_mode", m);
}

function set_fixed_routing(base_channel_port1, base_channel_port2) {
  var b1 = clampInt(base_channel_port1, 1, 16);
  var b2 = clampInt(base_channel_port2, 1, 16);
  var d = getStateDict();
  d.set("fixed_routing", { base_channel_port1: b1, base_channel_port2: b2 });
  outlet(0, "fixed_routing", b1, b2);
}

// Minimal setters used by early UI scaffolding.
function step_toggle(trackIndex, stepIndex) {
  trackIndex = clampInt(trackIndex, 0, 9);
  stepIndex = clampInt(stepIndex, 0, 15);
  var d = getStateDict();
  var ap = d.get("active_page") || { bank: 0, page: 0 };
  var path = [
    "banks",
    clampInt(ap.bank, 0, 9),
    "pages",
    clampInt(ap.page, 0, 15),
    "tracks",
    trackIndex,
    "steps",
    stepIndex,
    "active",
  ];
  var cur = d.get(path.join("::"));
  d.set(path.join("::"), !cur);
  outlet(0, "step_active", trackIndex, stepIndex, !cur);
}

function step_skip_toggle(trackIndex, stepIndex) {
  trackIndex = clampInt(trackIndex, 0, 9);
  stepIndex = clampInt(stepIndex, 0, 15);
  var d = getStateDict();
  var ap = d.get("active_page") || { bank: 0, page: 0 };
  var base = [
    "banks",
    clampInt(ap.bank, 0, 9),
    "pages",
    clampInt(ap.page, 0, 15),
    "tracks",
    trackIndex,
    "steps",
    stepIndex,
  ].join("::");
  var cur = d.get(base + "::skip");
  d.set(base + "::skip", !cur);
  outlet(0, "step_skip", trackIndex, stepIndex, !cur);
}

// ---------- Dump helpers ----------

function dump_page() {
  var d = getStateDict();
  var ap = d.get("active_page") || { bank: 0, page: 0 };
  var pageObj = d.get(
    ["banks", clampInt(ap.bank, 0, 9), "pages", clampInt(ap.page, 0, 15)].join("::")
  );
  outlet(0, "page_dump", JSON.stringify(pageObj));
}


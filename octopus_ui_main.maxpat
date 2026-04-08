{
  "patcher" : {
    "fileversion" : 1,
    "appversion" : {
      "major" : 9,
      "minor" : 0,
      "revision" : 0,
      "architecture" : "x64"
    },
    "rect" : [ 0.0, 0.0, 800.0, 520.0 ],
    "bglocked" : 0,
    "defrect" : [ 0.0, 0.0, 800.0, 520.0 ],
    "openrect" : [ 50.0, 50.0, 850.0, 570.0 ],
    "openinpresentation" : 1,
    "default_fontsize" : 12.0,
    "default_fontface" : 0,
    "default_fontname" : "Arial",
    "gridonopen" : 0,
    "gridsize" : [ 15.0, 15.0 ],
    "gridsnaponopen" : 0,
    "objectsnaponopen" : 0,
    "statusbarvisible" : 2,
    "toolbarvisible" : 1,
    "boxanimatetime" : 200,
    "enablehscroll" : 1,
    "enablevscroll" : 1,
    "devicewidth" : 800.0,
    "boxes" : [
      {
        "box" : {
          "id" : "dict-1",
          "maxclass" : "dict",
          "name" : "octopus_state",
          "embed" : 1,
          "numinlets" : 1,
          "numoutlets" : 2,
          "patching_rect" : [ 20.0, 20.0, 150.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "transport-1",
          "maxclass" : "newobj",
          "text" : "transport @clocksource host",
          "numinlets" : 1,
          "numoutlets" : 9,
          "patching_rect" : [ 190.0, 20.0, 120.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-gettempo-1",
          "maxclass" : "message",
          "text" : "bang",
          "patching_rect" : [ 320.0, 20.0, 50.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "loadbang-1",
          "maxclass" : "loadbang",
          "patching_rect" : [ 320.0, 60.0, 30.0, 30.0 ]
        }
      },
      {
        "box" : {
          "id" : "qmetro-1",
          "maxclass" : "newobj",
          "text" : "qmetro 50",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 360.0, 60.0, 80.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "toggle-1",
          "maxclass" : "toggle",
          "patching_rect" : [ 450.0, 60.0, 20.0, 20.0 ]
        }
      },
      {
        "box" : {
          "id" : "expr-tps-1",
          "maxclass" : "expr",
          "text" : "($f1/60.)*192.",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 380.0, 20.0, 110.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "sig-tps-1",
          "maxclass" : "sig~",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 500.0, 20.0, 50.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "phasor-1",
          "maxclass" : "phasor~",
          "numinlets" : 2,
          "numoutlets" : 1,
          "patching_rect" : [ 560.0, 20.0, 70.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "gt-1",
          "maxclass" : ">~",
          "text" : ">~ 0.999",
          "numinlets" : 2,
          "numoutlets" : 1,
          "patching_rect" : [ 640.0, 20.0, 70.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "edge-1",
          "maxclass" : "edge~",
          "numinlets" : 1,
          "numoutlets" : 2,
          "patching_rect" : [ 720.0, 20.0, 60.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "gate-1",
          "maxclass" : "gate",
          "text" : "gate 1",
          "numinlets" : 2,
          "numoutlets" : 1,
          "patching_rect" : [ 720.0, 60.0, 60.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-tick-1",
          "maxclass" : "message",
          "text" : "tick",
          "patching_rect" : [ 720.0, 100.0, 45.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "print-tick-1",
          "maxclass" : "print",
          "text" : "octopus_tick",
          "patching_rect" : [ 720.0, 140.0, 120.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "js-data-1",
          "maxclass" : "js",
          "text" : "octopus_data.js",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 20.0, 60.0, 150.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "jsui-matrix-1",
          "maxclass" : "jsui",
          "filename" : "octopus_matrix_ui.js",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 20.0, 190.0, 520.0, 320.0 ],
          "presentation" : 1,
          "presentation_rect" : [ 0.0, 0.0, 520.0, 520.0 ]
        }
      },
      {
        "box" : {
          "id" : "js-ui-1",
          "maxclass" : "js",
          "text" : "octopus_ui.js",
          "numinlets" : 1,
          "numoutlets" : 2,
          "patching_rect" : [ 560.0, 190.0, 140.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "live-tab-mode-1",
          "maxclass" : "live.tab",
          "numinlets" : 1,
          "numoutlets" : 2,
          "patching_rect" : [ 560.0, 230.0, 220.0, 22.0 ],
          "presentation" : 1,
          "presentation_rect" : [ 540.0, 10.0, 240.0, 22.0 ],
          "parameter_enable" : 1,
          "items" : [ "PAGE", "TRACK", "STEP", "GRID" ]
        }
      },
      {
        "box" : {
          "id" : "live-tab-routing-1",
          "maxclass" : "live.tab",
          "numinlets" : 1,
          "numoutlets" : 2,
          "patching_rect" : [ 560.0, 260.0, 220.0, 22.0 ],
          "presentation" : 1,
          "presentation_rect" : [ 540.0, 40.0, 240.0, 22.0 ],
          "parameter_enable" : 1,
          "items" : [ "OCTOPUS_MCH", "FIXED_PER_TRACK" ]
        }
      },
      {
        "box" : {
          "id" : "sel-routing-1",
          "maxclass" : "newobj",
          "text" : "sel 0 1",
          "numinlets" : 1,
          "numoutlets" : 3,
          "patching_rect" : [ 560.0, 290.0, 70.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-routing-octo-1",
          "maxclass" : "message",
          "text" : "set_midi_routing_mode octopus",
          "patching_rect" : [ 640.0, 290.0, 200.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-routing-fixed-1",
          "maxclass" : "message",
          "text" : "set_midi_routing_mode fixed",
          "patching_rect" : [ 640.0, 320.0, 190.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-init-1",
          "maxclass" : "message",
          "text" : "ensure_state",
          "patching_rect" : [ 190.0, 60.0, 90.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "msg-reset-1",
          "maxclass" : "message",
          "text" : "reset_state",
          "patching_rect" : [ 290.0, 60.0, 80.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "print-1",
          "maxclass" : "print",
          "text" : "octopus_data",
          "patching_rect" : [ 20.0, 100.0, 120.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "js-engine-1",
          "maxclass" : "js",
          "text" : "octopus_engine.js",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 190.0, 100.0, 150.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "print-engine-1",
          "maxclass" : "print",
          "text" : "octopus_engine",
          "patching_rect" : [ 190.0, 140.0, 140.0, 22.0 ]
        }
      },
      {
        "box" : {
          "id" : "prepend-ts-1",
          "maxclass" : "newobj",
          "text" : "prepend transport_state",
          "numinlets" : 1,
          "numoutlets" : 1,
          "patching_rect" : [ 350.0, 100.0, 160.0, 22.0 ]
        }
      }
    ],
    "lines" : [
      { "patchline" : { "source" : [ "loadbang-1", 0 ], "destination" : [ "msg-init-1", 0 ] } },
      { "patchline" : { "source" : [ "loadbang-1", 0 ], "destination" : [ "toggle-1", 0 ] } },
      { "patchline" : { "source" : [ "toggle-1", 0 ], "destination" : [ "qmetro-1", 0 ] } },
      { "patchline" : { "source" : [ "qmetro-1", 0 ], "destination" : [ "msg-gettempo-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-gettempo-1", 0 ], "destination" : [ "transport-1", 0 ] } },
      { "patchline" : { "source" : [ "transport-1", 6 ], "destination" : [ "gate-1", 1 ] } },
      { "patchline" : { "source" : [ "transport-1", 4 ], "destination" : [ "expr-tps-1", 0 ] } },
      { "patchline" : { "source" : [ "expr-tps-1", 0 ], "destination" : [ "sig-tps-1", 0 ] } },
      { "patchline" : { "source" : [ "sig-tps-1", 0 ], "destination" : [ "phasor-1", 0 ] } },
      { "patchline" : { "source" : [ "phasor-1", 0 ], "destination" : [ "gt-1", 0 ] } },
      { "patchline" : { "source" : [ "gt-1", 0 ], "destination" : [ "edge-1", 0 ] } },
      { "patchline" : { "source" : [ "edge-1", 0 ], "destination" : [ "gate-1", 0 ] } },
      { "patchline" : { "source" : [ "gate-1", 0 ], "destination" : [ "msg-tick-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-tick-1", 0 ], "destination" : [ "print-tick-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-tick-1", 0 ], "destination" : [ "js-engine-1", 0 ] } },
      { "patchline" : { "source" : [ "transport-1", 6 ], "destination" : [ "prepend-ts-1", 0 ] } },
      { "patchline" : { "source" : [ "prepend-ts-1", 0 ], "destination" : [ "js-engine-1", 0 ] } },
      { "patchline" : { "source" : [ "js-engine-1", 0 ], "destination" : [ "print-engine-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-init-1", 0 ], "destination" : [ "js-data-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-reset-1", 0 ], "destination" : [ "js-data-1", 0 ] } },
      { "patchline" : { "source" : [ "js-data-1", 0 ], "destination" : [ "print-1", 0 ] } },
      { "patchline" : { "source" : [ "jsui-matrix-1", 0 ], "destination" : [ "js-data-1", 0 ] } },
      { "patchline" : { "source" : [ "live-tab-mode-1", 0 ], "destination" : [ "js-ui-1", 0 ] } },
      { "patchline" : { "source" : [ "js-ui-1", 0 ], "destination" : [ "jsui-matrix-1", 0 ] } },
      { "patchline" : { "source" : [ "live-tab-routing-1", 0 ], "destination" : [ "sel-routing-1", 0 ] } },
      { "patchline" : { "source" : [ "sel-routing-1", 0 ], "destination" : [ "msg-routing-octo-1", 0 ] } },
      { "patchline" : { "source" : [ "sel-routing-1", 1 ], "destination" : [ "msg-routing-fixed-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-routing-octo-1", 0 ], "destination" : [ "js-data-1", 0 ] } },
      { "patchline" : { "source" : [ "msg-routing-fixed-1", 0 ], "destination" : [ "js-data-1", 0 ] } }
    ]
  }
}


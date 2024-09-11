target = "altera"
action = "synthesis"

syn_family  = "Cyclone 10 GX"
syn_device  = "10cx220Y"
syn_grade   = "I5G"
syn_package = "F780"

syn_top     = "si5340_config_loader"
syn_project = "si5340_config_loader"

syn_tool = "quartus"

quartus_preflow = "quartus_preflow.tcl"

files = [
    "quartus_preflow.tcl",
    "si5340_config_loader.sdc",
]

modules = {
    "local" : [
        "../",
    ]
}

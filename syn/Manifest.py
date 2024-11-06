target = "altera"
action = "synthesis"

syn_family  = "Cyclone IV E"
syn_device  = "EP4CE6"
syn_grade   = "C8"
syn_package = "E22"

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

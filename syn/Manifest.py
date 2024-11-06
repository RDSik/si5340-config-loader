target = "altera"
action = "synthesis"

syn_family  = "Cyclone IV E"
syn_device  = "EP4CE6"
syn_grade   = "E22"
syn_package = "C8N"

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

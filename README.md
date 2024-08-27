# Usage

## Doc

[Si5341, Si5340 Reference Manual](docs/Si5341-40-D-RM.pdf)

## Dependencies 

`cocotb`, `pytest`, `python`, `chocolatey`, `winget`

## Installation

### Download python and git:
- [Install Chocolatey on Windows 10](https://gist.github.com/lopezjurip/2a188c90284bf239197b)

### Clone repository:
```bash
git clone https://github.com/RDSik/si5340-config-loader.git
```

### Download packages:
```bash
pip install six
pip install hdlmake
pip install cocotb
pip install pytest
```

### Download make (add to PATH system variable the Make bin folder: C:\Program Files (x86)\GnuWin32\bin):
```bash
winget install GnuWin32.make
```

## Create config.mem file
```bash
cd src
py config_parser.py .\Si5340-RevD-Si5340-Registers.txt
```

## Simulation

### Icarus simulation using cocotb:
```bash
py -m venv myenv
.\myenv\Scripts\activate.ps1
cd .\sim\cocotb\si5340_config_loader_tb
py -m pytest test.py
gtkwave .\sim_build_si5340_config_loader\si5340_config_loader.vcd
deactivate
```

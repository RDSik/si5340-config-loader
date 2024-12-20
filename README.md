<div align="center">

[![Verilator Simulation](https://github.com/RDSik/si5340-config-loader/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/RDSik/si5340-config-loader/actions/workflows/main.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/RDSik/si5340-config-loader/blob/master/LICENSE.txt)

</div><br/><br/>

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
cd si5340-config-loader
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

#### Using cocotb (with 64 bit Python use 64 bit Modelsim):
```bash
py -m venv myenv
.\myenv\Scripts\activate.ps1
cd .\sim\cocotb
py -m pytest test.py
deactivate
```

### Using hdlmake:
```bash
cd .\sim\modelsim\
py -m hdlmake
make
```

### Using Verilator:
```bash
cd src
make
```

# 🧠 SingleCycleMIPSProcessor

This project implements a modular **MIPS single-cycle processor** in Verilog. It supports a subset of MIPS instructions and is designed for clarity, correctness, and simulation-driven debugging. All components are built from scratch and verified through waveform analysis and testbenches.

---

## 📁 Directory Structure

```
├── src/
│   ├── alu.v
│   ├── control_unit.v
│   ├── datapath.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── register_file.v
│   └── top.v
├── testbench/
│   ├── tb_single_cycle.v
│   └── dump.vcd
├── programs/
│   └── preload.hex
└── README.md
```

---

## ⚙️ Features

- ✅ **Single-Cycle Execution**: Each instruction completes in one clock cycle.
- ✅ **Instruction Support**:
  - Arithmetic: `ADD`, `SUB`, `ADDU`, `SUBU`
  - Logical: `AND`, `OR`, `XOR`, `NOR`
  - Shift: `SLL`, `SRL`, `SRA`, `SLLV`, `SRLV`
  - Memory: `LW`, `SW`
  - Control: `BEQ`, `J`
- ✅ **Signed Arithmetic**: Uses `$signed()` and `>>>` for correct shift behavior.
- ✅ **Modular Design**: ALU, control unit, register file, and memory are independently testable.
- ✅ **Waveform Debugging**: Output traces and zero flags are observable in simulation.

---

## 🧪 Simulation Instructions

### 🔧 Compile and Run
```bash
iverilog -o sim.out src/*.v testbench/tb_single_cycle.v
vvp sim.out
```

### 🔍 View Waveform
```bash
gtkwave dump.vcd
```

---

## 📄 File Descriptions

### 🔧 Source Files (`src/`)
- `alu.v`: Performs arithmetic, logical, and shift operations. Supports 6-bit ALUControl decoding.
- `control_unit.v`: Decodes opcode and generates control signals.
- `datapath.v`: Connects all modules and routes control signals and data.
- `instruction_memory.v`: Holds preloaded instructions from `preload.hex`.
- `data_memory.v`: Simulates RAM for `LW` and `SW`.
- `register_file.v`: Implements 32 registers with dual-read and single-write ports.
- `top.v`: Top-level integration of all modules.

### 🧪 Testbench Files (`testbench/`)
- `tb_single_cycle.v`: Simulates processor behavior and dumps waveform.
- `dump.vcd`: Generated waveform file for GTKWave or ModelSim.

### 📦 Program Files (`programs/`)
- `preload.hex`: Contains machine code instructions in hex format.

---

## 🧠 Design Philosophy

- **Minimalism**: Clean, readable modules with no redundant logic.
- **Correctness First**: Focused on simulation accuracy and control signal integrity.
- **Iterative Debugging**: Silent logic errors are caught via waveform inspection.
- **Modularity**: Each component is independently verifiable and reusable.

---

## ✍️ Author

**Devgokul**  
Digital design enthusiast focused on simulation-driven refinement, waveform debugging, and clean modular architecture.

---

## 📚 Future Enhancements

- Add support for `SLT`, `BNE`, and `JAL`.
- Expand ALUControl to support more R-type instructions.
- Integrate exception handling for overflow detection (`ADD` vs `ADDU`).
- Prepare for pipelined extension with stage separation and hazard control.

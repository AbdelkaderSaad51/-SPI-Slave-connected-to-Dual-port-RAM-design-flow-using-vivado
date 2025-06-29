#SPI-Slave-connected-to-Dual-port-RAM-design-flow-using-vivado

Project Overview
The main goal of this project is to design and implement an SPI Slave core that can receive data from a master device and store it into memory (mem.dat). The design was synthesized, implemented, and simulated to verify correct functionality.

### Encoding Schemes Implemented

- **Gray Encoding**
  - Elaborated and synthesized schematics (no errors)
  - Timing reports after synthesis
  - Implementation schematics (no errors)
  - Worst slack analysis
  - Utilization reports
  - Bitstream successfully generated

- **One-Hot Encoding**
  - Elaborated and synthesized schematics (no errors)
  - Timing reports after synthesis
  - Implementation schematics (no errors)
  - Worst slack analysis
  - Utilization reports
  - Bitstream successfully generated

- **Sequential Encoding**
  - Elaborated and synthesized schematics (no errors)
  - Timing reports after synthesis
  - Implementation schematics (no errors)
  - Worst slack analysis
  - Utilization reports
  - Bitstream successfully generated
 
  ### Simulation Results

- Data is correctly loaded into memory (`mem.dat`)
- MISO line shows correct output (`10101111`) at address `240 (0xAE)` as expected

### Synthesis & Implementation

- No critical warnings or errors encountered
- Successful bitstream generation across all encoding types

### Tools Used

- **Vivado Design Suite** – For synthesis, implementation, and bitstream generation
- **QuestaSim** – For functional and timing simulation

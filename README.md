# I2C_slave-project
Built using Verilog
#  I2C Slave Project using Verilog

##  Overview

This project implements an **I2C Slave module** using **Verilog HDL**, simulating the behavior of an I2C-compatible peripheral device. It demonstrates communication with an I2C Master using SDA (Serial Data Line) and SCL (Serial Clock Line) to receive and transmit data.

> ⚙ This is a fundamental project in Digital Design and Computer Architecture that enhances understanding of serial communication protocols and hardware description languages.

---

## 🔧 Features

- **Start/Stop Condition Detection**
- **7-bit Address Recognition**
- **Read/Write Control**
- **Data Acknowledge (ACK/NACK)**
- **Data Register Buffering**
- **SDA & SCL Line Monitoring**
- **Simulation Testbench (Self-checking)**

---

##  I2C Protocol Brief

- **I2C** (Inter-Integrated Circuit) is a synchronous, multi-master, multi-slave, packet-switched, single-ended serial communication protocol.
- Only **2 lines** are needed: `SCL` (clock) and `SDA` (data).
- Data is transferred in 8-bit format followed by ACK/NACK.

---

---

## 🔩 Module Ports

| Signal     | Direction | Description                     |
|------------|-----------|---------------------------------|
| `clk`      | Input     | System clock                    |
| `rst`      | Input     | Active-high synchronous reset   |
| `scl`      | Input     | I2C serial clock line           |
| `sda`      | Inout     | I2C serial data line            |
| `data_out` | Output    | Data received from master       |
| `data_in`  | Input     | Data to send to master          |
| `ack`      | Output    | Acknowledge signal              |

---

##  Simulation

###  Tools Used

- **ModelSim / QuestaSim**
- 
-

###  Steps to Run Simulation

1. **Compile the code**:
    ```bash
    vlog rtl/i2c_slave.v tb/tb_i2c_slave.v
    ```

2. **Run the simulation**:
    ```bash
    vsim tb_i2c_slave
    ```

3. **View waveforms**:
    ```bash
    add wave *
    run -all
    ```

---

##  What You'll Learn

- Designing FSMs for protocol control
- Handling bidirectional lines (`inout`)
- Synchronization with serial clock
- Debugging low-level hardware signals
- Simulation-based design verification

---

##  Future Improvements

- Support for multi-byte transfers
- Clock stretching feature
- Error checking (parity or CRC)
- Integration with I2C Master module

---

##  Contributing

Feel free to fork this repository, enhance the I2C slave design, and submit a pull request. You can contribute by:

- Optimizing the FSM
- Adding a GUI test interface
- Writing advanced testbenches

---



---

##  Author

**Achsah Grace **  
*Electronics & Communication Engineering | Verilog Enthusiast*  


---






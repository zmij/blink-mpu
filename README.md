# APB2 Blinky - Gowin Tangnano 4K FPGA Dev Board

This repository contains the code and resources for the "APB2 Blinky" project, which focuses on developing APB2 peripherals for the Gowin Tangnano 4K FPGA dev board. It serves as a practical guide and experience sharing post on developing custom peripherals and burning the FPGA device from Linux using the openFPGALoader tool.

## Contents

- `fpga/`: This directory contains the Verilog code for the APB2 peripheral that controls the onboard LED.
- `mcu/`: This directory contains the MCU firmware code written in C++ for interacting with the APB2 peripheral.

## Development Tools

The project utilizes various development tools, including:

- **Verilog-HDL/SystemVerilog/Bluespec SystemVerilog Extension for VS Code**: Used for writing the Verilog code for the custom peripherals.
- **Iverilog**: Used for verification and simulation of the designs.
- **Gowin EDA**: Utilized for synthesis, placement, routing, and IP generation.
- **Gowin GMD IDE**: Employed for developing MCU firmware code.
- **openFPGALoader**: Used for burning the FPGA device.

## Getting Started

To get started with the "APB2 Blinky" project and develop APB2 peripherals for the Gowin Tangnano 4K FPGA dev board, follow these steps:

1. Clone this repository to your local machine.
2. Review the Verilog code in the `fpga/` directory for the APB2 peripheral implementation.
3. Explore the MCU firmware code in the `mcu/` directory for interacting with the APB2 peripheral.
4. Refer to the [Reddit post](https://www.reddit.com/r/GowinFPGA/comments/14nfw38/developing_apb2_peripheral_for_gowin_tangnano_4k/) for a detailed guide and insights into the development process.
5. Install the necessary development tools mentioned above.
6. Set up the environment for Gowin EDA, Gowin GMD IDE, and openFPGALoader following the provided documentation and resources.

## Contributing

Contributions to the "APB2 Blinky" project are welcome! If you have any improvements or additional features to propose, please feel free to submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

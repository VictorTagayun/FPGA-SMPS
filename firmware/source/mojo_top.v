//https://embeddedmicro.com/tutorials/mojo/pulse-width-modulation

module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
  );
   
  wire rst = ~rst_n; // make reset active high
   
  // these signals should be high-z when not used
  assign spi_miso = 1'bz;
  assign avr_rx = 1'bz;
  assign spi_channel = 4'bzzzz;
   
/*  genvar i;
  generate
    for (i = 0; i < 8; i=i+1) begin: pwm_gen_loop
    pwm #(.CTR_LEN(3)) pwm (
      .rst(rst),
      .clk(clk),
      .compare(i),
      .pwm(led[i])
    );
    end
  endgenerate*/
  
  input_capture #(.CAP_LEN(9)) input_capture (
    .clk(clk),
    .rst(rst),
    .compare(compare), //compare register
    .capture_in(capture_in), //physical pin to measure
    .capture(capture), //register value
    .overflow(overflow) //error
  );
   
endmodule
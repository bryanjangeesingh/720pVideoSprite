`timescale 1ns / 1ps
`default_nettype none

module tm_choice_tb;

  reg [7:0] data_in;
  wire [8:0] qm_out;

  tm_choice uut (
    .data_in(data_in),
    .qm_out(qm_out)
  );

  initial begin
    $dumpfile("tm_choice.vcd");
    $dumpvars(0, tm_choice_tb);
    $display("Starting Simulation");

    data_in = 8'b00000000;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);

    data_in = 8'b00000001;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);

    data_in = 8'b00000010;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);

    data_in = 8'b00000011;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);
  
    data_in = 8'b00000100;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);

    data_in = 8'b00000101;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);

    data_in = 8'b00000110;
    #10 $display("data_in: %b, qm_out: %b", data_in, qm_out);


    $display("Simulation finished");
    $finish;
  end
endmodule

`default_nettype wire

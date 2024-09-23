module test_pattern_generator(
  input wire [1:0] sel_in,
  input wire [10:0] hcount_in,
  input wire [9:0] vcount_in,
  output logic [7:0] red_out,
  output logic [7:0] green_out,
  output logic [7:0] blue_out
  );


  always_comb begin
    if (sel_in == 2'b00) begin
        red_out = 8'hFF;
        green_out = 8'hA5;
        blue_out = 8'h00; 
    end else if (sel_in == 2'b01) begin 
        if (vcount_in == 360 || hcount_in == 640) begin
            red_out = 8'hFF;
            green_out = 8'hFF;
            blue_out = 8'hFF;
        end else begin 
            red_out = 8'h00;
            green_out = 8'h00;
            blue_out = 8'h00;
        end 
    end  else if (sel_in == 2'b10) begin
        red_out = hcount_in[7:0]; 
        green_out = hcount_in[7:0]; 
        blue_out = hcount_in[7:0]; 
    end else if (sel_in == 2'b11) begin
        red_out = hcount_in[7:0]; 
        green_out = vcount_in[7:0]; 
        blue_out = hcount_in[7:0] + vcount_in[7:0]; 
    end 
  end 


endmodule
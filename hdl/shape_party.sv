module shape_party(
  input wire clk_in, //
  input wire rst_in,
  input wire [10:0] hcount_in,
  input wire [9:0] vcount_in,
  input wire nf_in,
  input wire [3:0] b_con_in,
  input wire [3:0] c_con_in,
  output logic [7:0] red_out,
  output logic [7:0] green_out,
  output logic [7:0] blue_out
  );
  localparam BOX_DIM = 128;
  localparam CIRC_RAD = 64;
 
  logic [7:0] box_r, box_g, box_b;
  logic [7:0] circle_r, circle_g, circle_b;
  logic [7:0] shapes_r, shapes_g, shapes_b;
 
  logic [10:0] box_x;
  logic [9:0] box_y;
  logic [10:0] circle_x;
  logic [9:0] circle_y;
 
  block_sprite #(
  .WIDTH(BOX_DIM), .HEIGHT(BOX_DIM),.COLOR(24'hFF_7F_00))
  bs(
    .hcount_in(hcount_in),
    .vcount_in(vcount_in),
    .x_in(box_x),
    .y_in(box_y),
    .red_out(box_r),
    .green_out(box_g),
    .blue_out(box_b));
 
  circle_sprite #(
  .RADIUS(CIRC_RAD),.COLOR(24'hFF_FF_FF))
  cs(
    .clk_in(clk_in),
    .rst_in(rst_in),
    .hcount_in(hcount_in),
    .vcount_in(vcount_in),
    .x_in(circle_x),
    .y_in(circle_y),
    .red_out(circle_r),
    .green_out(circle_g),
    .blue_out(circle_b));
 
  localparam MOVE_AMT = 5; //amount to move per frame
  //Instructions:
  /*
  Create two sprites:
  * One rectangle with H and W 128 pixels
  * One circle with radius of 64 pixels
  * The two sprites should be able to move around the screen
    using four bits of input directions.  How you use them is up to you.
  * The sprites should not be able to move off the edge of the screen.
  * The sprites are allowed to collide/overlap. How you handle that is up
    to you.
  */


  //set up the max values for the box and circle positions to prevent going off screen 
  localparam MAX_X_FOR_BOX = 1280 - BOX_DIM; 
  localparam MAX_Y_FOR_BOX = 720 - BOX_DIM;   
  localparam MAX_X_FOR_CIRC = 1280 - CIRC_RAD; 
  localparam MAX_Y_FOR_CIRC = 720 - CIRC_RAD; 
  
always_ff @(posedge clk_in) begin
    if (rst_in) begin
      box_x <= 640; 
      box_y <= 320; 
      circle_x <= 120; 
      circle_y <= 200; 
    end else if(nf_in) begin
      if (b_con_in[0] && box_y > 0) begin // up
        box_y <= box_y - MOVE_AMT;
      end 

      if (b_con_in[1] && box_y < MAX_Y_FOR_BOX) begin //down 
        box_y <= box_y + MOVE_AMT; 
      end 

      if (b_con_in[2] && box_x > 0) begin //left
        box_x <= box_x - MOVE_AMT; 
      end 

      if (b_con_in[3] && box_x < MAX_X_FOR_BOX) begin //right 
         box_x <= box_x + MOVE_AMT;  
      end 
      
      if (c_con_in[0] && circle_y > 0 + CIRC_RAD) begin //up 
        circle_y <= circle_y - MOVE_AMT; 
      end 
      if (c_con_in[1] && circle_y < MAX_Y_FOR_CIRC) begin //down 
        circle_y <= circle_y + MOVE_AMT;  
      end 
      if (c_con_in[2] && circle_x > 0 + CIRC_RAD) begin //left 
         circle_x <= circle_x - MOVE_AMT;  
      end 
      if (c_con_in[3] && circle_x < MAX_X_FOR_CIRC) begin //right
        circle_x <= circle_x + MOVE_AMT; 
      end 
    end
  end

//handle collisions 
  always_comb begin
    if (box_r | box_g | box_b) begin 
      red_out = box_r;
      green_out = box_g;
      blue_out = box_b;
    end else if (circle_r | circle_g | circle_b) begin 
      red_out = circle_r;
      green_out = circle_g;
      blue_out = circle_b;
    end else begin
      red_out = 0;
      green_out = 0;
      blue_out = 0;
    end
  end 

endmodule //shape_party
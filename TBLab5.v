module TBLab5();
reg clk;
reg [15:0] bcd_in;
wire [3:0] seg_anode;
wire [6:0] seg_cathode;

multisegDriver uut(.clk(clk), .bcd_in(bcd_in),.seg_anode(seg_anode), .seg_cathode(seg_cathode));

initial begin
 clk = 0;
forever #5 clk = ~clk;
end
   
initial begin
    bcd_in = 16'h2345;
    #100000;
    //1234
    bcd_in = 16'h1234;
    #100000;
    //5678
    bcd_in = 16'h5678;
    //9435
    bcd_in=16'h9435;
    #100000;
    //0401
    bcd_in = 16'h0401;
    #100000;
    
    $stop;
end


endmodule

module multisegDriver(
input clk,
input [15:0] bcd_in,
output [3:0] seg_anode,
output [6:0] seg_cathode);

wire [3:0] bcd_val;

anodeGenerator u1 (.clk(clk),.bcd_in(bcd_in), .seg_anode(seg_anode), .bcd_out(bcd_val));
BCDtoSevenSegmentDisplay1 u2 (.data_in(bcd_val),.seg(seg_cathode) ); 

endmodule

module anodeGenerator(clk, bcd_in, seg_anode, bcd_out);
input  clk;           
input[15:0] bcd_in;  
output reg[3:0] seg_anode; 
output reg [3:0] bcd_out;
 
reg [9:0] g_count=0;
reg [3:0] anode;
initial begin
anode = 4'b1110;
end 
always @(posedge clk) begin
    g_count <= g_count + 1;

        // refresh delay
        if (g_count == 10'd1023) begin
            g_count <= 0;
            seg_anode <= anode;
            
            case (anode)
                4'b1110: bcd_out<= bcd_in[3:0];    
                4'b1101: bcd_out<= bcd_in[7:4];    
                4'b1011: bcd_out<=bcd_in[11:8];   
                4'b0111: bcd_out<= bcd_in[15:12]; 
                default: bcd_out<= 4'b0000;
            endcase

            //shift register
            anode <= {anode[0], anode[3:1]};
        end

    end
endmodule

module BCDtoSevenSegmentDisplay1(data_in, seg);
input [3:0] data_in;
output reg [6:0] seg;

 always @* begin
        case (data_in)
           4'b0000: seg = 7'b1000000;
           4'b0001: seg = 7'b1111001;
           4'b0010: seg = 7'b0100100;
           4'b0011: seg = 7'b0110000;
           4'b0100: seg = 7'b0011001;
           4'b0101: seg = 7'b0010010;
           4'b0110: seg = 7'b0000010;
           4'b0111: seg = 7'b1111000;
           4'b1000: seg = 7'b0000000;
           4'b1001: seg = 7'b0010000;
           default: seg = 7'b1111111;
        endcase
      end
      
   
endmodule

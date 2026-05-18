module encoder_83 (
    input [7:0] din,
    input EI,
    output reg [2:0] dout,
    output reg GS,
    output reg EO
);

always @(*) begin
    if(EI==0)begin
        GS=0;EO=1;
        casez(din)
        8'b0???????: dout=3'b000;
        8'b10??????: dout=3'b001;
        8'b110?????: dout=3'b010;
        8'b1110????: dout=3'b011;
        8'b11110???: dout=3'b100;
        8'b111110??: dout=3'b101;
        8'b1111110?: dout=3'b110;
        8'b11111110: dout=3'b111;
        8'b11111111:begin dout=3'b111; GS=1; EO=0; end
        default begin dout=111;end
        endcase
    end
    else begin
        dout=111;GS=1;EO=1;
    end
    end
endmodule

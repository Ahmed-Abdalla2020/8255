module ppi__module(reset,cs,rd,wt,address,portA,portB,portC,portD);
input reset,cs,rd,wt;
input [1:0]address;
inout [7:0]portA;
inout [7:0]portB;
inout [7:0]portC;
inout [7:0]portD;
//reg for input or output data
reg [7:0]datasel;//for first D input
reg [7:0]porta;
reg [7:0]portb;
reg [7:0]portc;
reg outa,outb,outc;

//port a inout
assign portD=(datasel[7:5]==3'b100&&datasel[4]==1&&address[1:0]==2'b00&&rd==0&&wt==1) ? porta:8'bzzzzzzzz;
assign portA=(datasel[7:5]==3'b100&&datasel[4]==0&&address[1:0]==2'b00&&rd==1&&wt==0) ? porta:8'bzzzzzzzz;

//port b inout
assign portD=(datasel[7:5]==3'b100&&datasel[1]==1&&address[1:0]==2'b01&&rd==0&&wt==1) ? portb:8'bzzzzzzzz;
assign portB=(datasel[7:5]==3'b100&&datasel[1]==0&&address[1:0]==2'b01&&rd==1&&wt==0) ? portb:8'bzzzzzzzz;

//port c upper inout
assign portD=(datasel[7:5]==3'b100&&datasel[3]==1&&address[1:0]==2'b10&&rd==0&&wt==1) ? portc[7:4]:8'bzzzzzzzz;
assign portC[7:4]=(datasel[7:5]==3'b100&&datasel[3]==0&&address[1:0]==2'b10&&rd==1&&wt==0) ? portc:8'bzzzzzzzz;

//port c lower inout
assign portD=(datasel[7:5]==3'b100&&datasel[0]==1&&address[1:0]==2'b10&&rd==0&&wt==1) ? portc[3:0]:8'bzzzzzzzz;
assign portC[3:0]=(datasel[7:5]==3'b100&&datasel[0]==0&&address[1:0]==2'b10&&rd==1&&wt==0) ? portc:8'bzzzzzzzz;

//BSR mode
assign portC[0]=(datasel[7]==0&&datasel[3:1]==3'b000&&datasel[0]==1) ? 1:1'bz;
assign portC[0]=(datasel[7]==0&&datasel[3:1]==3'b000&&datasel[0]==0) ? 0:1'bz;

assign portC[1]=(datasel[7]==0&&datasel[3:1]==3'b001&&datasel[0]==1) ? 1:1'bz;
assign portC[1]=(datasel[7]==0&&datasel[3:1]==3'b001&&datasel[0]==0) ? 0:1'bz;

assign portC[2]=(datasel[7]==0&&datasel[3:1]==3'b010&&datasel[0]==1) ? 1:1'bz;
assign portC[2]=(datasel[7]==0&&datasel[3:1]==3'b010&&datasel[0]==0) ? 0:1'bz;

assign portC[3]=(datasel[7]==0&&datasel[3:1]==3'b011&&datasel[0]==1) ? 1:1'bz;
assign portC[3]=(datasel[7]==0&&datasel[3:1]==3'b011&&datasel[0]==0) ? 0:1'bz;

assign portC[4]=(datasel[7]==0&&datasel[3:1]==3'b100&&datasel[0]==1) ? 1:1'bz;
assign portC[4]=(datasel[7]==0&&datasel[3:1]==3'b100&&datasel[0]==0) ? 0:1'bz;

assign portC[5]=(datasel[7]==0&&datasel[3:1]==3'b101&&datasel[0]==1) ? 1:1'bz;
assign portC[5]=(datasel[7]==0&&datasel[3:1]==3'b101&&datasel[0]==0) ? 0:1'bz;

assign portC[6]=(datasel[7]==0&&datasel[3:1]==3'b110&&datasel[0]==1) ? 1:1'bz;
assign portC[6]=(datasel[7]==0&&datasel[3:1]==3'b110&&datasel[0]==0) ? 0:1'bz;

assign portC[7]=(datasel[7]==0&&datasel[3:1]==3'b111&&datasel[0]==1) ? 1:1'bz;
assign portC[7]=(datasel[7]==0&&datasel[3:1]==3'b111&&datasel[0]==0) ? 0:1'bz;

always @(*)
begin
if(reset==0)
begin
if(cs==0&&(rd==0||wt==0))
begin
if(address==2'b11&&rd==0&&wt==1)
begin
datasel = portD;
end
if(datasel[7]==1)
begin////
if(datasel[6:5]==2'b00&&datasel[2]==0)
begin//
//port a inout 
if(datasel[6:5]==2'b00&&datasel[4]==1&&address[1:0]==2'b00&&rd==0&&wt==1)
begin
porta=portA;
end
else if(datasel[6:5]==2'b00&&datasel[4]==0&&address[1:0]==2'b00&&rd==1&&wt==0)
begin
porta=portD;
end

//port b inout 
else if(datasel[6:5]==2'b00&&datasel[1]==1&&address[1:0]==2'b01&&rd==0&&wt==1)
begin
portb=portB;
end
else if(datasel[6:5]==2'b00&&datasel[1]==0&&address[1:0]==2'b01&&rd==1&&wt==0)
begin
portb=portD;
end

//port c upper inout 
else if(datasel[6:5]==2'b00&&datasel[3]==1&&address[1:0]==2'b10&&rd==0&&wt==1)
begin
portc[7:4]=portC[7:4];
end
else if(datasel[6:5]==2'b00&&datasel[3]==0&&address[1:0]==2'b10&&rd==1&&wt==0)
begin
portc=portD;
end

//port c lower inout 
else if(datasel[6:5]==2'b00&&datasel[0]==1&&address[1:0]==2'b10&&rd==0&&wt==1)
begin
portc[3:0]=portC[3:0];
end
else if(datasel[6:5]==2'b00&&datasel[0]==0&&address[1:0]==2'b10&&rd==1&&wt==0)
begin
portc=portD;
end

end//

end////
end

end


else //for reset
begin
porta=portA;
portb=portB;
portc=portC;
datasel=portD;
end

end

endmodule 


module test__ppi();
reg rs,css,red,wrt;
reg [1:0]add;
wire [7:0]poA;
wire [7:0]poB;
wire [7:0]poC;
wire [7:0]poD;
reg [7:0]ddd;
reg [7:0]aaa;

assign poD=(add==2'b11&&red==0&&wrt==1&&rs==0&&css==0) ? ddd:8'bzzzzzzzz;

assign poA=(add==2'b00&&red==0&&wrt==1&&ddd[4]==1&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;
assign poD=(add==2'b00&&red==1&&wrt==0&&ddd[4]==0&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;

assign poB=(add==2'b01&&red==0&&wrt==1&&ddd[1]==1&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;
assign poD=(add==2'b01&&red==1&&wrt==0&&ddd[1]==0&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;

assign poC[7:4]=(add==2'b10&&red==0&&wrt==1&&ddd[3]==1&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;
assign poD=(add==2'b10&&red==1&&wrt==0&&ddd[3]==0&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa[7:4]:8'bzzzzzzzz;

assign poC[3:0]=(add==2'b10&&red==0&&wrt==1&&ddd[0]==1&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa:8'bzzzzzzzz;
assign poD=(add==2'b10&&red==1&&wrt==0&&ddd[0]==0&&ddd[2]==0&&ddd[7:5]==3'b100&&rs==0&&css==0) ? aaa[3:0]:8'bzzzzzzzz;



initial 
begin
$monitor("D=%b,,,,A=%b,,B=%b,,C=%b",poD,poA,poB,poC);

rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10010000;
#5
$display("mode 0");
$display("1");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b00;
aaa=8'b10101010;

#5
$display("2");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10000000;

#5
$display("3");
rs=0;
css=0;
red=1;
wrt=0;
add=2'b00;
aaa=8'b10011001;
#5
$display("4");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10010010;
#5
$display("5");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b01;
aaa=8'b10101011;

#5
$display("6");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10000000;

#5
$display("7");
rs=0;
css=0;
red=1;
wrt=0;
add=2'b01;
aaa=8'b10011111;

#5
$display("8");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10011010;

#5
$display("9");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b10;
aaa=8'b11111011;

#5
$display("10");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10010011;

#5
$display("11");
rs=0;
css=0;
red=1;
wrt=0;
add=2'b10;
aaa=8'b11111011;

#5
$display("12");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10011010;

#5
$display("13");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b10;
aaa=8'b11111011;

#5
$display("14");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10011010;

#5
$display("15");
rs=0;
css=0;
red=1;
wrt=0;
add=2'b10;
aaa=8'b11111011;

#5
$display("BSR mode");
$display("16");//for bsr mode
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b00010000;

#5
$display("17");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b00010011;

#5
$display("18");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b00010111;

#5
$display("19");
rs=0;
css=0;
red=0;
wrt=1;
add=2'b11;
ddd=8'b00011110;

#5
$display("reset");
$display("20");//for reset mode
rs=0;
css=1;
red=0;
wrt=1;
add=2'b11;
ddd=8'b10011110;

end
ppi__module ahmed(rs,css,red,wrt,add,poA,poB,poC,poD);
endmodule

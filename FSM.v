module fsmg4(go,jmp,Y, clk, rst_n);

output Y;
input go, jmp, clk, rst_n;
reg Y;

parameter [3:0] S0 = 4'b0000,
S1 = 4'b0001,
S2 = 4'b0010,
S3 = 4'b0011,
S4 = 4'b0100,
S5 = 4'b0101,
S6 = 4'b0110,
S7 = 4'b0111,
S8 = 4'b1000,
S9 = 4'b1001;
reg [3:0] state, next;

always @(posedge clk or negedge rst_n)
if (!rst_n) state <= S0;
else state <= next;	
	
always @(go or jmp or state ) 
begin
next = 4'bx;
Y = 1'b0;
case (state)
S0 : 
if (go & !jmp)
	begin
		next = S1;
		Y = 0;
	end	
else if (go & jmp) 
	begin
		next = S3;
		Y = 1;
	end
else if (!go) 
	begin
		next = S0;
		Y = 0;
	end
S1 : 
if (!jmp)
	begin
		next = S2;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S2 : 
if (jmp) 
	begin
		next = S3;
		Y = 1;
	end	
else
	next=state;
S3 : 
if (!jmp)
	begin
		next = S4;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S4 : 
if (!jmp)
	begin
		next = S5;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S5 : 
if (!jmp)
	begin
		next = S6;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S6 : 
if (!jmp)
	begin
		next = S7;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S7 : 
if (!jmp)
	begin
		next = S8;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S8 : 
if (!jmp)
	begin
		next = S9;
		Y = 1;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
S9 : 
if (!jmp)
	begin
		next = S0;
		Y = 0;
	end	
else if (jmp) 
	begin
		next = S3;
		Y = 1;
	end
endcase
end
endmodule

module fsm_tb ();

reg go, jmp, rst_n, clk;
wire y;

initial	
	begin 	   
		$monitor("state = %b  , go = %b, jmp = %b, next= %b , y = %b",g4.state , go, jmp, g4.next, y);
		clk=0;
		go=0;
		jmp=0;
		rst_n = 1;
		#3
		rst_n = 0;
		#12
		rst_n=1;
		go=1;
		#12	
		jmp=1;
		
	end		
	
always 
	begin
		#5
		clk = ~clk;
	end
fsmg4 g4(go,jmp,y, clk, rst_n);	
	
endmodule

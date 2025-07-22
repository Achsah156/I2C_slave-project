
`include "i2c_slave.v"

module I2C_TOP_test;

		reg RESET;
		wire [6:0] ADRESS_OUT;
		wire [7:0] DATA_OUT;
		wire SCL;
		wire SDA;

		reg clk;
		reg sda;

		I2C_slave dut(RESET,SCL,SDA,DATA_OUT,ADRESS_OUT);
        
		assign SCL=clk;

		assign SDA=dut.dir_en?1'bz:sda;  // direction_enable = 1 slave sends data or ack/nack and if direction_enable = 0 slave recevies the data.

		// for initialzing input values
		task initialization; 
		begin 
				clk=0;
				sda=0;
				RESET=0;
				$display($time,"@ IN INTIALIZATION");
		end
		endtask

		task rst;
		begin 
				RESET=1;
				repeat (2) @(negedge clk);

				#2;
				RESET=0;
		end
		endtask

		// clock generation
		always #10 clk=!clk;

		// task to generate start condition
		task start_gen;
		begin
				$display($time,"@ start gen");
				sda=1;
				@ (posedge clk); 
				#2;
				sda=0;
				@ (negedge clk);

		end
		endtask

		// task to generate stop condtion
		task stop_gen;
		begin
				$display($time,"\t@stop gen");
				@ (negedge clk);
				sda=0;
				@(posedge clk); #2;
				sda=1;

		end
		endtask

		// task to generate stop condtion
		task stop_gen2;
		begin
				$display($time,"\t@stop gen 2");
				$display($time,"sda=%b",sda);				
				sda=0;
				@(negedge clk);
				#2;
				$display($time,"sda=%b",sda);
				sda=1;
				@(posedge clk);
				$display($time,"sda=%b",sda);

		end
		endtask

		// task to generate adress values

		task wr_address;
		reg [7:0] temp;
		begin
				temp=8'b1100_1110;// 110_0111='h67/'d103  0:write //1100_1110='b206/'h ce
				$display($time,"temp_disp=%b",temp,sda);
				repeat (8) begin 
						@( negedge clk) ;#2;
						sda=temp;
						temp=temp>>1;
						$monitor($time,"temp=%b,sda=%b",temp,sda);
				end
				@( negedge clk) ;// for ack signal
		end
		endtask

        task wr_address_1;
		reg [7:0] temp;
		begin
				temp=8'b1101_1100;// 110_0111='h67/'d103  0:write //1100_1110='b206/'h ce
				$display($time,"temp_disp=%b",temp,sda);
				repeat (8) begin 
						@( negedge clk) ;#2;
						sda=temp;
						temp=temp>>1;
						$monitor($time,"temp=%b,sda=%b",temp,sda);
				end
				@( negedge clk) ;// for ack signal
		end
		endtask



		task rd_address;
		reg [7:0] temp;
		begin

				temp=8'b1100_1111; // 110_0111='h67/'d103  0:write //1100_1110='b206/'h ce
				repeat (8) begin 
						@( negedge clk) ;
						sda=temp;
						temp=temp>>1;
				end
				@ (negedge clk);// for ack signal
		end
		endtask

/*        task rd_address_1;
		reg [7:0] temp;
		begin

				temp=8'b1101_1100; // 110_0111='h67/'d103  0:write //1100_1110='b206/'h ce
				repeat (8) begin 
						@( negedge clk) ;
						sda=temp;
						temp=temp>>1;
				end
				@ (negedge clk);// for ack signal
		end
		endtask */


		// task to generate write data values
		task write_data;
		reg [7:0] temp;

		begin
				temp=8'b 1101_1101; //dd
				repeat (8) begin 
						@(negedge clk);
						sda=temp;
						temp=temp>>1;
				end
				@ (negedge clk);// for ack signla
		end
		endtask


/*        task write_data_1;
		reg [7:0] temp;

		begin
				temp=8'b 1101_1100; //dc
				repeat (8) begin 
						@(negedge clk);
						sda=temp;
						temp=temp>>1;
				end
				@ (negedge clk);// for ack signla
		end
		endtask  */


		// task to get read  data values
		task read_data;
		begin

				repeat (8)begin
						@ (negedge clk);
				end
				@(negedge clk)sda=0; // ack 
		end
		endtask




		// calling all task
		initial begin
				initialization;
				rst;
				start_gen();

				wr_address();


				write_data;

				rd_address();
				read_data;
                wr_address_1();
    //            write_data_1();
  //              rd_address_1();
                
				//#800;
				//stop_gen();
				//@(dut.present_state==)stop_gen2();
				//#1000;
				$stop;
				//#200;
				//$finish;
		end
endmodule  

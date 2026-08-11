module struct_1;
  struct{int a;
         bit[2:0]b;
         logic[5:0] c; 
        // logic c;  1 bit
        }my_struct;
  initial begin
    my_struct.a=4'd1234; //a=2(last 4 binary numbers 0010)
    my_struct.b=3'b101; //b=101
    my_struct.c=5'd4567;//c=23 or c=4'd567 c=7{truncation}
    
          $display("my_struct:a=%0d,my_struct:b=%0b,my_struct:c=%0d",my_struct.a,my_struct.b,my_struct.c);
  end
endmodule

/*module struct_1;

  struct {
    int a;
    bit [2:0] b;
    logic c;
  } my_struct;

  initial begin
    my_struct.a = 1234;
    my_struct.b = 3'b101;
    my_struct.c = 1'b1;

    $display("a=%0d", my_struct.a);
    $display("b=%0b", my_struct.b);
    $display("c=%0b", my_struct.c);
  end

endmodule*/
  

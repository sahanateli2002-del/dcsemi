//////////////////05/08/2026/////////////////////////////////////////////////
/////////////////Task&function//////////////////////////////////////////////

//call task inside a function(illegal WITH DELAY)(WARNING W/O DELAY)

/*module ex;
task abc();
    //#10 $display("i am inside task"); //Task "abc" cannot be called in function "def" as it has delay or DPI task call.
    $display("i am inside task");
  endtask
  
  function void def(); //Warning-[TEIF] Task enabled inside a function
//testbench.sv, 9
   abc();
   $display("i'm inside function");
  endfunction
  
  initial begin
  def();
  end
endmodule*/

//function & task calling through initial block
/*module test;

  task display_msg();
    $display("Inside task");
  endtask

  function int add(int a, b);
    return a+b;
  endfunction

  initial begin
    display_msg();              // Task call
    $display("%0d", add(5,6));  // Function call
  end

endmodule*/

//////calling task inside a function using fork-join_none(LEGAL)
/*module ex;
  
  task abc();  //task
    #10 $display("%t,i'm inside task",$time);
  endtask
  
  function void def();  //function with f-j_n
    fork
      abc();
    join_none
    //join_any //ERROR
  endfunction
  
  initial begin
    def();
  end
  
endmodule*/



////function static
/*module ex;
  function static int add(input int a,b);
    return a+b;
  endfunction
  
  initial begin
    int c;
    c=add(2,3);  //return value
    $display("c=%0d",c);
  end
  
endmodule*/

//static function(static and automatic var)
//static=shared memory initiated only in 1st iteration (memory is allocated only once)
//automatic=memory is created for every iteration
/*module ex;
  static function void loop();
    for(int i=0;i<3;i++)begin
      //static int j=i;
      automatic int j=i;//0 0,1 1,2 2
      $display("i=%0d,j=%0d",i,j);
    end
  endfunction
  
  initial begin
    loop();
  end
endmodule*/
    

///task static
/*module ex;
  task static add(input int a,b, output int c);
    c=a+b;
  endtask
  
  initial begin
    int c;
    add(2,3,c);
    $display("c=%0d",c);
  end
  
endmodule*/

///static task(static and automatic variable)
/*module ex;
  static task loop();
    for(int i=0;i<3;i++)begin
     // static int j=i;
      //ERROR:- A static declaration may not use any non-static references in its initial expression
      //automatic int j=i;//0 0,1 1,2 2
      $display("i=%0d,j=%0d",i,j);
    end
  endtask
  
  initial begin
    loop();
  end
endmodule*/

/*module ex;
  static task loop();
    static int j;
   // automatic int j;
    for(int i=0;i<3;i++)begin
      //if(i==1)begin
        j=i; //valid assignment
      //end
      $display("i=%0d,j=%0d",i,j);
    end
  endtask
  
  initial begin
    loop();
  end
endmodule*/

///local, global variables, static, automatic

//local=local variables are accessable only in that task or function
//global=not specific access

// module ex;
//   int a=20; //global variable
//   function abc();
//     $display("function a=%0d",a);
//   endfunction
  
//   task abc1();
//     $display("task a=%0d",a);
//   endtask
  
//   initial begin
//     abc();
//     abc1();
//     $display("initial a=%0d",a);
//   end
// endmodule

/*module ex;
  //function automatic void abc();
  function static void abc();
    //static int a=10;  //local variable
    automatic int a=10;
    $display("a=%0d",a);
    a++;
  endfunction
  
  initial begin
    abc();
    abc();
  end
endmodule*/

/*module ex;
  static int a=20;
  //function static void abc();
    function automatic void abc();
      $display("a=%0d",a);
    endfunction
     
    initial begin
      abc();
    end
endmodule
*/


////////////////////return types in function//////////////////////////////
//A function's return type must be a data type.
//class name

/*class first;
  int a;
endclass

class second;
  function first abc();
    first f=new();
    f.a=10;
    return f;
  endfunction
endclass

module exx;
  second s;
  initial begin
    s=new();
    s.abc();
    $display("value a=%0d",s.abc().a);
  end
endmodule*/


///dynamic array error
/*class A;
  int ar[];
  function arr array(int a); //dynamic return type
    
    arr=new[a];
    for(int i=0;i<3;i++)begin
      arr[i]=i;
    end
    return arr;
  endfunction
endclass

module ex;
  int temp[];
  A a1;
  initial begin
    a1=new();
    temp=a1.array();
    foreach(temp[i])
      $display("arr[%0d]=%0d",i,temp[i]);
  end
endmodule*/

/*module ex;
  typedef int array[];
  
  function array abc(int a);
    array arr;
    arr=new[a];
    foreach(arr[i])
      arr[i]=i;
    return arr;
  endfunction
  
  initial begin
    array arr1;
    arr1=abc(3);
    foreach(arr1[i])
      $display("arr1[%0d]=%0d",i,arr1[i]);
  end
  
endmodule*/


///queue
/*module ex;
  typedef int q[$];
  q q1;
  
  function q que();
  q a;
    a.push_back(1);
    a.push_back(2);
    a.push_back(3);
    return a;
  endfunction

  initial begin
    q1=que();
    //$display("que1=%p",q1);
    foreach(q1[i])
      begin
        $display("que1=%0d",i,q1[i]);
      end
  end
endmodule*/

////////////////recursion function///////////////////////////
//factorial

/*module factorial;
  function static int abc(input int a);//implicit memory allocation through automatic/static(recursion)
    if(a<=1)
      return 1;
    else
      return a*abc(a-1);
  endfunction
  
 initial begin
   $display("value is %0d",abc(5));
   $display("value is %0d",abc(7));
 end
endmodule
*/

////////////////////positional arguments////////////////////////////////
//positional arguments mean that the values passed to a task or function are matched to the formal arguments by their position, not by their names.

/*module ex;
  function int add(input int a,b);
    return a+b;
  endfunction
  
  initial begin
    int result;
    result=add(10,20);
    $display("result=%0d",result);
  end
endmodule*/

/*module ex;
  task add(input int a,b);
    $display("a=%0d,b=%0d,add=%0d",a,b,a+b);
  endtask
  
  initial begin
    add(10,20);
  end
endmodule*/

/*module ta; //error
  int c;
  task add(input int a,b);
    c=a+b;
    $display("a=%0d,b=%0d,c=%0d",a,b,c);
  endtask
  
  initial begin
    int result;
    result=c;
    add(10, 20,result);
    $display("result= %0d",ressult);
  end

endmodule*/
    

////////////function argument and return type is class
/*class packet;
  int data;
endclass

module ex;
  packet s1;
  function packet abc(packet p);
   packet temp;
    temp=new();
    temp.data=p.data;
    return temp;
  endfunction
  
  initial begin
    s1=new();
    s1.data=10;
    //s1.abc();
    $display("s1.data=%0d",s1.data);
    //$display("s2.data=%0d",s2.data);
  end
  endmodule
  */

//function calling inside function (recursive).
/*module test;
  function int add(input int a,b);
    return a+b;
  endfunction
  
  initial begin
    $display("addition=%0d",add(add(2,3),add(4,5)));//add(add(a,b),add(a,b)) addition=5+9=14
  end
endmodule*/

//call function inside fork-join
/*module test;
  function int add(input int a);
    
    return a+a;
  endfunction
  
  initial begin
    int out;
    
    //fork-join
    fork
      begin
        out=add(5);
        #15 $display("time=%0t,out=%0d",$time,out);
      end
    join_none
    #10;
    $display("%0t outside fork-join_none",$time);
  end
endmodule*/


///calling function in nested fork-join_none
module test;
  function int add(input int a);
    return a+a;
  endfunction
  
  initial begin
    int out1,out2;
    
    //outer fork-join_none
    fork
      begin
        //inner1 fork-join_none
        fork
          begin
            //inner2 fork-join_none
            fork
              begin
              out1=add(6);
              #10 $display("time=%0t,out1=%0d",$time,out1);
              end
          
          begin
            out2=add(11);
            #20 $display("time=%0t,out2=%0d",$time,out2);
          end
        join_none
            #30 $display("inner2 fork-join completed %0t",$time);
      end
    join_none
        #40 $display("inner1 fork-join completed %0t",$time);
      end
    join_none
    #50 $display("outer fork-join completed %0t",$time);
  end
endmodule







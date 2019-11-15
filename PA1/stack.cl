(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Stack inherits IO {
   sval : String;

   push(e : String) : SELF_TYPE {
      {
         sval <- sval.concat(e);
         self;
      }
   };

   pop() : SELF_TYPE {
      {
         sval <- sval.substr(0, sval.length()-1);
         self;
      }
   };

   eval() : SELF_TYPE {
      if sval = "" then
         self
      else 
      (let top : String <- sval.substr(sval.length()-1, 1) in
         
            if top = "+" then
               (let a : String <- sval.substr(sval.length()-2, 1), 
                  b : String <- sval.substr(sval.length()-3, 1),
                  r : String <- new A2I.i2a(new A2I.a2i(a)+new A2I.a2i(b)) in 
                  {
                     pop(); pop(); pop(); push(r);
                  }
               )
            else  if top = "s" then
               (let a : String <- sval.substr(sval.length()-2, 1), b : String <- sval.substr(sval.length()-3, 1) in
                  {
                     pop(); pop(); pop(); push(a); push(b);
                  }
               )
            else self
            fi fi
      )
      fi
   };

   print() : SELF_TYPE {
      (let i : Int <- 0 in
         {
            while i < sval.length() loop
            {
               out_string(sval.substr(i, 1).concat("\n"));
               i <- i + 1;
            }
            pool;
            self;
         }
      )
   };
};

class Main inherits IO {

   main() : Object {
      (let flag : Bool <- true, stack : Stack <- new Stack, line : String <- new String in 
      while flag = true loop
      {
         line <- in_string();
         if line = "x" then flag <- false else
         if line = "d" then stack.print() else
         if line = "e" then stack.eval() else
         stack <- stack.push(line)
         fi fi fi;
      }   
      pool
      )
      -- out_string("Nothing implemented\n")
   };

};

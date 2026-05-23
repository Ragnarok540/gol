with Ada.Text_IO; use Ada.Text_IO;

package body Conway is
   V : State;
   Matrix : Grid;

   procedure Initialize (M : in out Grid) is
   begin
      for I in Height loop
         for J in Width loop
            M (I, J) := 0;
         end loop;
      end loop;
   end;

   procedure Print (M : in  Grid) is
   begin
      for I in Height loop
         for J in Width loop
            V := Matrix (I, J);
            Put (State'Image(V));
         end loop;
         New_Line;
      end loop;
   end;

begin
   Initialize (Matrix);

   Matrix (1, 4) := 1;
   Matrix (2, 5) := 1;
   Matrix (3, 3) := 1;
   Matrix (3, 4) := 1;
   Matrix (3, 5) := 1;

   Print (Matrix);
end Conway;

-- mkdir -p bin
-- gnatmake -o bin/conway -z conway.adb
-- ./bin/conway

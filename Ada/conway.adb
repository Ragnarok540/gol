-- https://www.youtube.com/watch?v=qJAuyoDt03A

with Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;

package body Conway is
   use Ada.Text_IO;
   C : Grid;

   function Count_Neighbors(G : Grid; X : Rows; Y : Cols) return Neighbors is
      N, NE, E, SE, S, SW, W, NW : Neighbors;
   begin
      N  := Neighbors(G(X + 1, Y    ));
      NE := Neighbors(G(X + 1, Y + 1));
      E  := Neighbors(G(X,     Y + 1));
      SE := Neighbors(G(X - 1, Y + 1));
      S  := Neighbors(G(X - 1, Y    ));
      SW := Neighbors(G(X - 1, Y - 1));
      W  := Neighbors(G(X,     Y - 1));
      NW := Neighbors(G(X + 1, Y - 1));
      return N + NE + E + SE + S + SW + W + NW;
   end;

   function Draw(Value : State) return Character is
   begin
      if Value = 1 then
         return '#';
      else
         return '.';
      end if;
   end;

   procedure Print(G : Grid) is
   S : State;
   begin
      for Row in Rows loop
         for Col in Cols loop
            S := G(Row, Col);
            Put(Draw(S));
         end loop;
         New_Line;
      end loop;
   end;

   function Game_Logic(S : State; N : Neighbors) return State is
   begin
      if S = 1 then
         if N < 2 then
            return 0;
         end if;
         if N > 3 then
            return 0;
         end if;
         return S;
      else
         if N = 3 then
            return 1;
         end if;
         return S;
      end if;
   end;

   function Step_Cell(G : Grid; X : Rows; Y : Cols) return State is
      S : State;
      N : Neighbors;
      Next_S : State;
   begin
      S := G(X, Y);
      N := Count_Neighbors(G, X, Y);
      Next_S := Game_Logic(S, N);
      return Next_S;
   end;

   function Simulate(G : Grid) return Grid is
      New_G : Grid;
   begin
      for Row in Rows loop
         for Col in Cols loop
            New_G(Row, Col) := Step_Cell(G, Row, Col);
         end loop;
      end loop;
      return New_G;
   end;

   procedure Clear_Screen is
   begin
      Put(Ada.Characters.Latin_1.ESC & "[" & Ada.Strings.Fixed.Trim("10", Ada.Strings.Left) & "A");
      Put(Ada.Characters.Latin_1.ESC & "[" & Ada.Strings.Fixed.Trim("20", Ada.Strings.Left) & "D");
   end;

begin
   C(0, 3) := 1;
   C(1, 4) := 1;
   C(2, 2) := 1;
   C(2, 3) := 1;
   C(2, 4) := 1;

   Print(C);

   while True loop
      Clear_Screen;
      C := Simulate(C);
      Print(C);
      delay 0.1;
   end loop;
end Conway;

-- mkdir -p bin
-- gnatmake -gnatwa -o bin/conway -z conway.adb
-- ./bin/conway

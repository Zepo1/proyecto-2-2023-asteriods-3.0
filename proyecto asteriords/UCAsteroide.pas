unit UCAsteroide;

interface
Uses Graphics, System.Types;
Type
    asteroide = Class
      Private


      Public
          angulo: integer;
          velocidad: integer;
          R     : Integer;
          Cx,Cy : Integer;
          constructor Create(x,y,ra, ang:Integer);
          Procedure Draw(Pantalla : TCanvas);
          Procedure Move;
    End;

implementation


constructor asteroide.Create(x, y, ra, ang: Integer);
begin
  Cx:=x;
  Cy:=y;
  R:=ra;
  angulo := ang;
  randomize;
  velocidad := random(5)+5;
end;

procedure asteroide.Draw(Pantalla: TCanvas);
begin
     Pantalla.pen.Color:=clBlack;
     Pantalla.Pen.Width := 4;
     Pantalla.Ellipse(Cx-r,Cy-r,Cx+r,Cy+r);
end;

procedure asteroide.Move;
var dx, dy: integer;
begin
     dx := trunc(velocidad * sin(angulo*pi/180));
     dy := -trunc(velocidad * cos(angulo*pi/180));
     Cx:=Cx+dx;
     Cy:=Cy+dy;
end;
end.

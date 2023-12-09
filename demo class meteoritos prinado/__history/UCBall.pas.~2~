unit UCBall;

interface
Uses Graphics;
Type
    Ball = Class
      Private
          Cx,Cy : Integer;
          R     : Integer;
      Public
          Procedure setValues(x,y,ra:Integer);
          Procedure Draw(Pantalla : TCanvas);
          Procedure Move(dx,dy:Integer);
    End;

implementation

{ Ball }

procedure Ball.Draw(Pantalla: TCanvas);
begin
     Pantalla.pen.Color:=clYellow;
     Pantalla.Ellipse(Cx-r,Cy-r,Cx+r,Cy+r);
end;

procedure Ball.Move(dx, dy:Integer);
begin
     Cx:=Cx+dx;Cy:=Cy+dy;
end;

procedure Ball.setValues(x, y, ra: Integer);
begin
     Cx:=x;Cy:=y;R:=ra;
end;

end.

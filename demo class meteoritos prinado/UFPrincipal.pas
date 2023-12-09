unit UFPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,UCBall, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    B : Ball;
    Fi,Fd,Fa, Fb :Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
     B := Ball.Create;
     B.setValues(100,100,20);
     Fi:=0;Fd:=0;Fa:=0;Fb:=0;
end;

procedure TForm1.FormDblClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
          37:Fi:=-5;
          38:Fd:=5;
          39:Fa:=-5;
          40:Fb:=5;
     end;
     B.Move(Fi+Fd,Fa+Fb);
     Repaint;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     case Key of
          37:Fi:=0;
          38:Fd:=0;
          39:Fa:=0;
          40:Fb:=0;
     end;
end;

procedure TForm1.FormPaint(Sender: TObject);
  Var
   Cx,Cy,An,Hn : Integer;
   P1,P2,P3 : TPoint;
begin
     Cx:=Screen.Width div 2;
     Cy:=Screen.Height div 2;
     An:=Trunc(Screen.Width*0.02);
     Hn:=Trunc(Screen.Height*0.02);
     P1.X:=CX;P1.Y:=Cy-Hn;
     P2.X:=Cx-An;P2.Y:=Cy+Hn;
     P3.X:=Cx+An;P3.Y:=Cy+Hn;
     Canvas.Pen.Color:=clWhite;
     Canvas.Pen.Width:=4;
     Canvas.Brush.Color:=clYellow;
     Canvas.Polygon([P1,P2,P3]);
     B.Draw(Canvas);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     B.Move(2,1);
     Repaint;
end;

end.

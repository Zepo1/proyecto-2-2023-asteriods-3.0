unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCNave, UCBala,
  Vcl.ExtCtrls, Vcl.StdCtrls, UCAsteroide, AudioManager, Vcl.MPlayer;

type
  TForm1 = class(TForm)
    TimerNave: TTimer;
    TimerAceleracion: TTimer;
    TimerBala: TTimer;
    TimerAsteroide: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TimerNaveTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerAceleracionTimer(Sender: TObject);
    procedure TimerBalaTimer(Sender: TObject);
    procedure TimerAsteroideTimer(Sender: TObject);
  private
    nav: nave;
    rotizq, rotder, mover: boolean;
    bals: array[1..10] of bala;
    asteroids: array[1..10] of asteroide;
    movAster: integer;
    audio: TAudioManager;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const VELOCIDAD_ROTACION = 8;
      CANTIDAD_ASTEROIDES = 10;
      CANTIDAD_BALAS = 10;

procedure TForm1.FormCreate(Sender: TObject);
var i, ra, a: integer;
begin
  {Creacion de la nave}
  nav := nave.Create(Screen.Width div 2, Screen.Height div 2, 40);
  rotizq := false;
  rotder := false;
  mover := false;

  {Creacion de las balas}
  for i := 1 to CANTIDAD_BALAS do begin
     bals[i] := bala.Create(-1000, -1000);
  end;

  {Creacion de los asteroides}
  movAster := 1;
  for I := 1 to CANTIDAD_ASTEROIDES do begin
    randomize;
    ra := random(80)+20;
    randomize;
    a := random(45)-45;
    if i<=2 then begin
      //se van a crear arriba
      asteroids[i] := asteroide.Create(random(Screen.Width), 0, ra, -180+a);
    end else if i<=5 then begin
      //se van a crear a la izquierda
      asteroids[i] := asteroide.Create(0, random(Screen.Height), ra, 90+a);
    end else if i<=8 then begin
      //se van a crear a la derecha
      asteroids[i] := asteroide.Create(Screen.Width, random(Screen.Height), ra, -90+a);
    end else begin
      asteroids[i] := asteroide.Create(random(Screen.Width), Screen.Height, ra, 0+a);
      // se van a crear abajo
    end;
  end;

  {creacion del audio}
  audio := TAudioManager.Create;
  audio.AddSound('audios/disparo.wav');
  audio.AddSound('audios/muerte_nave.wav');

  {media player}
  //no esta creado
  //MediaPlayer1.FileName := 'audios/disparo.wav';
 // MediaPlayer1.Open;
  //MediaPlayer1.AutoRewind := true;

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i: integer;
begin
  {Eventos del teclado para controlar el disparo y la nave}
   case key of
      37: rotizq := true;
      39: rotder := true;
      38: mover := true;
      32: begin
            i := 1;
            while (i <= CANTIDAD_BALAS) do begin
              if bals[i].disponible then begin
                bals[i].punto := nav.p1;
                bals[i].angulo := nav.angulo;
                bals[i].disponible := false;
                audio.PlaySound(0);
                break;
              end;
              i:=i+1;
            end;
          end;
   end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Eventos para dejar de mover la nave}
     case key of
      37: rotizq := false;
      39: rotder := false;
      38: mover := false;
   end;
end;

procedure TForm1.FormPaint(Sender: TObject);
var i: integer;
begin
  {Dibujo de la nave}
  nav.dibujar(canvas);

  {Dibujo de la bala}
  for i := 1 to CANTIDAD_BALAS do begin
    if not bals[i].disponible then bals[i].dibujar(canvas);
  end;

  {Dibujo de los asteroides}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    asteroids[i].Draw(canvas);
  end;

end;

procedure TForm1.TimerAceleracionTimer(Sender: TObject);
begin
  {Efecto de aceleraciond de la nave}
  if mover then nav.acelerar
  else nav.desacelerar;
end;

procedure TForm1.TimerAsteroideTimer(Sender: TObject);
var i, ra, a: integer;
begin
  {Codigo para generar los asteroides}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    asteroids[i].Move;
    if (asteroids[i].Cx < -100)
    or (asteroids[i].Cy < -100)
    or (asteroids[i].Cx > Form1.Width+100)
    or (asteroids[i].Cy > Form1.Height+100)
    then begin
      randomize;
      ra := random(80)+20;
      randomize;
      a := random(90)-45;
      randomize;
      movAster := random(3)+1;
      if movAster=1 then begin
        //se van a crear arriba
        asteroids[i] := asteroide.Create(random(Screen.Width), 0, ra, -180+a);
      end else if movAster=2 then begin
        //se van a crear a la izquierda
        asteroids[i] := asteroide.Create(0, random(Screen.Height), ra, 90+a);
      end else if movAster=3 then begin
        //se van a crear a la derecha
        asteroids[i] := asteroide.Create(Screen.Width, random(Screen.Height), ra, -90+a);
      end else begin
        asteroids[i] := asteroide.Create(random(Screen.Width), Screen.Height, ra, 0+a);
        // se van a crear abajo
      end;
    end;
  end;
end;

function distancia(p1, p2: tpoint): integer;
begin
  result := trunc(sqrt(  (p2.X - p1.X)*(p2.X - p1.X)  + (p2.Y - p1.Y)*(p2.Y - p1.Y) ));
end;

procedure TForm1.TimerBalaTimer(Sender: TObject);
var i, j: integer;
begin
  {Control de las balas cuando salen del formulario}
  for i := 1 to CANTIDAD_BALAS do begin
      if not bals[i].disponible then begin
        bals[i].mover;
        if (bals[i].punto.X < 0)
        or (bals[i].punto.Y < 0)
        or (bals[i].punto.X > Form1.Width)
        or (bals[i].punto.Y > Form1.Height)
        then begin
          bals[i].disponible := true;
          bals[i].punto.X := -1000;
          bals[i].punto.Y := -1000;
        end;
      end;
      {Verificar choque de la bala con asteroide}
      for j := 1 to CANTIDAD_ASTEROIDES do begin
        if distancia(point(asteroids[j].Cx, asteroids[j].Cy), bals[i].punto) <= asteroids[j].R
        then begin
          bals[i].punto.X := -1000;
          bals[i].punto.Y := -1000;
          bals[i].disponible := true;
          {
          crear 2 asteroides
          if asteroids[j].R >= 40 then begin
            asteroids[j].R := asteroids[j].R div 2;
            asteroids[j].angulo := asteroids[j].angulo + random(90)-45;
            asteroids[j].velocidad := 3;
          end else begin
            asteroids[j].Cx := -255;
            asteroids[j].Cy := -255;
          end;
          }
          asteroids[j].Cx := -255;
          asteroids[j].Cy := -255;
        end;
      end;
  end;
end;



procedure TForm1.TimerNaveTimer(Sender: TObject);
var i: integer;
begin
  {Control de movimiento de la nave}
  if rotizq then nav.rotar(-VELOCIDAD_ROTACION);
  if rotder then nav.rotar(VELOCIDAD_ROTACION);
  if (mover) or (nav.enMovimiento) then nav.mover;
  if nav.centro.X > Form1.Width then nav.centro.X := 0;
  if nav.centro.Y > Form1.Height then nav.centro.Y := 0;
  if nav.centro.X < 0 then nav.centro.X := Form1.Width;
  if nav.centro.Y < 0 then nav.centro.Y := Form1.Height;

  {choque de la nave con algun asteroide}
  for i := 1 to CANTIDAD_ASTEROIDES do begin
    if (distancia(point(asteroids[i].Cx, asteroids[i].Cy), nav.p1) <= asteroids[i].R)
    or (distancia(point(asteroids[i].Cx, asteroids[i].Cy), nav.p2) <= asteroids[i].R)
    or (distancia(point(asteroids[i].Cx, asteroids[i].Cy), nav.p3) <= asteroids[i].R)
    then begin
      {Codigo para cuando muera la nave}
      nav.centro.X := Screen.Width div 2;
      nav.centro.Y := Screen.Height div 2;
      nav.angulo := 0;
      audio.PlaySound(1);
    end;
  end;
  invalidate;
  update;
end;

end.

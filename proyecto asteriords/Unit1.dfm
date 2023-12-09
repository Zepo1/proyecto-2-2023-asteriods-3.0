object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 723
  ClientWidth = 1041
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object TimerNave: TTimer
    Interval = 10
    OnTimer = TimerNaveTimer
    Left = 520
    Top = 312
  end
  object TimerAceleracion: TTimer
    Interval = 100
    OnTimer = TimerAceleracionTimer
    Left = 624
    Top = 312
  end
  object TimerBala: TTimer
    Interval = 10
    OnTimer = TimerBalaTimer
    Left = 472
    Top = 312
  end
  object TimerAsteroide: TTimer
    Interval = 10
    OnTimer = TimerAsteroideTimer
    Left = 568
    Top = 312
  end
end

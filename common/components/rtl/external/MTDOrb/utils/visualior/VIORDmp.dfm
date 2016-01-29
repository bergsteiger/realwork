object Form1: TForm1
  Left = 271
  Top = 177
  Width = 930
  Height = 640
  HorzScrollBar.Range = 118
  VertScrollBar.Range = 514
  ActiveControl = Button1
  Caption = 'Visual IOR Dump'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  DesignSize = (
    922
    613)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 130
    Top = 7
    Width = 83
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'IOR File Contents'
  end
  object Label2: TLabel
    Left = 130
    Top = 267
    Width = 74
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'IOR Information'
  end
  object Memo1: TMemo
    Left = 130
    Top = 26
    Width = 614
    Height = 228
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 130
    Top = 286
    Width = 614
    Height = 228
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 26
    Top = 20
    Width = 85
    Height = 39
    Caption = '&Load IOR'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 26
    Top = 286
    Width = 92
    Height = 40
    Caption = '&Save Info'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button2: TButton
    Left = 26
    Top = 65
    Width = 85
    Height = 40
    Caption = '&Parse content'
    TabOrder = 4
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ior'
    Filter = 'IOR File|*.ior|REF File|*.ref|Any File|*.*'
    Title = 'Find IOR File'
    Left = 24
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File|*.txt|Any File|*.*'
    Options = [ofOverwritePrompt, ofPathMustExist, ofEnableSizing]
    Title = 'Save IOR Dump Information'
    Left = 24
    Top = 192
  end
end

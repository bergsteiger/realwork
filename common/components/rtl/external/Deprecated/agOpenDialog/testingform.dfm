object Form1: TForm1
  Left = 354
  Top = 269
  Width = 360
  Height = 131
  Caption = 'Testing the new Windows 2000 File Open Dialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 161
    Height = 25
    Caption = 'Show File Open Dialog '
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 48
    Width = 161
    Height = 25
    Caption = 'Show File Save Dialog'
    TabOrder = 1
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 200
    Top = 24
    Width = 113
    Height = 17
    Caption = 'Show Places Bar'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object AgOpenDialog1: TAgOpenDialog
    DefaultExt = 'dpr'
    Filter = 'Delphi Files (*.pas, *.dfm)|*.pas;*.dfm|All Files (*.*)|*.*'
    InitialDir = 'd:\'
    Title = 'New File Open Dialog'
    ShowPlacesBar = True
    Left = 256
    Top = 32
  end
  object AgSaveDialog1: TAgSaveDialog
    ShowPlacesBar = True
    Left = 272
    Top = 40
  end
end

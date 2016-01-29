object Form1: TForm1
  Left = 277
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Calendar client'
  ClientHeight = 201
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 41
    Height = 13
    Caption = 'Address:'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 32
    Width = 269
    Height = 9
    Shape = bsBottomLine
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 26
    Height = 13
    Caption = 'Date:'
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 26
    Height = 13
    Caption = 'Note:'
  end
  object BindAddr: TEdit
    Left = 56
    Top = 7
    Width = 137
    Height = 21
    TabOrder = 0
    Text = 'inet:localhost:10000'
  end
  object BindBtn: TButton
    Left = 199
    Top = 6
    Width = 75
    Height = 23
    Caption = 'Bind'
    TabOrder = 1
    OnClick = BindBtnClick
  end
  object AppDate: TDateTimePicker
    Left = 10
    Top = 64
    Width = 183
    Height = 21
    CalAlignment = dtaLeft
    Date = 36669.7786118056
    Time = 36669.7786118056
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object AppNote: TMemo
    Left = 10
    Top = 103
    Width = 183
    Height = 89
    TabOrder = 3
  end
  object InsertBtn: TButton
    Left = 200
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Insert'
    Enabled = False
    TabOrder = 4
    OnClick = InsertBtnClick
  end
  object FindNoteBtn: TButton
    Left = 200
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Find note'
    Enabled = False
    TabOrder = 5
    OnClick = FindNoteBtnClick
  end
  object FindDateBtn: TButton
    Left = 201
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Find date'
    Enabled = False
    TabOrder = 6
    OnClick = FindDateBtnClick
  end
end

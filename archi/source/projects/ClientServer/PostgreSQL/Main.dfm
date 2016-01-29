object Form1: TForm1
  Left = 192
  Top = 124
  Width = 1305
  Height = 750
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 1060
    Top = 116
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 84
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 64
    Top = 132
    Width = 649
    Height = 409
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 1096
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Setup data'
    TabOrder = 2
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 248
    Top = 56
    Width = 97
    Height = 17
    Caption = 'SingleRow'
    TabOrder = 3
  end
  object ConnectBtn: TButton
    Left = 752
    Top = 128
    Width = 75
    Height = 25
    Caption = 'ConnectBtn'
    TabOrder = 4
    OnClick = ConnectBtnClick
  end
  object DisconnectBtn: TButton
    Left = 748
    Top = 520
    Width = 75
    Height = 25
    Caption = 'DisconnectBtn'
    TabOrder = 5
    OnClick = DisconnectBtnClick
  end
  object OpenBtn: TButton
    Left = 752
    Top = 184
    Width = 75
    Height = 25
    Caption = 'OpenBtn'
    TabOrder = 6
    OnClick = OpenBtnClick
  end
  object CloseBtn: TButton
    Left = 752
    Top = 484
    Width = 75
    Height = 25
    Caption = 'CloseBtn'
    TabOrder = 7
    OnClick = CloseBtnClick
  end
  object FetchOne: TButton
    Left = 752
    Top = 232
    Width = 75
    Height = 25
    Caption = 'FetchOne'
    TabOrder = 8
    OnClick = FetchOneClick
  end
  object CommitBtn: TButton
    Left = 988
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Commit'
    TabOrder = 9
    OnClick = CommitBtnClick
  end
  object LastBtn: TButton
    Left = 760
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Last'
    TabOrder = 10
    OnClick = LastBtnClick
  end
  object FirstBtn: TButton
    Left = 756
    Top = 332
    Width = 75
    Height = 25
    Caption = 'First'
    TabOrder = 11
    OnClick = FirstBtnClick
  end
  object Open2Btn: TButton
    Left = 860
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 12
    OnClick = Open2BtnClick
  end
  object Fetch2Btn: TButton
    Left = 860
    Top = 232
    Width = 75
    Height = 25
    Caption = 'FetchOne'
    TabOrder = 13
    OnClick = Fetch2BtnClick
  end
  object Last2Btn: TButton
    Left = 868
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Last'
    TabOrder = 14
    OnClick = Last2BtnClick
  end
  object First2Btn: TButton
    Left = 864
    Top = 332
    Width = 75
    Height = 25
    Caption = 'First'
    TabOrder = 15
    OnClick = First2BtnClick
  end
  object Close2Btn: TButton
    Left = 868
    Top = 420
    Width = 75
    Height = 21
    Caption = 'CloseBtn'
    TabOrder = 16
    OnClick = Close2BtnClick
  end
  object Button3: TButton
    Left = 1140
    Top = 120
    Width = 75
    Height = 25
    Caption = 'InsertOne'
    TabOrder = 17
    OnClick = Button3Click
  end
  object HandredLast: TButton
    Left = 756
    Top = 376
    Width = 75
    Height = 25
    Caption = '100 last'
    TabOrder = 18
    OnClick = HandredLastClick
  end
  object StressOpen: TButton
    Left = 752
    Top = 432
    Width = 75
    Height = 25
    Caption = 'StressOpen'
    TabOrder = 19
    OnClick = StressOpenClick
  end
  object TerminateCheck: TCheckBox
    Left = 880
    Top = 492
    Width = 97
    Height = 17
    Caption = 'Terminate'
    TabOrder = 20
  end
  object SpinEdit1: TSpinEdit
    Left = 876
    Top = 92
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 21
    Value = 500
  end
  object Button4: TButton
    Left = 986
    Top = 185
    Width = 75
    Height = 25
    Caption = 'Describe'
    TabOrder = 22
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 985
    Top = 295
    Width = 75
    Height = 25
    Caption = 'GetENcodings'
    TabOrder = 23
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 991
    Top = 343
    Width = 75
    Height = 25
    Caption = 'Set encoding'
    TabOrder = 24
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 995
    Top = 393
    Width = 75
    Height = 25
    Caption = 'CHeckENcoding'
    TabOrder = 25
    OnClick = Button7Click
  end
end

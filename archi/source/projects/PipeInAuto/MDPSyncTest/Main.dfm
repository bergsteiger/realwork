object Form2: TForm2
  Left = 192
  Top = 124
  Width = 661
  Height = 730
  Caption = 'ArchiAdapterTest'
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
    Left = 12
    Top = 14
    Width = 31
    Height = 13
    Caption = 'Library'
  end
  object Label2: TLabel
    Left = 14
    Top = 83
    Width = 54
    Height = 13
    Caption = 'Documents'
  end
  object Label3: TLabel
    Left = 155
    Top = 116
    Width = 28
    Height = 13
    Caption = 'Count'
  end
  object Label4: TLabel
    Left = 156
    Top = 147
    Width = 42
    Height = 13
    Caption = 'TopDate'
  end
  object ProgressLabel: TLabel
    Left = 429
    Top = 45
    Width = 3
    Height = 13
  end
  object Label5: TLabel
    Left = 156
    Top = 172
    Width = 56
    Height = 13
    Caption = 'NoTopDate'
  end
  object LoadBtn: TButton
    Left = 9
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 0
    OnClick = LoadBtnClick
  end
  object UnloadBtn: TButton
    Left = 92
    Top = 37
    Width = 75
    Height = 25
    Caption = 'Unload'
    TabOrder = 1
    OnClick = UnloadBtnClick
  end
  object LoadEdit: TEdit
    Left = 183
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '100'
  end
  object Button1: TButton
    Left = 316
    Top = 39
    Width = 75
    Height = 25
    Caption = 'In cycle'
    TabOrder = 3
    OnClick = Button1Click
  end
  object TypeGroup: TRadioGroup
    Left = 17
    Top = 107
    Width = 127
    Height = 60
    Caption = 'Type'
    ItemIndex = 0
    Items.Strings = (
      'TopCreated'
      'NoTopCreated')
    TabOrder = 4
  end
  object CountEdit: TEdit
    Left = 195
    Top = 114
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '70'
  end
  object GetNFreeBtn: TButton
    Left = 332
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Get&&Free'
    TabOrder = 6
    OnClick = GetNFreeBtnClick
  end
  object GetEdit: TEdit
    Left = 424
    Top = 123
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '100'
  end
  object Button3: TButton
    Left = 557
    Top = 122
    Width = 75
    Height = 25
    Caption = 'In cycle'
    TabOrder = 8
    OnClick = Button3Click
  end
  object UnloadCheck: TCheckBox
    Left = 12
    Top = 181
    Width = 131
    Height = 42
    Caption = 'Unload every time'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object TopDateEdit: TEdit
    Left = 209
    Top = 142
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'TopDateEdit'
  end
  object DefaultDateBtn: TButton
    Left = 337
    Top = 143
    Width = 75
    Height = 44
    Caption = 'Now - 1'
    TabOrder = 11
    OnClick = DefaultDateBtnClick
  end
  object LogMemo: TMemo
    Left = 17
    Top = 235
    Width = 605
    Height = 440
    TabOrder = 12
  end
  object NoTopDateEdit: TEdit
    Left = 209
    Top = 167
    Width = 121
    Height = 21
    TabOrder = 13
    Text = 'DateEdit'
  end
  object OneIterationBtn: TButton
    Left = 165
    Top = 200
    Width = 75
    Height = 25
    Caption = 'One Iteration'
    TabOrder = 14
    OnClick = OneIterationBtnClick
  end
  object Button2: TButton
    Left = 256
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Get All'
    TabOrder = 15
    OnClick = Button2Click
  end
end

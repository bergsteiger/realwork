object ButtonsFrame: TButtonsFrame
  Left = 0
  Top = 0
  Width = 560
  Height = 64
  TabOrder = 0
  DesignSize = (
    560
    64)
  object Bevel1: TBevel
    Left = 8
    Top = 12
    Width = 545
    Height = 2
    Anchors = [akLeft, akRight]
    Shape = bsTopLine
  end
  object HelpButton: TButton
    Left = 12
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1084#1086#1097#1100
    Enabled = False
    TabOrder = 0
  end
  object OkButton: TButton
    Left = 312
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 396
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object ApplyButton: TButton
    Left = 476
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = ApplyButtonClick
  end
  object textVersion: TStaticText
    Left = 0
    Top = 60
    Width = 560
    Height = 4
    Align = alBottom
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end

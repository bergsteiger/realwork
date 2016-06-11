object DSPortFram: TDSPortFram
  Left = 0
  Top = 0
  Width = 346
  Height = 55
  TabOrder = 0
  object LabelPort: TLabel
    Left = 3
    Top = 3
    Width = 45
    Height = 13
    Caption = 'LabelPort'
    FocusControl = EditPort
  end
  object EditPort: TEdit
    Left = 3
    Top = 22
    Width = 57
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object ButtonTest: TButton
    Left = 66
    Top = 20
    Width = 99
    Height = 25
    Caption = 'Test Port'
    TabOrder = 1
    OnClick = ButtonTestClick
  end
  object ButtonNextAvailable: TButton
    Left = 171
    Top = 20
    Width = 160
    Height = 25
    Caption = '&Find Open Port'
    TabOrder = 2
    OnClick = ButtonNextAvailableClick
  end
end

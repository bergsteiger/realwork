object SimpleButtonsFrame: TSimpleButtonsFrame
  Left = 0
  Top = 0
  Width = 331
  Height = 54
  TabOrder = 0
  DesignSize = (
    331
    54)
  object Bevel1: TBevel
    Left = 8
    Top = 10
    Width = 316
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
    Visible = False
  end
  object OkButton: TButton
    Left = 163
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
    Left = 247
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end

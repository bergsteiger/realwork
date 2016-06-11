inherited DSServerClassFrame: TDSServerClassFrame
  Width = 288
  Height = 86
  ExplicitWidth = 288
  ExplicitHeight = 86
  object rbTComponent: TRadioButton
    Left = 0
    Top = 1
    Width = 199
    Height = 20
    Caption = 'T&Component'
    TabOrder = 0
    OnClick = OnButtonClick
  end
  object rbDataModule: TRadioButton
    Left = 0
    Top = 20
    Width = 199
    Height = 20
    Caption = 'T&DataModule'
    TabOrder = 1
    OnClick = OnButtonClick
  end
  object rbDSServerModule: TRadioButton
    Left = 0
    Top = 39
    Width = 233
    Height = 20
    Caption = 'TD&SServerModule'
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = OnButtonClick
  end
end

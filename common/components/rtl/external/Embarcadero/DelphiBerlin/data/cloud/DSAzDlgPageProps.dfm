inherited AzPageProps: TAzPageProps
  Caption = 'AzPageProps'
  ClientHeight = 183
  ExplicitHeight = 211
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Height = 137
    ExplicitHeight = 137
  end
  object Label1: TLabel [1]
    Left = 311
    Top = 54
    Width = 34
    Height = 13
    Caption = 'Action:'
  end
  inherited OKBtn: TButton
    Top = 151
    TabOrder = 8
    ExplicitTop = 151
  end
  inherited CancelBtn: TButton
    Top = 151
    TabOrder = 9
    ExplicitTop = 151
  end
  inherited lbeCache: TLabeledEdit
    Left = 112
    Top = 80
    EditLabel.ExplicitLeft = 37
    EditLabel.ExplicitTop = 84
    TabOrder = 4
    ExplicitLeft = 112
    ExplicitTop = 80
  end
  inherited lbeType: TLabeledEdit
    Left = 352
    Top = 80
    EditLabel.ExplicitLeft = 321
    EditLabel.ExplicitTop = 84
    TabOrder = 5
    ExplicitLeft = 352
    ExplicitTop = 80
  end
  inherited lbeMD5: TLabeledEdit
    Left = 112
    Top = 107
    EditLabel.ExplicitLeft = 84
    EditLabel.ExplicitTop = 111
    TabOrder = 6
    ExplicitLeft = 112
    ExplicitTop = 107
  end
  inherited lbeEncoding: TLabeledEdit
    Left = 352
    Top = 107
    EditLabel.ExplicitLeft = 302
    EditLabel.ExplicitTop = 111
    TabOrder = 7
    ExplicitLeft = 352
    ExplicitTop = 107
  end
  inherited lbeLanguage: TLabeledEdit
    Left = 352
    Top = 24
    Width = 201
    EditLabel.ExplicitLeft = 302
    EditLabel.ExplicitTop = 28
    TabOrder = 1
    ExplicitLeft = 352
    ExplicitTop = 24
    ExplicitWidth = 201
  end
  object lbeLength: TLabeledEdit
    Left = 112
    Top = 24
    Width = 177
    Height = 21
    EditLabel.Width = 75
    EditLabel.Height = 13
    EditLabel.Caption = 'Length (bytes):'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 0
    OnChange = lbeCacheChange
  end
  object lbeNumber: TLabeledEdit
    Left = 112
    Top = 51
    Width = 177
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = 'Sequence Number:'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 2
    OnChange = lbeCacheChange
  end
  object cbxAction: TComboBox
    Left = 352
    Top = 53
    Width = 201
    Height = 21
    TabOrder = 3
    Text = 'update'
    OnChange = lbeCacheChange
    Items.Strings = (
      'max'
      'update'
      'increment')
  end
end

object FontPropPage: TFontPropPage
  Left = 198
  Top = 110
  Width = 396
  Height = 217
  Caption = 'Fonts'
  ParentFont = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object FontSizeCombo: TComboBox
    Left = 258
    Top = 54
    Width = 70
    Height = 21
    ItemHeight = 13
    Items.Strings = (
      '6'
      '8'
      '10'
      '12'
      '14'
      '16'
      '18'
      '20'
      '24'
      '28'
      '32'
      '36'
      '40'
      '48')
    TabOrder = 4
    OnChange = FontNameChange
  end
  object FontStyleCombo: TComboBox
    Left = 156
    Top = 54
    Width = 88
    Height = 21
    ItemHeight = 13
    Items.Strings = (
      'Regular'
      'Italic'
      'Bold'
      'Bold Italic')
    TabOrder = 3
    Text = 'Regular'
    OnChange = FontNameChange
  end
  object FontList: TListBox
    Left = 9
    Top = 75
    Width = 130
    Height = 103
    ItemHeight = 13
    TabOrder = 2
    OnClick = FontListClick
  end
  object FontName: TEdit
    Left = 9
    Top = 54
    Width = 130
    Height = 21
    ReadOnly = True
    TabOrder = 1
    OnChange = FontNameChange
  end
  object PropName: TComboBox
    Left = 108
    Top = 6
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = PropNameChange
  end
  object StaticText1: TStaticText
    Left = 9
    Top = 9
    Width = 83
    Height = 17
    Caption = '&Property Name:'
    TabOrder = 5
  end
  object StaticText2: TStaticText
    Left = 9
    Top = 33
    Width = 34
    Height = 17
    Caption = '&Font:'
    TabOrder = 6
  end
  object StaticText3: TStaticText
    Left = 153
    Top = 33
    Width = 60
    Height = 17
    Caption = 'Font St&yle:'
    TabOrder = 7
  end
  object StaticText4: TStaticText
    Left = 258
    Top = 33
    Width = 33
    Height = 17
    Caption = '&Size:'
    TabOrder = 8
  end
  object GroupBox1: TGroupBox
    Left = 150
    Top = 81
    Width = 226
    Height = 40
    Caption = 'Effects'
    TabOrder = 9
    object UnderlineCB: TCheckBox
      Left = 102
      Top = 15
      Width = 76
      Height = 17
      Caption = '&Underline'
      TabOrder = 1
      OnClick = UnderlineCBClick
    end
    object StrikeCB: TCheckBox
      Left = 12
      Top = 15
      Width = 82
      Height = 17
      Caption = 'Stri&keout'
      TabOrder = 0
      OnClick = StrikeCBClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 150
    Top = 129
    Width = 229
    Height = 55
    Caption = 'Sample'
    TabOrder = 10
    object Sample: TStaticText
      Left = 3
      Top = 21
      Width = 223
      Height = 22
      Alignment = taCenter
      AutoSize = False
      Caption = 'AaBbYyZz'
      TabOrder = 0
    end
  end
end

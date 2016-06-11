object ColorPropPage: TColorPropPage
  Left = 198
  Top = 111
  Width = 371
  Height = 153
  Caption = 'Colors'
  ParentFont = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ColorBtn: TButton
    Left = 210
    Top = 99
    Width = 121
    Height = 22
    Caption = 'Choose Color'
    TabOrder = 2
    OnClick = ColorBtnClick
  end
  object SysColor: TComboBox
    Left = 15
    Top = 81
    Width = 145
    Height = 21
    ItemHeight = 13
    Items.Strings = (
      'clScrollBar '
      'clBackground '
      'clActiveCaption '
      'clInactiveCaption '
      'clMenu '
      'clWindow '
      'clWindowFrame '
      'clMenuText '
      'clWindowText '
      'clCaptionText '
      'clActiveBorder '
      'clInactiveBorder '
      'clAppWorkSpace '
      'clHighlight '
      'clHighlightText '
      'clBtnFace '
      'clBtnShadow '
      'clGrayText '
      'clBtnText '
      'clInactiveCaptionText '
      'clBtnHighlight '
      'cl3DDkShadow '
      'cl3DLight '
      'clInfoText '
      'clInfoBk')
    TabOrder = 1
    OnChange = SysColorChange
  end
  object PropName: TComboBox
    Left = 15
    Top = 33
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = PropNameChange
  end
  object StaticText1: TStaticText
    Left = 9
    Top = 12
    Width = 83
    Height = 17
    Caption = '&Property Name:'
    TabOrder = 3
  end
  object StaticText2: TStaticText
    Left = 9
    Top = 60
    Width = 74
    Height = 17
    Caption = '&System Color:'
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 216
    Top = 18
    Width = 109
    Height = 73
    BevelInner = bvLowered
    TabOrder = 5
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 171
    Top = 12
  end
end

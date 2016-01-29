object PicturePropPage: TPicturePropPage
  Left = 196
  Top = 113
  Width = 397
  Height = 168
  Caption = 'Pictures'
  ParentFont = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 213
    Top = 6
    Width = 169
    Height = 112
    Style = bsRaised
  end
  object Image1: TImage
    Left = 213
    Top = 6
    Width = 169
    Height = 130
    Stretch = True
  end
  object BrowseBtn: TButton
    Left = 9
    Top = 63
    Width = 70
    Height = 25
    Caption = '&Browse...'
    TabOrder = 3
    OnClick = BrowseBtnClick
  end
  object PropName: TComboBox
    Left = 9
    Top = 30
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = PropNameChange
  end
  object StaticText1: TStaticText
    Left = 6
    Top = 9
    Width = 83
    Height = 17
    Caption = '&Property Name:'
    TabOrder = 1
  end
  object StaticText2: TStaticText
    Left = 153
    Top = 9
    Width = 51
    Height = 17
    Caption = 'P&review:'
    TabOrder = 2
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Title = 'Load Picture'
    Left = 60
    Top = 96
  end
end

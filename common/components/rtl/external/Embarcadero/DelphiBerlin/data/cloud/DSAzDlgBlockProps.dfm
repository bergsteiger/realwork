object AzBlockProps: TAzBlockProps
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Block Blob Properties'
  ClientHeight = 161
  ClientWidth = 580
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 564
    Height = 113
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 416
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 497
    Top = 127
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object lbeCache: TLabeledEdit
    Left = 96
    Top = 24
    Width = 177
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = 'Cache Control:'
    LabelPosition = lpLeft
    TabOrder = 0
    OnChange = lbeCacheChange
  end
  object lbeType: TLabeledEdit
    Left = 336
    Top = 24
    Width = 201
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Type:'
    LabelPosition = lpLeft
    TabOrder = 1
    OnChange = lbeCacheChange
  end
  object lbeMD5: TLabeledEdit
    Left = 96
    Top = 51
    Width = 177
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'MD5:'
    LabelPosition = lpLeft
    TabOrder = 2
    OnChange = lbeCacheChange
  end
  object lbeEncoding: TLabeledEdit
    Left = 336
    Top = 51
    Width = 201
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Encoding:'
    LabelPosition = lpLeft
    TabOrder = 3
    OnChange = lbeCacheChange
  end
  object lbeLanguage: TLabeledEdit
    Left = 96
    Top = 78
    Width = 441
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Language'
    LabelPosition = lpLeft
    TabOrder = 4
    OnChange = lbeCacheChange
  end
end

object AzBlock: TAzBlock
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Block Blob'
  ClientHeight = 187
  ClientWidth = 466
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 450
    Height = 137
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 302
    Top = 154
    Width = 75
    Height = 25
    Caption = 'Apply'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 383
    Top = 154
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object lblBlockId: TLabeledEdit
    Left = 64
    Top = 24
    Width = 380
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Block ID:'
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object lblMD5: TLabeledEdit
    Left = 64
    Top = 51
    Width = 380
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'MD5:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object lblLeaseId: TLabeledEdit
    Left = 64
    Top = 78
    Width = 380
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Lease ID:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object lblLocation: TLabeledEdit
    Left = 64
    Top = 105
    Width = 341
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = 'Location:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object btnFile: TButton
    Left = 411
    Top = 105
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = btnFileClick
  end
end

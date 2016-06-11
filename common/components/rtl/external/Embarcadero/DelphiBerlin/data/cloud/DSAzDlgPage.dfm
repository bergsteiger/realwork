object AzPage: TAzPage
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Blob Page'
  ClientHeight = 397
  ClientWidth = 488
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 465
    Height = 337
    Shape = bsFrame
  end
  object lbStartByte: TLabel
    Left = 24
    Top = 24
    Width = 68
    Height = 13
    Caption = 'Page Number:'
  end
  object Label1: TLabel
    Left = 224
    Top = 24
    Width = 129
    Height = 13
    Caption = '(each page has 512 bytes)'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 60
    Height = 13
    Caption = 'Page Count:'
  end
  object OKBtn: TButton
    Left = 317
    Top = 364
    Width = 75
    Height = 25
    Caption = 'Apply'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object CancelBtn: TButton
    Left = 398
    Top = 364
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object edtStartByte: TEdit
    Left = 98
    Top = 21
    Width = 103
    Height = 21
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 0
    Text = '0'
  end
  object edtPageCount: TEdit
    Left = 98
    Top = 53
    Width = 103
    Height = 21
    Alignment = taRightJustify
    TabOrder = 1
    Text = '1'
  end
  object rgOperation: TRadioGroup
    Left = 16
    Top = 80
    Width = 449
    Height = 73
    Caption = 'Operation'
    ItemIndex = 0
    Items.Strings = (
      'Write the byte content into the specified range'
      'Clears the specified range and releases the space')
    TabOrder = 2
  end
  object gbCriteria: TGroupBox
    Left = 16
    Top = 159
    Width = 449
    Height = 138
    Caption = 'Optional Criteria'
    TabOrder = 3
    object lblSequence: TLabel
      Left = 236
      Top = 19
      Width = 51
      Height = 13
      Caption = 'Sequence:'
    end
    object Label3: TLabel
      Left = 28
      Top = 72
      Width = 29
      Height = 13
      Caption = 'Since:'
    end
    object lblIf: TLabel
      Left = 45
      Top = 101
      Width = 12
      Height = 13
      Caption = 'If:'
    end
    object lblMD5: TLabeledEdit
      Left = 62
      Top = 19
      Width = 161
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'MD5:'
      LabelPosition = lpLeft
      TabOrder = 0
    end
    object lblLease: TLabeledEdit
      Left = 62
      Top = 46
      Width = 375
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Lease ID:'
      LabelPosition = lpLeft
      TabOrder = 3
    end
    object cbSequenceOp: TComboBox
      Left = 293
      Top = 19
      Width = 49
      Height = 21
      ItemIndex = 0
      TabOrder = 1
      Text = '<='
      Items.Strings = (
        '<='
        ' < '
        ' = ')
    end
    object edtSequence: TEdit
      Left = 348
      Top = 19
      Width = 89
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 2
      Text = '0'
    end
    object cbSince: TComboBox
      Left = 63
      Top = 73
      Width = 70
      Height = 21
      ItemIndex = 0
      TabOrder = 4
      Text = 'Modified'
      Items.Strings = (
        'Modified'
        'Unmodified')
    end
    object edtSince: TEdit
      Left = 139
      Top = 73
      Width = 298
      Height = 21
      TabOrder = 5
    end
    object edtMatch: TEdit
      Left = 139
      Top = 100
      Width = 298
      Height = 21
      TabOrder = 7
    end
    object cbMatch: TComboBox
      Left = 63
      Top = 100
      Width = 70
      Height = 21
      TabOrder = 6
      Text = 'Match'
      Items.Strings = (
        'Match'
        'None Match')
    end
  end
  object lblContentLocation: TLabeledEdit
    Left = 110
    Top = 303
    Width = 304
    Height = 21
    EditLabel.Width = 86
    EditLabel.Height = 13
    EditLabel.Caption = 'Content Location:'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object btnExplorer: TButton
    Left = 420
    Top = 303
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 5
    OnClick = btnExplorerClick
  end
end

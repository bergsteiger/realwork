object AzCopyBlob: TAzCopyBlob
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Copy Blob'
  ClientHeight = 531
  ClientWidth = 512
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 496
    Height = 481
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 348
    Top = 495
    Width = 75
    Height = 25
    Caption = 'Copy'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 429
    Top = 495
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object gbDestination: TGroupBox
    Left = 25
    Top = 104
    Width = 465
    Height = 129
    Caption = 'Destination'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 74
      Width = 72
      Height = 13
      Caption = 'Modified Since:'
    end
    object Label2: TLabel
      Left = 16
      Top = 98
      Width = 33
      Height = 13
      Caption = 'Match:'
    end
    object Label4: TLabel
      Left = 240
      Top = 74
      Width = 85
      Height = 13
      Caption = 'Unmodified Since:'
    end
    object Label3: TLabel
      Left = 264
      Top = 98
      Width = 61
      Height = 13
      Caption = 'None Match:'
    end
    object edtModifiedSince: TEdit
      Left = 94
      Top = 71
      Width = 132
      Height = 21
      TabOrder = 2
    end
    object edtUnmodified: TEdit
      Left = 331
      Top = 71
      Width = 118
      Height = 21
      TabOrder = 3
    end
    object edtNoneMatch: TEdit
      Left = 331
      Top = 98
      Width = 118
      Height = 21
      TabOrder = 5
    end
    object edtMatch: TEdit
      Left = 94
      Top = 98
      Width = 132
      Height = 21
      TabOrder = 4
    end
    object lbeDestBlob: TLabeledEdit
      Left = 166
      Top = 44
      Width = 283
      Height = 21
      EditLabel.Width = 111
      EditLabel.Height = 13
      EditLabel.Caption = 'Destination Blob Name:'
      LabelPosition = lpLeft
      TabOrder = 1
      OnChange = lbeDestContainerChange
    end
    object lbeDestContainer: TLabeledEdit
      Left = 166
      Top = 17
      Width = 283
      Height = 21
      EditLabel.Width = 138
      EditLabel.Height = 13
      EditLabel.Caption = 'Destination Container Name:'
      LabelPosition = lpLeft
      TabOrder = 0
      OnChange = lbeDestContainerChange
    end
  end
  object vleMeta: TValueListEditor
    Left = 25
    Top = 239
    Width = 465
    Height = 234
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 2
    TitleCaptions.Strings = (
      'Metadata Name'
      'Value')
    ColWidths = (
      150
      309)
  end
  object btnAddMetadata: TButton
    Left = 25
    Top = 495
    Width = 83
    Height = 25
    Caption = 'Add metadata'
    TabOrder = 3
    OnClick = btnAddMetadataClick
  end
  object btnDelMetadata: TButton
    Left = 114
    Top = 495
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 4
    OnClick = btnDelMetadataClick
  end
  object gbSource: TGroupBox
    Left = 25
    Top = 17
    Width = 465
    Height = 81
    Caption = 'Source Conditions (optional)'
    TabOrder = 0
    object Label5: TLabel
      Left = 16
      Top = 24
      Width = 72
      Height = 13
      Caption = 'Modified Since:'
    end
    object Label6: TLabel
      Left = 16
      Top = 48
      Width = 33
      Height = 13
      Caption = 'Match:'
    end
    object Label7: TLabel
      Left = 240
      Top = 51
      Width = 61
      Height = 13
      Caption = 'None Match:'
    end
    object Label8: TLabel
      Left = 240
      Top = 24
      Width = 85
      Height = 13
      Caption = 'Unmodified Since:'
    end
    object edtSrcMod: TEdit
      Left = 94
      Top = 21
      Width = 132
      Height = 21
      TabOrder = 0
    end
    object edtSrcUnmod: TEdit
      Left = 331
      Top = 21
      Width = 118
      Height = 21
      TabOrder = 1
    end
    object edtSrcNoneMatch: TEdit
      Left = 331
      Top = 48
      Width = 118
      Height = 21
      TabOrder = 3
    end
    object edtSrcMatch: TEdit
      Left = 94
      Top = 48
      Width = 132
      Height = 21
      TabOrder = 2
    end
  end
end

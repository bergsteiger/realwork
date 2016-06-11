object AzSnapshotBlob: TAzSnapshotBlob
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Create Snapshot Blob'
  ClientHeight = 462
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
    Height = 409
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 348
    Top = 423
    Width = 75
    Height = 25
    Caption = 'Create'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 429
    Top = 423
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 25
    Top = 16
    Width = 465
    Height = 81
    Caption = 'Conditions (optional)'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 72
      Height = 13
      Caption = 'Modified Since:'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 33
      Height = 13
      Caption = 'Match:'
    end
    object Label3: TLabel
      Left = 240
      Top = 51
      Width = 61
      Height = 13
      Caption = 'None Match:'
    end
    object Label4: TLabel
      Left = 240
      Top = 24
      Width = 85
      Height = 13
      Caption = 'Unmodified Since:'
    end
    object edtModifiedSince: TEdit
      Left = 94
      Top = 21
      Width = 132
      Height = 21
      TabOrder = 0
    end
    object edtUnmodified: TEdit
      Left = 331
      Top = 21
      Width = 118
      Height = 21
      TabOrder = 1
    end
    object edtNoneMatch: TEdit
      Left = 331
      Top = 48
      Width = 118
      Height = 21
      TabOrder = 3
    end
    object edtMatch: TEdit
      Left = 94
      Top = 48
      Width = 132
      Height = 21
      TabOrder = 2
    end
  end
  object vleMeta: TValueListEditor
    Left = 25
    Top = 103
    Width = 465
    Height = 298
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 1
    TitleCaptions.Strings = (
      'Metadata Name'
      'Value')
    ColWidths = (
      150
      309)
  end
  object btnAddMetadata: TButton
    Left = 25
    Top = 423
    Width = 83
    Height = 25
    Caption = 'Add metadata'
    TabOrder = 2
    OnClick = btnAddMetadataClick
  end
  object btnDelMetadata: TButton
    Left = 114
    Top = 423
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 3
    OnClick = btnDelMetadataClick
  end
end

object AzBlockBlob: TAzBlockBlob
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Create Block Blob'
  ClientHeight = 529
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
    Height = 482
    Shape = bsFrame
  end
  object lblBlobName: TLabel
    Left = 24
    Top = 24
    Width = 54
    Height = 13
    Caption = 'Blob Name:'
  end
  object lblContentLocation: TLabel
    Left = 24
    Top = 137
    Width = 86
    Height = 13
    Caption = 'Content Location:'
  end
  object OKBtn: TButton
    Left = 348
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Create'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 7
  end
  object CancelBtn: TButton
    Left = 429
    Top = 496
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object edtBlobName: TEdit
    Left = 93
    Top = 21
    Width = 396
    Height = 21
    TabOrder = 0
    OnChange = edtBlobNameChange
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 48
    Width = 465
    Height = 81
    Caption = 'Content (optional)'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 47
      Height = 13
      Caption = 'Encoding:'
    end
    object Label3: TLabel
      Left = 240
      Top = 51
      Width = 25
      Height = 13
      Caption = 'MD5:'
    end
    object Label4: TLabel
      Left = 240
      Top = 24
      Width = 51
      Height = 13
      Caption = 'Language:'
    end
    object edtContentType: TEdit
      Left = 69
      Top = 21
      Width = 157
      Height = 21
      TabOrder = 0
      Text = 'application/octet-stream'
    end
    object edtLanguage: TEdit
      Left = 297
      Top = 21
      Width = 152
      Height = 21
      TabOrder = 1
    end
    object edtMD5: TEdit
      Left = 297
      Top = 48
      Width = 152
      Height = 21
      TabOrder = 3
    end
    object edtEncoding: TEdit
      Left = 69
      Top = 48
      Width = 157
      Height = 21
      TabOrder = 2
    end
  end
  object edtFilename: TEdit
    Left = 24
    Top = 156
    Width = 425
    Height = 21
    TabOrder = 2
  end
  object btnFile: TButton
    Left = 455
    Top = 154
    Width = 35
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = btnFileClick
  end
  object vleMeta: TValueListEditor
    Left = 24
    Top = 183
    Width = 465
    Height = 298
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 4
    TitleCaptions.Strings = (
      'Metadata Name'
      'Value')
    ColWidths = (
      150
      309)
  end
  object btnAddMetadata: TButton
    Left = 25
    Top = 496
    Width = 83
    Height = 25
    Caption = 'Add Metadata'
    TabOrder = 5
    OnClick = btnAddMetadataClick
  end
  object btnDelMetadata: TButton
    Left = 114
    Top = 496
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 6
    OnClick = btnDelMetadataClick
  end
end

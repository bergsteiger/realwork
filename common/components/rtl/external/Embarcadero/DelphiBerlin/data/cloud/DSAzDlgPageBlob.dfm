object AzPageBlob: TAzPageBlob
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Page Blob'
  ClientHeight = 596
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
    Height = 545
    Shape = bsFrame
  end
  object lblBlobName: TLabel
    Left = 24
    Top = 24
    Width = 54
    Height = 13
    Caption = 'Blob Name:'
  end
  object lblContentLength: TLabel
    Left = 25
    Top = 56
    Width = 102
    Height = 13
    Caption = 'Blob Content Length:'
  end
  object OKBtn: TButton
    Left = 348
    Top = 559
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
    Top = 559
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object edtBlobName: TEdit
    Left = 136
    Top = 21
    Width = 353
    Height = 21
    TabOrder = 0
    OnChange = edtBlobNameChange
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 80
    Width = 465
    Height = 105
    Caption = 'Content (optional)'
    TabOrder = 3
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
    object Label5: TLabel
      Left = 12
      Top = 75
      Width = 51
      Height = 13
      Caption = 'Sequence:'
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
    object edtSequence: TEdit
      Left = 69
      Top = 75
      Width = 380
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 4
      Text = '0'
    end
  end
  object vleMeta: TValueListEditor
    Left = 24
    Top = 191
    Width = 465
    Height = 346
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
    Top = 559
    Width = 83
    Height = 25
    Caption = 'Add Metadata'
    TabOrder = 5
    OnClick = btnAddMetadataClick
  end
  object btnDelMetadata: TButton
    Left = 114
    Top = 559
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 6
    OnClick = btnDelMetadataClick
  end
  object edtContentLength: TEdit
    Left = 136
    Top = 53
    Width = 114
    Height = 21
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 1
    Text = '1'
  end
  object cbUnit: TComboBox
    Left = 256
    Top = 53
    Width = 81
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'bytes'
    Items.Strings = (
      'bytes'
      'KB'
      'MB'
      'TB')
  end
end

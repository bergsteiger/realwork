object AzPutBlockList: TAzPutBlockList
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Put Block List'
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
  object OKBtn: TButton
    Left = 348
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Commit'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 429
    Top = 496
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 25
    Top = 184
    Width = 465
    Height = 105
    Caption = 'Blob Content (optional)'
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 24
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object Label2: TLabel
      Left = 13
      Top = 52
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
      Left = 13
      Top = 79
      Width = 54
      Height = 13
      Caption = 'Cache Ctrl:'
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
    object edtCacheControl: TEdit
      Left = 69
      Top = 75
      Width = 380
      Height = 21
      TabOrder = 4
    end
  end
  object vleMeta: TValueListEditor
    Left = 25
    Top = 295
    Width = 465
    Height = 178
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
  object btnDelMetadata: TButton
    Left = 114
    Top = 496
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 4
    OnClick = btnDelMetadataClick
  end
  object btnAddMetadata: TButton
    Left = 25
    Top = 496
    Width = 83
    Height = 25
    Caption = 'Add metadata'
    TabOrder = 3
    OnClick = btnAddMetadataClick
  end
  object grbUploaded: TGroupBox
    Left = 26
    Top = 16
    Width = 464
    Height = 162
    Caption = 'Uploaded Blocks'
    TabOrder = 0
    object Label6: TLabel
      Left = 13
      Top = 37
      Width = 55
      Height = 13
      Caption = 'Committed:'
    end
    object Label7: TLabel
      Left = 240
      Top = 37
      Width = 66
      Height = 13
      Caption = 'Uncommitted:'
    end
    object cbxCommitLatest: TCheckBox
      Left = 13
      Top = 14
      Width = 97
      Height = 17
      Caption = 'Commit all latest'
      TabOrder = 0
      OnClick = cbxCommitLatestClick
    end
    object clbCommitted: TCheckListBox
      Left = 13
      Top = 56
      Width = 213
      Height = 97
      OnClickCheck = clbCommittedClickCheck
      ItemHeight = 13
      TabOrder = 1
    end
    object clbUncommitted: TCheckListBox
      Left = 240
      Top = 56
      Width = 209
      Height = 97
      OnClickCheck = clbUncommittedClickCheck
      ItemHeight = 13
      TabOrder = 2
    end
  end
end

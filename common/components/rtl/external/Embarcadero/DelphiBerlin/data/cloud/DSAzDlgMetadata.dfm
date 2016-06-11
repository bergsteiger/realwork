object AzMetadata: TAzMetadata
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Metadata Editor'
  ClientHeight = 334
  ClientWidth = 488
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    488
    334)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 324
    Top = 301
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object CancelBtn: TButton
    Left = 405
    Top = 301
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object vleMeta: TValueListEditor
    Left = 8
    Top = 8
    Width = 472
    Height = 281
    Anchors = [akLeft, akTop, akRight, akBottom]
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 0
    TitleCaptions.Strings = (
      'Metadata Name'
      'Value')
    OnStringsChange = vleMetaStringsChange
    ColWidths = (
      150
      316)
  end
  object btnDelMetadata: TButton
    Left = 79
    Top = 301
    Width = 66
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Remove'
    TabOrder = 2
    OnClick = btnDelMetadataClick
  end
  object btnAddMetadata: TButton
    Left = 8
    Top = 301
    Width = 65
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddMetadataClick
  end
end

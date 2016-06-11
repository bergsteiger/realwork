object AzureQueueMetadataDialog: TAzureQueueMetadataDialog
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Azure Queue Metadata'
  ClientHeight = 228
  ClientWidth = 494
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    494
    228)
  PixelsPerInch = 96
  TextHeight = 13
  object MetadataList: TValueListEditor
    Left = 8
    Top = 8
    Width = 478
    Height = 181
    Anchors = [akLeft, akTop, akRight, akBottom]
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    TabOrder = 0
    OnStringsChange = MetadataListStringsChange
    ColWidths = (
      174
      298)
  end
  object ButtClose: TButton
    Left = 411
    Top = 195
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 11
    TabOrder = 4
  end
  object ButtCommit: TButton
    Left = 282
    Top = 195
    Width = 123
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Commit Changes'
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object btnDelMetadata: TButton
    Left = 79
    Top = 195
    Width = 66
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Remove'
    TabOrder = 2
    OnClick = btnDelMetadataClick
  end
  object btnAddMetadata: TButton
    Left = 8
    Top = 195
    Width = 65
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddMetadataClick
  end
end

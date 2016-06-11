object AzCreateContainerDlg: TAzCreateContainerDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Create Container'
  ClientHeight = 343
  ClientWidth = 752
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    752
    343)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 583
    Top = 312
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Create'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 664
    Top = 312
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object GridPanel1: TGridPanel
    Left = 21
    Top = 8
    Width = 723
    Height = 291
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = FlowPanel1
        Row = 0
      end
      item
        Column = 0
        Control = rgPublicDataAccess
        Row = 1
      end
      item
        Column = 0
        Control = vleMeta
        Row = 2
      end>
    RowCollection = <
      item
        Value = 13.429522752497220000
      end
      item
        Value = 19.422863485016650000
      end
      item
        Value = 67.147613762486130000
      end>
    TabOrder = 0
    DesignSize = (
      723
      291)
    object FlowPanel1: TFlowPanel
      AlignWithMargins = True
      Left = 9
      Top = 3
      Width = 704
      Height = 32
      Alignment = taLeftJustify
      Anchors = [akLeft, akRight]
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        704
        32)
      object lbName: TLabel
        Left = 0
        Top = 0
        Width = 84
        Height = 13
        Caption = 'Container Name: '
      end
      object edtContainerName: TEdit
        Left = 84
        Top = 0
        Width = 613
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = edtContainerNameChange
      end
    end
    object rgPublicDataAccess: TRadioGroup
      Left = 2
      Top = 39
      Width = 718
      Height = 55
      Anchors = [akLeft, akRight]
      Caption = 'Public Data Access'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Public read access for container and blobs'
        'Public read access for blobs'
        'Private')
      TabOrder = 1
    end
    object vleMeta: TValueListEditor
      Left = 4
      Top = 96
      Width = 715
      Height = 194
      Anchors = [akLeft, akRight]
      KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
      TabOrder = 2
      TitleCaptions.Strings = (
        'Metadata name'
        'Value')
      ColWidths = (
        150
        559)
    end
  end
  object btnAddMetadata: TButton
    Left = 25
    Top = 312
    Width = 83
    Height = 25
    Caption = 'Add Metadata'
    TabOrder = 1
    OnClick = btnAddMetadataClick
  end
  object btnDelMetadata: TButton
    Left = 114
    Top = 312
    Width = 103
    Height = 25
    Caption = 'Remove Metadata'
    TabOrder = 2
    OnClick = btnDelMetadataClick
  end
end

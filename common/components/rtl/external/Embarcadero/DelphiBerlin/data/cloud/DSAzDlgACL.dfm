object AzACL: TAzACL
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Access Control List'
  ClientHeight = 421
  ClientWidth = 525
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    525
    421)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 509
    Height = 377
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object gbxAccessPolicy: TGroupBox
    Left = 21
    Top = 287
    Width = 476
    Height = 84
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    object cbxRead: TCheckBox
      Left = 21
      Top = 55
      Width = 97
      Height = 17
      Caption = 'Read'
      TabOrder = 2
      OnClick = cbxReadClick
    end
    object cbxDelete: TCheckBox
      Left = 256
      Top = 56
      Width = 97
      Height = 17
      Caption = 'Delete'
      TabOrder = 4
      OnClick = cbxDeleteClick
    end
    object cbxWrite: TCheckBox
      Left = 124
      Top = 56
      Width = 97
      Height = 17
      Caption = 'Write'
      TabOrder = 3
      OnClick = cbxWriteClick
    end
    object cbxList: TCheckBox
      Left = 364
      Top = 56
      Width = 97
      Height = 17
      Caption = 'List'
      TabOrder = 5
      OnClick = cbxListClick
    end
    object lbeStart: TLabeledEdit
      Left = 64
      Top = 20
      Width = 163
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Start date:'
      LabelPosition = lpLeft
      TabOrder = 0
      OnChange = lbeStartChange
    end
    object lbeExpiry: TLabeledEdit
      Left = 302
      Top = 21
      Width = 163
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'Expiry date:'
      LabelPosition = lpLeft
      TabOrder = 1
      OnChange = lbeExpiryChange
    end
  end
  object OKBtn: TButton
    Left = 361
    Top = 391
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
    Left = 442
    Top = 391
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object rgPublicDataAccess: TRadioGroup
    Left = 21
    Top = 15
    Width = 476
    Height = 90
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Public Data Access'
    ItemIndex = 0
    Items.Strings = (
      'Full public read access for container and blob data'
      'Public read access for blobs'
      'None')
    TabOrder = 0
    OnClick = rgPublicDataAccessClick
  end
  object gbxIdentifiers: TGroupBox
    Left = 21
    Top = 111
    Width = 476
    Height = 170
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Policy Identifiers'
    TabOrder = 1
    DesignSize = (
      476
      170)
    object sgId: TStringGrid
      Left = 21
      Top = 24
      Width = 438
      Height = 132
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 1
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
      TabOrder = 0
      OnGetEditText = sgIdGetEditText
      OnSelectCell = sgIdSelectCell
      OnSetEditText = sgIdSetEditText
      ColWidths = (
        429)
    end
  end
end

object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Bookmark search'
  ClientHeight = 331
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 283
    Width = 73
    Height = 13
    Caption = 'Search depth'
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 8
    Width = 345
    Height = 193
    Indent = 19
    TabOrder = 0
    OnMouseUp = TreeView1MouseUp
  end
  object btnLoad: TButton
    Left = 325
    Top = 217
    Width = 28
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btnLoadClick
  end
  object edtFilename: TLabeledEdit
    Left = 8
    Top = 219
    Width = 311
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Filename'
    TabOrder = 2
    OnExit = edtFilenameExit
  end
  object edtSearch: TLabeledEdit
    Left = 8
    Top = 256
    Width = 265
    Height = 21
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Seacrh Title'
    TabOrder = 3
  end
  object btnSearch: TButton
    Left = 279
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 4
    OnClick = btnSearchClick
  end
  object cbDepth: TComboBox
    Left = 8
    Top = 302
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Full subtree'
    Items.Strings = (
      'Full subtree'
      'Children only'
      'Siblings only')
  end
  object OpenDialog1: TOpenDialog
    Left = 400
    Top = 8
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.4'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 368
    Top = 8
  end
end

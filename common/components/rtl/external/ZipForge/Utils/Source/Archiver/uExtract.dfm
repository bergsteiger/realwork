object frmExtract: TfrmExtract
  Left = 412
  Top = 247
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Extraction path and options'
  ClientHeight = 297
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 77
    Height = 13
    Caption = 'Destination path'
  end
  object btnOK: TBitBtn
    Left = 200
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btnOKClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 288
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object rgOptions: TRadioGroup
    Left = 16
    Top = 96
    Width = 185
    Height = 113
    Caption = 'Options'
    ItemIndex = 0
    Items.Strings = (
      'Overwrite without prompt'
      'Update files'
      'Ask before overwrite'
      'Skip existing files')
    TabOrder = 2
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 24
    Width = 377
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 3
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 224
    Top = 56
    Width = 161
    Height = 201
    BevelKind = bkFlat
    ItemHeight = 16
    TabOrder = 4
  end
end

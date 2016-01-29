object adxRibbonContextMenuNamesEditor: TadxRibbonContextMenuNamesEditor
  Left = 266
  Top = 235
  BorderStyle = bsDialog
  Caption = '%s editor'
  ClientHeight = 300
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 267
    Width = 400
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblHelp: TLabel
      Left = 5
      Top = 5
      Width = 208
      Height = 13
      Caption = 'Insert key - add row, Delete key - delete row'
    end
    object btnOK: TButton
      Left = 240
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 320
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 267
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 0
  end
end

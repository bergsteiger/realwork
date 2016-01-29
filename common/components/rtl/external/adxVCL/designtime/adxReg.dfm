object RTDTopicStringsDialog: TRTDTopicStringsDialog
  Left = 848
  Top = 396
  ActiveControl = sgTopics
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  ClientHeight = 371
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object panDesktop: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 340
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 0
    object sgTopics: TStringGrid
      Left = 5
      Top = 5
      Width = 332
      Height = 330
      Align = alClient
      ColCount = 2
      DefaultColWidth = 95
      DefaultRowHeight = 17
      RowCount = 29
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing]
      TabOrder = 0
      OnKeyDown = sgTopicsKeyDown
      RowHeights = (
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17
        17)
    end
  end
  object panButtons: TPanel
    Left = 0
    Top = 340
    Width = 342
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object btnOK: TButton
      Left = 185
      Top = 2
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
      Left = 265
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end

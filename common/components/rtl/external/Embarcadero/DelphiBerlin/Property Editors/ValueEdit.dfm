inherited ValueEditDlg: TValueEditDlg
  HelpContext = 26005
  ActiveControl = ValueListEditor1
  Caption = 'Value List Editor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CodeWndBtn: TButton
    Top = 247
  end
  inherited HelpButton: TButton
    Left = 345
    Top = 247
  end
  inherited OKButton: TButton
    Left = 185
    Top = 247
  end
  inherited CancelButton: TButton
    Left = 265
    Top = 247
  end
  object ValueListEditor1: TValueListEditor [4]
    Left = 8
    Top = 7
    Width = 413
    Height = 234
    Anchors = [akLeft, akTop, akRight, akBottom]
    KeyOptions = [keyEdit, keyAdd, keyDelete]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 4
    OnKeyDown = ValueListEditor1KeyDown
    OnStringsChange = ValueListEditor1StringsChange
    ColWidths = (
      150
      257)
  end
end

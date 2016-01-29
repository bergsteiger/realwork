object LogDetailFrame: TLogDetailFrame
  Left = 0
  Top = 0
  Width = 315
  Height = 301
  TabOrder = 0
  object Memo1: TMemo
    Left = -1
    Top = 0
    Width = 314
    Height = 283
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    PopupMenu = PopupMenu1
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object cbTranslateText: TCheckBox
    Left = 0
    Top = 286
    Width = 150
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = '&Translate Text'
    TabOrder = 1
    OnClick = cbTranslateTextClick
  end
  object cbWrapText: TCheckBox
    Left = 157
    Top = 286
    Width = 150
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = '&Wrap Text'
    TabOrder = 2
    OnClick = cbWrapTextClick
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 232
    Top = 152
    object FontEdit1: TFontEdit
      Category = 'Dialog'
      Caption = 'Select &Font...'
      Dialog.Font.Charset = DEFAULT_CHARSET
      Dialog.Font.Color = clWindowText
      Dialog.Font.Height = -11
      Dialog.Font.Name = 'MS Sans Serif'
      Dialog.Font.Style = []
      Dialog.MinFontSize = 0
      Dialog.MaxFontSize = 0
      Hint = 'Font Select'
      OnAccept = FontEdit1Accept
    end
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
  end
  object ImageList1: TImageList
    Left = 232
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 232
    Top = 88
    object SelectFont1: TMenuItem
      Action = FontEdit1
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Action = EditCopy1
    end
    object SelectAll1: TMenuItem
      Action = EditSelectAll1
    end
    object N2: TMenuItem
      Caption = '-'
    end
  end
end

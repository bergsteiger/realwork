inherited StringsEditDlg: TStringsEditDlg
  HelpContext = 26000
  OnCreate = FormCreate
  ActiveControl = Memo
  DesignSize = (
    429
    277)
  PixelsPerInch = 96
  TextHeight = 13
  inherited OKButton: TButton
    Left = 191
  end
  inherited CancelButton: TButton
    Left = 271
  end
  inherited HelpButton: TButton
    Left = 351
  end
  object GroupBox1: TGroupBox [4]
    Left = 6
    Top = 2
    Width = 418
    Height = 238
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    DesignSize = (
      418
      238)
    object LineCount: TLabel
      Left = 10
      Top = 12
      Width = 169
      Height = 17
      AutoSize = False
      Caption = '0 lines'
    end
    object Memo: TRichEdit
      Left = 9
      Top = 27
      Width = 399
      Height = 200
      Anchors = [akLeft, akTop, akRight, akBottom]
      HideScrollBars = False
      PlainText = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      OnChange = UpdateStatus
      OnKeyDown = Memo1KeyDown
    end
  end
end

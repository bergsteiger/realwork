object MemoryUsageDlg: TMemoryUsageDlg
  Left = 244
  Top = 129
  Width = 506
  Height = 252
  ActiveControl = btOk
  Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1077' '#1088#1077#1089#1091#1088#1089#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -10
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spTreeAndSummary: TSplitter
    Left = 290
    Top = 0
    Height = 218
  end
  object pnSummary: TPanel
    Left = 0
    Top = 0
    Width = 290
    Height = 218
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      290
      218)
    object lbLocalMemory: TLabel
      Left = 14
      Top = 19
      Width = 283
      Height = 16
      AutoSize = False
    end
    object lbGlobalMemory: TLabel
      Left = 14
      Top = 46
      Width = 283
      Height = 16
      AutoSize = False
    end
    object lbObjectMemory: TLabel
      Left = 14
      Top = 67
      Width = 283
      Height = 17
      AutoSize = False
    end
    object lbObjectCount: TLabel
      Left = 14
      Top = 93
      Width = 283
      Height = 16
      AutoSize = False
    end
    object btOk: TBitBtn
      Left = 10
      Top = 143
      Width = 81
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = '&OK'
      TabOrder = 0
      Kind = bkOK
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object btHelp: TBitBtn
      Left = 94
      Top = 143
      Width = 82
      Height = 28
      Anchors = [akLeft, akBottom]
      Caption = '&'#1055#1086#1084#1086#1097#1100
      TabOrder = 1
      Kind = bkHelp
      Margin = 2
      Spacing = -1
      IsControl = True
    end
  end
  object pnTagTree: TPanel
    Left = 293
    Top = 0
    Width = 205
    Height = 218
    Align = alClient
    TabOrder = 1
    object spTreeAndClasses: TSplitter
      Left = 1
      Top = 128
      Width = 203
      Height = 2
      Cursor = crVSplit
      Align = alBottom
    end
    object TagTree: TvtOutliner
      Left = 1
      Top = 1
      Width = 203
      Height = 127
      AutoRowHeight = False
      IntegralHeight = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      ReadOnly = False
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -10
      Font.Name = 'Arial'
      ParentColor = False
      TabOrder = 0
      TabStop = True
    end
    object memClasses: TMemo
      Left = 1
      Top = 130
      Width = 203
      Height = 87
      Align = alBottom
      Lines.Strings = (
        'memClasses')
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end

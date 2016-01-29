object DelWithReplaceDlg: TDelWithReplaceDlg
  Left = 379
  Top = 236
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = #1055#1054#1044#1058#1042#1045#1056#1044#1048#1058#1045
  ClientHeight = 183
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 9
    Top = 17
    Width = 333
    Height = 57
    Alignment = taCenter
    AutoSize = False
  end
  object Label2: TLabel
    Left = 31
    Top = 100
    Width = 156
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1069#1083#1077#1084#1077#1085#1090' - '#1087#1088#1080#1077#1084#1085#1080#1082' (ID)'
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 142
    Width = 350
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 92
      Top = 1
      Width = 257
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OKBtn: TBitBtn
        Left = 6
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object CancelBtn: TBitBtn
        Left = 90
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 1
        Kind = bkCancel
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object HelpBtn: TBitBtn
        Left = 174
        Top = 6
        Width = 77
        Height = 27
        Caption = 'Help'
        TabOrder = 2
        Kind = bkHelp
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
  object edtReplID: TvtSpinEdit
    Left = 194
    Top = 97
    Width = 113
    Height = 24
    UseMaxValue = False
    EmptyValue = -1
    Value = -1
    TabOrder = 1
  end
end

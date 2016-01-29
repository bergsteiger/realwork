inherited SrchByActionDlg: TSrchByActionDlg
  Left = 324
  Top = 287
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  ClientHeight = 131
  ClientWidth = 330
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 86
    Width = 330
    inherited OK: TBitBtn
      Left = 56
    end
    inherited Cancel: TBitBtn
      Left = 147
    end
    inherited Help: TBitBtn
      Left = 237
    end
  end
  inherited Panel1: TPanel
    Width = 330
    Height = 86
    object GroupBox1: TGroupBox
      Left = 9
      Top = 8
      Width = 311
      Height = 68
      Caption = ' &'#1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1072#1090' '
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 31
        Width = 23
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'
      end
      object Label4: TLabel
        Left = 161
        Top = 31
        Width = 29
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1055#1054
        Color = clBtnFace
        ParentColor = False
      end
      object edtLowDate: TvtDateEdit
        Left = 47
        Top = 25
        Width = 100
        Height = 24
        Style = csDropDown
        TabOrder = 0
      end
      object edtHighDate: TvtDateEdit
        Left = 199
        Top = 26
        Width = 100
        Height = 24
        Style = csDropDown
        TabOrder = 1
      end
    end
  end
end

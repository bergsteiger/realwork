inherited NewClassNameEditDlg: TNewClassNameEditDlg
  ClientHeight = 346
  Constraints.MinHeight = 373
  PixelsPerInch = 96
  TextHeight = 17
  inherited ButtonPanel: TPanel
    Top = 301
    inherited OK: TBitBtn
      Left = 109
    end
    inherited Cancel: TBitBtn
      Left = 200
    end
    inherited Help: TBitBtn
      Left = 290
    end
  end
  inherited Panel1: TPanel
    Height = 301
    inherited pnlName: TPanel
      Height = 106
      DesignSize = (
        380
        106)
      inherited lblNameRus: TLabel
        Width = 168
      end
      inherited sbSpellChecker: TSpeedButton
        Left = 378
      end
      inherited lblNameEng: TLabel
        Width = 200
      end
      inherited mNameRus: TevMemo
        Width = 361
        TextSource.OnBruttoCharCountChange = mEditorTextSourceBruttoCharCountChangeRus
      end
      inherited mNameEng: TevMemo
        TextSource.OnBruttoCharCountChange = mEditorTextSourceBruttoCharCountChangeEng
      end
    end
    object AddedDataPanel: TPanel
      Left = 1
      Top = 144
      Width = 380
      Height = 119
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        380
        119)
      object Label2: TLabel
        Left = 9
        Top = 9
        Width = 92
        Height = 17
        Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      end
      object mComment: TevMemo
        Left = 9
        Top = 32
        Width = 361
        Height = 76
        Anchors = [akLeft, akTop, akRight, akBottom]
        RMargin = 8
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        TabStop = True
        BorderStyle = bsSingle
      end
    end
    object pnlRelinkID: TPanel
      Left = 1
      Top = 263
      Width = 380
      Height = 37
      Align = alBottom
      TabOrder = 2
      object Label1: TLabel
        Left = 10
        Top = 10
        Width = 156
        Height = 17
        AutoSize = False
        Caption = #1069#1083#1077#1084#1077#1085#1090'-'#1087#1088#1080#1077#1084#1085#1080#1082
      end
      object edtRelinkDictID: TvtSpinEdit
        Left = 181
        Top = 5
        Width = 128
        Height = 24
        UseMaxValue = False
        TabOrder = 0
      end
    end
    object pnlJuristicChanges: TPanel
      Left = 1
      Top = 107
      Width = 380
      Height = 37
      Align = alBottom
      TabOrder = 3
      object cbxJuristicChanges: TCheckBox
        Left = 13
        Top = 11
        Width = 275
        Height = 18
        Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080' '#1079#1085#1072#1095#1080#1084#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        TabOrder = 0
      end
    end
  end
end

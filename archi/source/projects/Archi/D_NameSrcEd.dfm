inherited NameEditSrcDlg: TNameEditSrcDlg
  Left = 465
  Top = 198
  ClientHeight = 341
  ClientWidth = 447
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  inherited ButtonPanel: TPanel
    Top = 296
    Width = 447
    TabOrder = 2
    inherited OK: TBitBtn
      Left = 173
    end
    inherited Cancel: TBitBtn
      Left = 264
    end
    inherited Help: TBitBtn
      Left = 354
    end
  end
  inherited Panel1: TPanel
    Width = 447
    Height = 127
    inherited pnlName: TPanel
      Width = 445
      Height = 125
      BevelOuter = bvNone
      inherited lblNameRus: TLabel
        Width = 390
      end
      inherited sbSpellChecker: TSpeedButton
        Left = 411
        ParentShowHint = False
        ShowHint = True
      end
      inherited lblNameEng: TLabel
        Left = 10
        Width = 427
      end
      inherited mNameRus: TevMemo
        Width = 428
        Font.Charset = DEFAULT_CHARSET
      end
      inherited mNameEng: TevMemo
        Width = 428
      end
    end
  end
  object AddedDataPanel: TPanel
    Left = 0
    Top = 127
    Width = 447
    Height = 169
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      447
      169)
    object Label2: TLabel
      Left = 10
      Top = 58
      Width = 428
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1057#1080#1085#1086#1085#1080#1084#1099' ('#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' - '#1090#1086#1095#1082#1072'-'#1089'-'#1079#1072#1087#1103#1090#1086#1081')'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 395
      Height = 16
      AutoSize = False
      Caption = #1050#1086#1088#1086#1090#1082#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
    end
    object edSynon: TevMemo
      Left = 9
      Top = 80
      Width = 430
      Height = 79
      Anchors = [akLeft, akTop, akRight, akBottom]
      RMargin = 8
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      TabStop = True
      BorderStyle = bsSingle
    end
    object edShortName: TEdit
      Left = 9
      Top = 29
      Width = 430
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 70
      TabOrder = 0
    end
  end
end

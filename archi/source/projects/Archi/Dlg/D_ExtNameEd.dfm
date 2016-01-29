inherited ExtNameEditDlg: TExtNameEditDlg
  ClientHeight = 480
  ClientWidth = 561
  Constraints.MinHeight = 290
  PixelsPerInch = 96
  TextHeight = 17
  inherited ButtonPanel: TPanel
    Top = 435
    Width = 561
    inherited OK: TBitBtn
      Left = 278
    end
    inherited Cancel: TBitBtn
      Left = 375
    end
    inherited Help: TBitBtn
      Left = 470
    end
  end
  inherited Panel1: TPanel
    Width = 561
    Height = 435
    inherited pnlName: TPanel
      Width = 559
      Height = 231
      inherited lblNameRus: TLabel
        Top = 10
        Width = 214
      end
      inherited sbSpellChecker: TSpeedButton
        Left = 532
        Top = 5
      end
      inherited lblNameEng: TLabel
        Width = 192
      end
      inherited mNameRus: TevMemo
        Left = 8
        Top = 34
        Width = 543
      end
      inherited mNameEng: TevMemo
        Left = 8
        Width = 543
      end
    end
    object AddedDataPanel: TPanel
      Left = 1
      Top = 232
      Width = 559
      Height = 202
      Align = alBottom
      TabOrder = 1
      Visible = False
      object pnlExtCode: TPanel
        Left = 1
        Top = 1
        Width = 557
        Height = 64
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          557
          64)
        object Label2: TLabel
          Left = 9
          Top = 7
          Width = 26
          Height = 17
          Caption = #1050#1086#1076
        end
        object edtCode: TEdit
          Left = 6
          Top = 29
          Width = 544
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
      end
      object pnlExtPrivate: TPanel
        Left = 1
        Top = 65
        Width = 557
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object cbxPrivate: TCheckBox
          Left = 9
          Top = 4
          Width = 401
          Height = 18
          Caption = #1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1074#1085#1091#1090#1088#1077#1085#1085#1077#1075#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103
          TabOrder = 0
        end
        object cbxIsNonPeriodic: TCheckBox
          Left = 10
          Top = 30
          Width = 401
          Height = 18
          Caption = #1053#1077#1087#1077#1088#1080#1086#1076#1080#1095#1077#1089#1082#1086#1077' '#1080#1079#1076#1072#1085#1080#1077
          TabOrder = 1
        end
      end
      object pnlID: TPanel
        Left = 1
        Top = 120
        Width = 557
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 18
          Height = 17
          Caption = 'ID:'
        end
        object Label3: TLabel
          Left = 184
          Top = 16
          Width = 327
          Height = 14
          Caption = #1045#1089#1083#1080' '#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1086#1083#1077' '#1087#1091#1089#1090#1099#1084', ID '#1073#1091#1076#1077#1090' '#1085#1072#1079#1085#1072#1095#1077#1085' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object edID: TEdit
          Left = 32
          Top = 12
          Width = 145
          Height = 25
          TabOrder = 0
        end
      end
    end
  end
end

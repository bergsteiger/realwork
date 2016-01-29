inherited NameEditDlg: TNameEditDlg
  Left = 512
  Top = 165
  VertScrollBar.Range = 0
  ActiveControl = mNameRus
  AutoScroll = False
  ClientHeight = 286
  ClientWidth = 382
  Constraints.MinHeight = 225
  Constraints.MinWidth = 300
  Font.Color = clBlack
  Font.Height = -15
  Font.Name = 'Arial'
  KeyPreview = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  inherited ButtonPanel: TPanel
    Top = 241
    Width = 382
    DesignSize = (
      382
      45)
    inherited OK: TBitBtn
      Left = 108
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 199
    end
    inherited Help: TBitBtn
      Left = 289
    end
  end
  inherited Panel1: TPanel
    Width = 382
    Height = 241
    object pnlName: TPanel
      Left = 1
      Top = 1
      Width = 380
      Height = 239
      Align = alClient
      TabOrder = 0
      OnResize = pnlNameResize
      DesignSize = (
        380
        239)
      object lblNameRus: TLabel
        Left = 10
        Top = 12
        Width = 329
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1088#1091#1089#1089#1082#1086#1084
      end
      object sbSpellChecker: TSpeedButton
        Left = 346
        Top = 6
        Width = 25
        Height = 25
        Hint = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1088#1092#1086#1075#1088#1072#1092#1080#1080'|'
        Anchors = [akTop, akRight]
        Enabled = False
        Glyph.Data = {
          F2010000424DF201000000000000760000002800000026000000130000000100
          0400000000007C01000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777777777777777777777777007777777777777777777777FFFFFFFFFFFF77
          7700770000000000007777777888888888888F777700770FFFFFFFFFF0777777
          78F7777777778F777700770FFFFF9FFFF077777778FFF778FFF78F777700770F
          00F99F00F077777778F88788F8878F777700770FFFF999FFF077777778F77788
          8F778F777700770F0F99F99FF077777778F8788F88F78F777700770FFF99FF99
          F077777778F7788FF88F8F777700770F0F9F00F99F77777778F878F88788F777
          7700770FFFFFFFFF9977777778FFFFFFFF788F777700770F0000000FF9977777
          78F88888887788F77700770FFFFFFFFFFF97777778F7F7F77FFFF8F77700770F
          0000FF000077777778F8888778888F777700770FFFFFFF070777777778F77777
          78F8F7777700770FFFFFFF007777777778FFFFFFF88F77777700770000000007
          777777777888888888F777777700777777777777777777777777777777777777
          77007777777777777777777777777777777777777700}
        Margin = 3
        NumGlyphs = 2
        OnClick = sbSpellCheckerClick
      end
      object lblNameEng: TLabel
        Left = 9
        Top = 122
        Width = 361
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1072#1085#1075#1083#1080#1081#1089#1082#1086#1084
      end
      object mNameRus: TevMemo
        Left = 9
        Top = 35
        Width = 363
        Height = 82
        TextSource.OnBruttoCharCountChange = mNameTextSourceBruttoCharCountChange
        Anchors = [akLeft, akTop, akRight]
        RMargin = 8
        Font.Color = clBlack
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        TabStop = True
        BorderStyle = bsSingle
      end
      object mNameEng: TevMemo
        Left = 9
        Top = 144
        Width = 363
        Height = 82
        TextSource.OnBruttoCharCountChange = mNameTextSourceBruttoCharCountChange
        Anchors = [akLeft, akTop, akRight]
        RMargin = 8
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        TabStop = True
        BorderStyle = bsSingle
      end
    end
  end
end

inherited InsTextEditDlg: TInsTextEditDlg
  Left = 325
  Top = 244
  BorderStyle = bsSizeable
  Caption = 'InsTextEditDlg'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 457
      Height = 35
      Align = alTop
      TabOrder = 0
      DesignSize = (
        457
        35)
      object sbSpellChecker: TSpeedButton
        Left = 426
        Top = 4
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
      end
      object lblNameRus: TLabel
        Left = 10
        Top = 9
        Width = 93
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = #1058#1077#1082#1089#1090
      end
    end
    inline TextEditorFrm: TTextEditorWin
      Left = 1
      Top = 36
      Width = 457
      Height = 192
      Align = alClient
      TabOrder = 1
      inherited HRuler: TevRuler
        Width = 457
        Visible = False
      end
      inherited VRuler: TevRuler
        Height = 142
      end
      inherited SubShowPanel: TevSubPanel
        Height = 142
        Font.Height = -13
        Visible = False
      end
      inherited DocEditor: TevEditor
        Width = 422
        Height = 142
        TextSource = TextSource
        BorderStyle = bsSingle
      end
      inherited FooterPanel: TvtStatusBar
        Top = 172
        Width = 457
      end
      inherited pmRuller: TPopupMenu
        Left = 406
        Top = 52
      end
    end
  end
  object TextSource: TevTextSource
    Left = 57
    Top = 64
  end
end

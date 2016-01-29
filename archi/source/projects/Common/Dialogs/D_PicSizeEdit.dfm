inherited PicSizeEditDlg: TPicSizeEditDlg
  Left = 544
  Top = 293
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1088#1072#1079#1084#1077#1088#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
  ClientHeight = 262
  ClientWidth = 287
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 217
    Width = 287
    inherited OK: TBitBtn
      Left = 13
    end
    inherited Cancel: TBitBtn
      Left = 104
    end
    inherited Help: TBitBtn
      Left = 194
    end
  end
  inherited Panel1: TPanel
    Width = 287
    Height = 217
    object Label1: TLabel
      Left = 32
      Top = 32
      Width = 66
      Height = 16
      Alignment = taRightJustify
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object Label2: TLabel
      Left = 32
      Top = 74
      Width = 66
      Height = 16
      Alignment = taRightJustify
      Caption = #1042#1099#1089#1086#1090#1072
    end
    object Label3: TLabel
      Left = 227
      Top = 32
      Width = 19
      Height = 16
      Caption = #1089#1084'.'
    end
    object Label4: TLabel
      Left = 227
      Top = 74
      Width = 19
      Height = 16
      Caption = #1089#1084'.'
    end
    object Label5: TLabel
      Left = 40
      Top = 144
      Width = 228
      Height = 16
      Cursor = crHandPoint
      Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1087#1086' '#1096#1080#1088#1080#1085#1077' '#1089#1090#1088#1072#1085#1080#1094#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label5Click
    end
    object lbDPI: TLabel
      Left = 0
      Top = 179
      Width = 100
      Height = 16
      Alignment = taRightJustify
      Caption = #1056#1072#1079#1088#1077#1096#1077#1085#1080#1077
    end
    object edWidth: TvtSpinEdit
      Left = 104
      Top = 30
      Width = 121
      Height = 24
      ValueType = vtFloat
      MaxValue = 2147483647.000000000000000000
      MinValue = -2147483648.000000000000000000
      TabOrder = 0
      OnChange = edWidthChange
    end
    object edHeight: TvtSpinEdit
      Left = 104
      Top = 72
      Width = 121
      Height = 24
      ValueType = vtFloat
      MaxValue = 2147483647.000000000000000000
      MinValue = -2147483648.000000000000000000
      TabOrder = 1
      OnChange = edHeightChange
    end
    object cbProportional: TCheckBox
      Left = 64
      Top = 120
      Width = 177
      Height = 17
      Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1087#1088#1086#1087#1086#1088#1094#1080#1080
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbProportionalClick
    end
    object pnlChained: TPanel
      Left = 251
      Top = 39
      Width = 33
      Height = 57
      BevelOuter = bvNone
      TabOrder = 3
      object Shape1: TShape
        Left = 12
        Top = 0
        Width = 3
        Height = 45
        Brush.Color = clGray
        Pen.Style = psClear
      end
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 15
        Height = 3
        Brush.Color = clGray
        Pen.Style = psClear
      end
      object Shape3: TShape
        Left = 0
        Top = 43
        Width = 15
        Height = 3
        Brush.Color = clGray
        Pen.Style = psClear
      end
    end
    object edDPI: TvtSpinEdit
      Left = 104
      Top = 176
      Width = 121
      Height = 24
      MaxValue = 2147483647.000000000000000000
      TabOrder = 4
    end
  end
end

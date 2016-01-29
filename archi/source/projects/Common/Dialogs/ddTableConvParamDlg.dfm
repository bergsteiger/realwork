inherited TableConvParamDialog: TTableConvParamDialog
  Left = 285
  Top = 177
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1090#1072#1073#1083#1080#1094#1099
  ClientHeight = 311
  ClientWidth = 663
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited FormPanel: TPanel
    Width = 663
    Height = 311
    inherited pnButtons: TPanel
      Top = 268
      Width = 661
      DesignSize = (
        661
        42)
      inherited btOk: TBitBtn
        Left = 106
        Width = 89
      end
      inherited btCancel: TBitBtn
        Left = 209
        Width = 89
        Caption = #1054#1090#1084#1077#1085#1072
      end
      object Button3: TButton
        Left = 4
        Top = 8
        Width = 89
        Height = 27
        Anchors = [akLeft, akBottom]
        Caption = #1055#1088#1086#1089#1084#1086#1090#1088
        TabOrder = 2
        OnClick = Button3Click
      end
    end
    inherited pnMain: TPanel
      Width = 661
      Height = 267
      object Label1: TLabel
        Left = 4
        Top = 4
        Width = 97
        Height = 16
        Caption = #1056#1072#1079#1084#1077#1088' '#1090#1072#1073#1083#1080#1094#1099
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 95
        Height = 16
        Caption = #1063#1080#1089#1083#1086' '#1089#1090#1086#1083#1073#1094#1086#1074
      end
      object Label3: TLabel
        Left = 16
        Top = 48
        Width = 73
        Height = 16
        Caption = #1063#1080#1089#1083#1086' '#1089#1090#1088#1086#1082
      end
      object Label4: TLabel
        Left = 4
        Top = 72
        Width = 181
        Height = 16
        Caption = #1040#1074#1090#1086#1087#1086#1076#1073#1086#1088' '#1096#1080#1088#1080#1085#1099' '#1089#1090#1086#1083#1073#1094#1086#1074
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 4
        Top = 132
        Width = 77
        Height = 16
        Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 311
        Top = 4
        Width = 168
        Height = 16
        Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
      end
      object Label7: TLabel
        Left = 8
        Top = 208
        Width = 43
        Height = 16
        Caption = #1040#1085#1072#1083#1080#1079
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 534
        Top = 4
        Width = 55
        Height = 16
        Caption = #1052#1072#1089#1096#1090#1072#1073
      end
      object spinCellCount: TvtSpinEdit
        Left = 176
        Top = 19
        Width = 69
        Height = 24
        MaxValue = 255.000000000000000000
        MinValue = 1.000000000000000000
        Value = 2.000000000000000000
        TabOrder = 0
        OnBottomClick = spinCellCountChange
        OnTopClick = spinCellCountChange
        OnChange = spinCellCountChange
      end
      object spinRowCount: TvtSpinEdit
        Left = 176
        Top = 44
        Width = 69
        Height = 24
        EditorEnabled = False
        MaxValue = 32767.000000000000000000
        MinValue = 1.000000000000000000
        Value = 2.000000000000000000
        Enabled = False
        TabOrder = 1
      end
      object rbGraphic: TRadioButton
        Left = 8
        Top = 148
        Width = 145
        Height = 17
        Caption = #1087#1089#1077#1074#1076#1086#1075#1088#1072#1092#1080#1082#1072
        TabOrder = 2
        OnClick = rbGraphicClick
      end
      object rbParagraph: TRadioButton
        Tag = 1
        Left = 143
        Top = 168
        Width = 113
        Height = 17
        Caption = '&'#1079#1085#1072#1082' '#1072#1073#1079#1072#1094#1072
        TabOrder = 3
        OnClick = rbGraphicClick
      end
      object rbTab: TRadioButton
        Tag = 2
        Left = 8
        Top = 188
        Width = 137
        Height = 17
        Caption = #1079#1085#1072#1082' '#1090#1072'&'#1073#1091#1083#1103#1094#1080#1080
        TabOrder = 4
        OnClick = rbGraphicClick
      end
      object rbSemicolon: TRadioButton
        Tag = 3
        Left = 143
        Top = 148
        Width = 133
        Height = 17
        Caption = #1090#1086#1095'&'#1082#1072' '#1089' '#1079#1072#1087#1103#1090#1086#1081
        TabOrder = 5
        OnClick = rbGraphicClick
      end
      object rbSpace: TRadioButton
        Tag = 4
        Left = 8
        Top = 168
        Width = 101
        Height = 17
        Caption = #1087#1088#1086#1073#1077#1083
        TabOrder = 6
        OnClick = rbGraphicClick
      end
      object rbOther: TRadioButton
        Tag = 5
        Left = 143
        Top = 188
        Width = 81
        Height = 17
        Caption = #1076#1088#1091'&'#1075#1086#1081
        TabOrder = 7
        OnClick = rbGraphicClick
      end
      object edOther: TEdit
        Left = 217
        Top = 188
        Width = 25
        Height = 24
        TabOrder = 8
        Text = ' '
        OnChange = rbGraphicClick
      end
      object Panel1: TPanel
        Left = 4
        Top = 88
        Width = 237
        Height = 41
        BevelOuter = bvNone
        TabOrder = 9
        object rbFitWidth: TRadioButton
          Left = 8
          Top = 0
          Width = 213
          Height = 17
          Caption = #1087#1086#1089#1090#1086#1103#1085#1085#1072#1103
          TabOrder = 0
          OnClick = AutoFitChanged
        end
        object rbFitContent: TRadioButton
          Tag = 1
          Left = 8
          Top = 16
          Width = 201
          Height = 17
          Caption = #1087#1086' '#1089#1086#1076#1077#1088'&'#1078#1080#1084#1086#1084#1091
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = AutoFitChanged
        end
      end
      object cbGlueLines: TCheckBox
        Left = 12
        Top = 224
        Width = 157
        Height = 17
        Caption = #1057#1086#1077#1076#1080#1085#1103#1090#1100' '#1089#1090#1088#1086#1082#1080
        Checked = True
        State = cbChecked
        TabOrder = 10
        OnClick = cbGlueLinesClick
      end
      object cbIgnoreDoubles: TCheckBox
        Left = 12
        Top = 240
        Width = 285
        Height = 17
        Caption = #1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1076#1074#1086#1081#1085#1099#1077
        Checked = True
        State = cbChecked
        TabOrder = 11
      end
      object PreviewMemo: TevMemo
        Left = 310
        Top = 28
        Width = 342
        Height = 229
        LMargin = 10
        ScrollStyle = ssBoth
        Font.Charset = DEFAULT_CHARSET
        TabOrder = 13
        TabStop = True
      end
      object spinWidth: TvtSpinEdit
        Left = 176
        Top = 89
        Width = 69
        Height = 24
        Increment = 0.100000000000000000
        ValueType = vtFloat
        MaxValue = 100.000000000000000000
        TabOrder = 12
        Visible = False
      end
      object spinZoom: TvtSpinEdit
        Left = 601
        Top = 3
        Width = 49
        Height = 24
        MaxValue = 200.000000000000000000
        MinValue = 10.000000000000000000
        Value = 75.000000000000000000
        TabOrder = 14
        OnBottomClick = spinZoomBottomClick
        OnTopClick = spinZoomBottomClick
        OnChange = spinZoomBottomClick
      end
    end
  end
end

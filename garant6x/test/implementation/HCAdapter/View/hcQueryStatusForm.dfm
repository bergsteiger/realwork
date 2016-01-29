object frmQueryStatus: TfrmQueryStatus
  Left = 318
  Top = 70
  Width = 870
  Height = 640
  Caption = #1047#1072#1087#1088#1086#1089' '#1082' '#1089#1077#1088#1074#1077#1088#1091' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 169
    Width = 854
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object sBottom: TSplitter
    Left = 0
    Top = 333
    Width = 854
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object pnlQueryBrowser: TPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 169
    Align = alTop
    TabOrder = 0
    object vtLabel1: TvtLabel
      Left = 1
      Top = 1
      Width = 852
      Height = 13
      Align = alTop
      Caption = 'XML '#1079#1072#1087#1088#1086#1089' '#1082' '#1089#1077#1088#1074#1077#1088#1091' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081':'
      DrawDirection = ddHorizontal
    end
  end
  object pnlStatusBrowser: TPanel
    Left = 0
    Top = 172
    Width = 854
    Height = 161
    Align = alClient
    TabOrder = 1
    object vtLabel2: TvtLabel
      Left = 1
      Top = 1
      Width = 852
      Height = 13
      Align = alTop
      Caption = #1054#1090#1074#1077#1090' '#1089#1077#1088#1074#1077#1088#1072' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081':'
      DrawDirection = ddHorizontal
    end
  end
  object pnlQueryEditor: TPanel
    Left = 0
    Top = 336
    Width = 854
    Height = 227
    Align = alBottom
    TabOrder = 2
    Visible = False
    object vtQuery: TvtLabel
      Left = 1
      Top = 1
      Width = 852
      Height = 13
      Align = alTop
      Caption = #1042#1074#1077#1076#1080#1090#1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086' '#1079#1072#1087#1088#1086#1089#1072#1093':'
      DrawDirection = ddHorizontal
    end
    object pnlQueryEditorButtons: TPanel
      Left = 1
      Top = 185
      Width = 852
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        852
        41)
      object btnDoQuery: TButton
        Left = 708
        Top = 7
        Width = 137
        Height = 29
        Anchors = [akTop, akRight]
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
        TabOrder = 0
        OnClick = btnDoQueryClick
      end
    end
    object sgQueryInfo: TStringGrid
      Left = 1
      Top = 14
      Width = 852
      Height = 171
      Align = alClient
      ColCount = 2
      FixedCols = 0
      RowCount = 10
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
      ColWidths = (
        267
        340)
    end
  end
  object pnlShowQueryEditor: TPanel
    Left = 0
    Top = 563
    Width = 854
    Height = 41
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      854
      41)
    object btnQueryEditor: TButton
      Left = 708
      Top = 7
      Width = 137
      Height = 29
      Anchors = [akTop, akRight]
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1079#1072#1087#1088#1086#1089#1086#1074' >>'
      TabOrder = 0
      OnClick = btnQueryEditorClick
    end
  end
end

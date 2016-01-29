object CompareViewForm: TCompareViewForm
  Left = 243
  Top = 124
  Width = 978
  Height = 713
  Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1090#1077#1082#1089#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object panelEtalon: TPanel
    Left = 0
    Top = 0
    Width = 489
    Height = 675
    Align = alLeft
    Caption = 'panelEtalon'
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 487
      Height = 40
      Align = alTop
      Caption = #1069#1090#1072#1083#1086#1085#1085#1099#1081' '#1090#1077#1082#1089#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btnSourceEtalon: TButton
        Left = 8
        Top = 8
        Width = 140
        Height = 25
        Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1090#1077#1082#1089#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSourceEtalonClick
      end
    end
    object edEtalon: TevEditor
      Left = 1
      Top = 41
      Width = 487
      Height = 633
      Align = alClient
      WebStyle = True
      TextSource = textEtalon
      TabOrder = 1
      TabStop = True
    end
  end
  object PanelResult: TPanel
    Left = 489
    Top = 0
    Width = 473
    Height = 675
    Align = alClient
    Caption = 'PanelResult'
    TabOrder = 1
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 471
      Height = 40
      Align = alTop
      Caption = #1058#1077#1082#1089#1090' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        471
        40)
      object btnSaveAsEtalon: TButton
        Left = 328
        Top = 8
        Width = 140
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082' '#1101#1090#1072#1083#1086#1085
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSaveAsEtalonClick
      end
    end
    object edOut: TevEditor
      Left = 1
      Top = 41
      Width = 471
      Height = 633
      Align = alClient
      WebStyle = True
      TextSource = textOut
      TabOrder = 1
      TabStop = True
    end
  end
  object textOut: TevTextSource
    Left = 160
    Top = 88
  end
  object textEtalon: TevTextSource
    Left = 560
    Top = 96
  end
end

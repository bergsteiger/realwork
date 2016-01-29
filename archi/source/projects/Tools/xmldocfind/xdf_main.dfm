object MainForm: TMainForm
  Left = 444
  Top = 401
  Width = 474
  Height = 117
  Caption = #1040#1088#1093#1080#1074#1072#1088#1080#1091#1089': '#1087#1086#1080#1089#1082' '#1090#1086#1087#1080#1082#1086#1074' '#1074' XML'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    458
    81)
  PixelsPerInch = 96
  TextHeight = 13
  object feXMLFile: TFilenameEdit
    Left = 8
    Top = 16
    Width = 442
    Height = 21
    Filter = 'XML Files(*.xml)|*.xml'
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 0
  end
  object btnDo: TButton
    Left = 313
    Top = 48
    Width = 139
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = btnDoClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 51
    Width = 298
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Visible = False
  end
end

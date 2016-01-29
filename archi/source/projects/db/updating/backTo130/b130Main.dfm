object Form1: TForm1
  Left = 417
  Top = 322
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1090#1082#1072#1090' '#1085#1072' 130 '#1074#1077#1088#1089#1080#1102' '#1073#1072#1079#1099
  ClientHeight = 245
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 100
    Height = 13
    Caption = #1055#1091#1090#1100' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093
  end
  object Bevel1: TBevel
    Left = 8
    Top = 56
    Width = 409
    Height = 129
  end
  object deBasePath: TDirectoryEdit
    Left = 8
    Top = 24
    Width = 409
    Height = 21
    OnAfterDialog = deBasePathAfterDialog
    DialogKind = dkWin32
    DirectInput = False
    NumGlyphs = 1
    TabOrder = 0
  end
  object btnExecute: TButton
    Left = 88
    Top = 200
    Width = 249
    Height = 33
    Caption = #1054#1090#1082#1072#1090#1080#1090#1100
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnExecuteClick
  end
  object stDisp: TStaticText
    Left = 16
    Top = 64
    Width = 393
    Height = 113
    AutoSize = False
    TabOrder = 2
  end
end

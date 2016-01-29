inherited DocByStageInfoDlg: TDocByStageInfoDlg
  Left = 406
  Top = 219
  VertScrollBar.Range = 0
  ActiveControl = InfoLister
  AutoScroll = False
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1087#1086' '#1089#1090#1072#1076#1080#1103#1084
  ClientHeight = 303
  ClientWidth = 413
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 258
    Width = 413
    inherited OK: TBitBtn
      Left = 129
      Width = 99
      Caption = #1055#1086#1076#1088#1086#1073#1085#1086
      Enabled = False
    end
    inherited Cancel: TBitBtn
      Left = 231
    end
    inherited Help: TBitBtn
      Left = 319
    end
  end
  inherited Panel1: TPanel
    Width = 413
    Height = 258
    object InfoLister: TvtDStringLister
      Left = 1
      Top = 1
      Width = 411
      Height = 256
      Sorted = False
      AutoRowHeight = False
      Header.Left = 0
      Header.Top = 0
      Header.Width = 407
      Header.Height = 0
      Header.Sections = <
        item
          Width = 300
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end
        item
          Width = 75
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end>
      Header.Font.Name = 'Arial CYR'
      IntegralHeight = False
      MultiSelect = True
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 20
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clInactiveCaption
      SelectNonFocusColor.TextColor = clHighlightText
      ShowHeader = True
      UseTabStops = True
      PickedList = True
      OnSelectChanged = InfoListerSelectChanged
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -16
      ParentColor = False
      TabOrder = 0
      TabStop = True
    end
  end
end

object SearchResultDlg: TSearchResultDlg
  Left = 392
  Top = 224
  ActiveControl = edtSrchWinName
  AutoScroll = False
  Caption = #1056#1045#1047#1059#1051#1068#1058#1040#1058#1067' '#1055#1054#1048#1057#1050#1040
  ClientHeight = 229
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 421
    Height = 229
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 4
    TabOrder = 0
    object Panel2: TPanel
      Left = 6
      Top = 6
      Width = 409
      Height = 82
      Align = alTop
      Alignment = taLeftJustify
      TabOrder = 0
      object ResultLabel: TLabel
        Left = 3
        Top = 8
        Width = 357
        Height = 50
        AutoSize = False
        Caption = '   '#1053#1072#1081#1076#1077#1085#1086' %d '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'.'#13#10#13#10'   '#1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1074' '#1074#1099#1073#1086#1088#1082#1091' :'
      end
      object edtSrchWinName: TEdit
        Left = 0
        Top = 58
        Width = 409
        Height = 24
        TabOrder = 0
      end
    end
    object SrchWinList: TvtDStringLister
      Left = 6
      Top = 88
      Width = 409
      Height = 135
      Sorted = False
      AutoRowHeight = False
      IntegralHeight = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clInactiveCaption
      SelectNonFocusColor.TextColor = clHighlightText
      OnCurrentChanged = SrchWinListCurrentChanged
      Align = alClient
      ParentColor = False
      TabOrder = 1
      TabStop = True
    end
  end
  object Panel3: TPanel
    Left = 421
    Top = 0
    Width = 100
    Height = 229
    Align = alRight
    TabOrder = 1
    object Help: TBitBtn
      Left = 5
      Top = 72
      Width = 89
      Height = 27
      Caption = 'Help'
      TabOrder = 0
      Kind = bkHelp
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object OKBtn: TBitBtn
      Left = 5
      Top = 5
      Width = 89
      Height = 27
      TabOrder = 1
      Kind = bkOK
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object Cancel: TBitBtn
      Left = 5
      Top = 38
      Width = 89
      Height = 27
      TabOrder = 2
      Kind = bkCancel
      Margin = 2
      Spacing = -1
      IsControl = True
    end
  end
end

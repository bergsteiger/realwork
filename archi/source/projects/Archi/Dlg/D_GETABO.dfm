inherited GetAbolishDataDlg: TGetAbolishDataDlg
  Left = 1362
  Top = 198
  VertScrollBar.Range = 0
  ActiveControl = edtExpDate
  AutoScroll = False
  Caption = #1057#1085#1103#1090#1100' '#1089' '#1082#1086#1085#1090#1088#1086#1083#1103
  ClientHeight = 411
  ClientWidth = 532
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 366
    Width = 532
    inherited OK: TBitBtn
      Left = 256
    end
    inherited Cancel: TBitBtn
      Left = 347
    end
    inherited Help: TBitBtn
      Left = 437
    end
  end
  inherited Panel1: TPanel
    Width = 532
    Height = 366
    object Label1: TLabel
      Left = 12
      Top = 48
      Width = 126
      Height = 16
      AutoSize = False
      Caption = #1042' '#1079#1072#1075#1086#1083#1086#1074#1086#1082
    end
    object Label2: TLabel
      Left = 7
      Top = 233
      Width = 54
      Height = 16
      Caption = ' '#1042' '#1090#1077#1082#1089#1090' '
    end
    object Label3: TLabel
      Left = 12
      Top = 17
      Width = 195
      Height = 16
      Caption = #1044#1072#1090#1072'  '#1087#1088#1077#1082#1088#1072#1097#1077#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1103'  '
    end
    object lstNameStr: TvtStringLister
      Left = 9
      Top = 72
      Width = 513
      Height = 148
      Items.Strings = (
        #1091#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091
        #1091#1090#1088#1072#1090#1080#1083#1072' '#1089#1080#1083#1091
        #1091#1090#1088#1072#1090#1080#1083#1086' '#1089#1080#1083#1091
        #1091#1090#1088#1072#1090#1080#1083#1080' '#1089#1080#1083#1091
        #1087#1088#1077#1082#1088#1072#1090#1080#1083' '#1076#1077#1081#1089#1090#1074#1080#1077
        #1087#1088#1077#1082#1088#1072#1090#1080#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1077
        #1087#1088#1077#1082#1088#1072#1090#1080#1083#1086' '#1076#1077#1081#1089#1090#1074#1080#1077
        #1087#1088#1077#1082#1088#1072#1090#1080#1083#1080' '#1076#1077#1081#1089#1090#1074#1080#1077
        #1089#1085#1103#1090#1086' '#1089' '#1082#1086#1085#1090#1088#1086#1083#1103
        #1087#1086#1076#1087#1080#1089#1072#1085' '#1055#1088#1077#1079#1080#1076#1077#1085#1090#1086#1084' '#1056#1060
        #1089#1085#1103#1090' '#1089' '#1088#1072#1089#1089#1084#1086#1090#1088#1077#1085#1080#1103
        #1085#1077' '#1076#1077#1081#1089#1090#1074#1091#1077#1090
        #1086#1090#1084#1077#1085#1077#1085
        #1086#1090#1084#1077#1085#1077#1085#1086
        #1086#1090#1084#1077#1085#1077#1085#1072
        #1086#1090#1084#1077#1085#1077#1085#1099
        #1076#1077#1081#1089#1090#1074#1080#1077' '#1087#1088#1080#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086
        #1085#1077' '#1087#1088#1080#1084#1077#1085#1103#1077#1090#1089#1103
        #1085#1077' '#1074#1089#1090#1091#1087#1080#1083' '#1074' '#1089#1080#1083#1091
        #1085#1077' '#1074#1089#1090#1091#1087#1080#1083#1086' '#1074' '#1089#1080#1083#1091
        #1085#1077' '#1074#1089#1090#1091#1087#1080#1083#1072' '#1074' '#1089#1080#1083#1091
        #1085#1077' '#1074#1089#1090#1091#1087#1080#1083#1080' '#1074' '#1089#1080#1083#1091)
      Sorted = False
      AlienSource = False
      AutoRowHeight = False
      BorderStyle = bsSingle
      Columns = 255
      IntegralHeight = True
      MultiSelect = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 16
      ScrollStyle = ssVertical
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clInactiveCaption
      SelectNonFocusColor.TextColor = clHighlightText
      ShowHeader = False
      UseTabStops = False
      PickedList = True
      TriplePicked = False
      MultiStrokeItem = False
      ReadOnly = False
      ViewOptions = []
      OnCurrentChanged = lstNameStrCurrentChanged
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = True
      TabOrder = 1
      TabStop = True
    end
    object memoTextStr: TevMemo
      Left = 8
      Top = 254
      Width = 516
      Height = 102
      TextSource.OnGetWriter = memoTextStrmemoTextStr_TextSourceGetWriter
      Anchors = [akLeft, akTop, akRight, akBottom]
      RMargin = 8
      ScrollStyle = ssBoth
      ParentFont = True
      TabOrder = 2
      TabStop = True
      BorderStyle = bsSingle
    end
    object edtExpDate: TvtDateEdit
      Left = 210
      Top = 13
      Width = 121
      Height = 24
      ParentFont = True
      Style = csDropDown
      TabOrder = 0
      OnInvalidDate = edtExpDateInvalidDate
    end
  end
end

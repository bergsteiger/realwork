inherited AutoCompleteCfgDlg: TAutoCompleteCfgDlg
  Left = 274
  Top = 209
  Width = 539
  Height = 381
  BorderStyle = bsSizeable
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 304
    Width = 531
    inherited OK: TBitBtn
      Left = 257
      Anchors = [akRight, akBottom]
    end
    inherited Cancel: TBitBtn
      Left = 348
      Anchors = [akRight, akBottom]
    end
    inherited Help: TBitBtn
      Left = 438
      Anchors = [akRight, akBottom]
    end
  end
  inherited Panel1: TPanel
    Width = 531
    Height = 304
    object lstMacros: TvtLister
      Left = 8
      Top = 10
      Width = 515
      Height = 244
      AutoRowHeight = False
      Header.Left = 0
      Header.Top = 0
      Header.Width = 511
      Header.Height = 18
      Header.Sections = <
        item
          Alignment = taCenter
          Caption = #1056#1077#1075'.'#1042#1099#1088'.'
          Width = 60
          AutoResize = False
          MinWidth = 60
          MaxWidth = 60
        end
        item
          Caption = #1057#1090#1088#1086#1082#1072
          Width = 120
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end
        item
          Caption = #1047#1072#1084#1077#1085#1072
          Width = 75
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end>
      Header.Font.Charset = RUSSIAN_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -12
      Header.Font.Name = 'Arial'
      Header.Font.Style = []
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 16
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      ShowHeader = True
      UseTabStops = True
      PickedList = False
      TriplePicked = False
      MultiStrokeItem = False
      ReadOnly = False
      OnGetStrItem = lstMacrosGetStrItem
      OnCountChanged = lstMacrosCountChanged
      ParentColor = False
      TabOrder = 0
      TabStop = True
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object btnAdd: TButton
      Left = 170
      Top = 268
      Width = 115
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnDelete: TButton
      Left = 412
      Top = 268
      Width = 115
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object btnEdit: TButton
      Left = 291
      Top = 268
      Width = 115
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      TabOrder = 2
      OnClick = btnEditClick
    end
  end
end

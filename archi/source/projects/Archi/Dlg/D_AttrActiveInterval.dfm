inherited AttrActiveIntervalDlg: TAttrActiveIntervalDlg
  Left = 482
  Top = 197
  ActiveControl = edtDateLow
  BorderStyle = bsDialog
  Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1076#1077#1081#1089#1090#1074#1080#1103
  ClientHeight = 308
  ClientWidth = 441
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 263
    Width = 441
    BevelOuter = bvSpace
    inherited OK: TBitBtn
      Left = 167
    end
    inherited Cancel: TBitBtn
      Left = 258
    end
    inherited Help: TBitBtn
      Left = 348
    end
  end
  inherited Panel1: TPanel
    Width = 441
    Height = 263
    object Label3: TLabel [0]
      Left = 9
      Top = 160
      Width = 132
      Height = 16
      AutoSize = False
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object GroupBox1: TGroupBox [1]
      Left = 8
      Top = 5
      Width = 425
      Height = 142
      TabOrder = 0
      object sbDateCalc: TSpeedButton
        Left = 236
        Top = 108
        Width = 23
        Height = 22
        Hint = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1076#1072#1090'|'
        Glyph.Data = {
          36010000424D3601000000000000760000002800000012000000100000000100
          040000000000C000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
          DDDDDD000000DDDDDDDDDDDDDDDDDD000000DD00000000000000DD000000D664
          4444444444440D000000D6F66666666666640D000000D6E60F0F0F0FF8040D00
          0000D6F66666666666640D000000D6E60F0F0F0F0F040D000000D6F666666666
          66640D000000D6E08888888666640D000000D6F0FFFFFF8666640D000000D6E0
          0000000666640D000000D6FEFEFEFEFEFEF60D000000DD66666666666666DD00
          0000DDDDDDDDDDDDDDDDDD000000DDDDDDDDDDDDDDDDDD000000}
        Margin = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = sbDateCalcClick
      end
      object rbActive: TRadioButton
        Left = 8
        Top = 16
        Width = 113
        Height = 17
        Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbActiveClick
      end
      object rbPreactive: TRadioButton
        Left = 8
        Top = 36
        Width = 299
        Height = 17
        Caption = #1041#1091#1076#1077#1090' '#1076#1077#1081#1089#1090#1074#1086#1074#1072#1090#1100' ('#1076#1072#1090#1072' '#1085#1077#1080#1079#1074#1077#1089#1090#1085#1072')'
        TabOrder = 1
        OnClick = rbPreactiveClick
      end
      object rbNoActive: TRadioButton
        Left = 8
        Top = 57
        Width = 268
        Height = 17
        Caption = #1059#1078#1077' '#1085#1077' '#1076#1077#1081#1089#1090#1074#1091#1077#1090' ('#1076#1072#1090#1072' '#1085#1077#1080#1079#1074#1077#1089#1090#1085#1072')'
        TabOrder = 2
        OnClick = rbNoActiveClick
      end
      object rbNotSure: TRadioButton
        Left = 8
        Top = 78
        Width = 201
        Height = 17
        Caption = #1055#1077#1088#1080#1086#1076' '#1085#1077#1091#1074#1077#1088#1077#1085#1085#1086#1089#1090#1080
        TabOrder = 3
        OnClick = rbNotSureClick
      end
    end
    inherited edtDateLow: TvtDateEdit [2]
      Left = 128
      Top = 112
      Width = 112
      TabOrder = 1
      OnEnter = edtDateLowEnter
    end
    inherited edtDateHigh: TvtDateEdit [3]
      Left = 315
      Top = 112
      Width = 110
      TabOrder = 2
      OnEnter = edtDateHighEnter
    end
    object edtComment: TevMemo [4]
      Left = 8
      Top = 184
      Width = 421
      Height = 65
      ParentFont = True
      TabOrder = 5
      TabStop = True
      BorderStyle = bsSingle
      OnKeyDown = edtCommentKeyDown
    end
    object Button1: TButton [5]
      Left = 324
      Top = 157
      Width = 105
      Height = 25
      Caption = #1057#1083#1086#1074#1072#1088#1100
      TabOrder = 6
      TabStop = False
      OnClick = edtCommentDropDown
      OnKeyDown = edtCommentKeyDown
    end
    inherited Label2: TStaticText [6]
      Left = 291
      Top = 115
      TabOrder = 4
    end
    inherited Label1: TStaticText [7]
      Left = 103
      Top = 116
      TabOrder = 3
    end
  end
end

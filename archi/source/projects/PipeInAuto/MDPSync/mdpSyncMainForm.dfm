object MDPSyncForm: TMDPSyncForm
  Left = 686
  Top = 364
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1089' MDP. '#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089
  ClientHeight = 104
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object ImportProgress: TProgressBar
    Left = 8
    Top = 80
    Width = 201
    Height = 17
    Smooth = True
    TabOrder = 0
  end
  object SyncNowButton: TButton
    Left = 216
    Top = 40
    Width = 75
    Height = 25
    Caption = #1057#1077#1081#1095#1072#1089
    Enabled = False
    TabOrder = 1
    OnClick = SyncNowButtonClick
  end
  object StartSyncButton: TButton
    Left = 216
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    Default = True
    Enabled = False
    TabOrder = 2
    OnClick = StartSyncButtonClick
  end
  object TimerProgress: TProgressBar
    Left = 8
    Top = 26
    Width = 201
    Height = 6
    Smooth = True
    TabOrder = 3
  end
  object Button1: TButton
    Left = 216
    Top = 72
    Width = 75
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
    TabOrder = 4
    OnClick = Button1Click
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 58
    Height = 18
    Caption = 'StaticText1'
    TabOrder = 5
  end
  object TimeoutTimer: TTimer
    Enabled = False
    OnTimer = TimeTimer
    Left = 56
    Top = 48
  end
  object DoMenu: TPopupMenu
    Left = 184
    Top = 40
    object N1: TMenuItem
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089#1083#1086#1074#1072#1088#1100' '#1054#1043#1042
      OnClick = N2Click
    end
  end
end

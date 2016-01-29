object EasyUpdateAdminForm: TEasyUpdateAdminForm
  Left = 428
  Top = 242
  Width = 570
  Height = 370
  BorderIcons = [biSystemMenu]
  Caption = #1043#1040#1056#1040#1053#1058': '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1072#1088#1086#1083#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' ADMIN'
  Color = $00F9F8FA
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object f_BottomPanel: TPanel
    Left = 0
    Top = 277
    Width = 554
    Height = 57
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object f_CommonSaveBitBtn: TBitBtn
      Left = 315
      Top = 16
      Width = 107
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = CommonSaveBitBtnClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object f_CommonCancelBitBtn: TBitBtn
      Left = 428
      Top = 16
      Width = 105
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object f_MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 277
    Align = alClient
    TabOrder = 1
    object f_AdminNameLabel: TLabel
      Left = 22
      Top = 185
      Width = 190
      Height = 13
      AutoSize = False
      Caption = #1042#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
    end
    object f_AdminPasswordLabel: TLabel
      Left = 22
      Top = 222
      Width = 190
      Height = 13
      AutoSize = False
      Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
    end
    object f_AdminPasswordCheckLabel: TLabel
      Left = 22
      Top = 248
      Width = 190
      Height = 13
      AutoSize = False
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
    end
    object f_AdminNameEdit: TEdit
      Left = 220
      Top = 182
      Width = 312
      Height = 21
      MaxLength = 128
      TabOrder = 0
    end
    object f_AdminPasswordEdit: TEdit
      Left = 220
      Top = 219
      Width = 312
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object f_AdminPasswordCheckEdit: TEdit
      Left = 220
      Top = 245
      Width = 312
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object f_InformationMemo: TMemo
      Left = 22
      Top = 11
      Width = 510
      Height = 153
      Alignment = taCenter
      BevelInner = bvLowered
      BevelOuter = bvRaised
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
  end
end

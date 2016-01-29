object GetNumberDlg: TGetNumberDlg
  Left = 518
  Top = 286
  BorderStyle = bsDialog
  Caption = #1044#1054#1041#1040#1042#1048#1058#1068
  ClientHeight = 121
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 17
    Top = 27
    Width = 57
    Height = 16
    Alignment = taRightJustify
    Caption = 'ID '#1085#1086#1084#1077#1088
  end
  object OKBtn: TBitBtn
    Left = 7
    Top = 88
    Width = 77
    Height = 27
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OKBtnClick
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
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 91
    Top = 88
    Width = 77
    Height = 27
    TabOrder = 3
    OnClick = CancelBtnClick
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 175
    Top = 88
    Width = 77
    Height = 27
    TabOrder = 4
    OnClick = HelpBtnClick
    Kind = bkHelp
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object chkRenum: TCheckBox
    Left = 16
    Top = 60
    Width = 128
    Height = 17
    Caption = #1042#1085#1077#1096#1085#1080#1081' '#1085#1086#1084#1077#1088
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object edNumber: TComboBox
    Left = 94
    Top = 22
    Width = 155
    Height = 24
    ItemHeight = 16
    TabOrder = 0
    OnSelect = edNumberSelect
  end
  object ActionList1: TActionList
    Left = 222
    Top = 53
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 16422
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 16424
      OnExecute = Action2Execute
    end
  end
end

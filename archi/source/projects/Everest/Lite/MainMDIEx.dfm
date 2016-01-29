object evMainMDIFormEx: TevMainMDIFormEx
  Left = 196
  Top = 123
  Width = 696
  Height = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object OpenDialog: TOpenDialog
    Filter = 
      #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1069#1074#1077#1088#1077#1089#1090' (*.evd;*.evr)|*.evr;*.evd|'#1058#1072#1073#1083#1080#1094#1099' '#1089#1090#1080#1083#1077#1081' '#1069#1074#1077#1088#1077 +
      #1089#1090' (*.evs)|*.evs|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' c '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077#1084' (*.txt)|*.txt' +
      '|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' AS IS (*.txt)|*.txt|'#1048#1089#1093#1086#1076#1085#1080#1082#1080' '#1043#1072#1088#1072#1085#1090#1072' (*.nsr)|*' +
      '.nsr|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF (*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF ('#1073#1077#1079' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1103') ' +
      '(*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' MS Word (*.doc)|*.doc|HTML-'#1089#1090#1088#1072#1085#1080#1094#1099' (*.h' +
      'tm;*.html)|*.htm;*.html|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100
    Left = 364
    Top = 197
  end
  object SaveDialog: TSaveDialog
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Left = 454
    Top = 197
  end
  object SaveManager: TevSaveDocumentManager
    SaveDialog = SaveDialog
    Left = 496
    Top = 200
  end
  object LoadManager: TevLoadDocumentManager
    OpenDialog = OpenDialog
    Left = 510
    Top = 200
  end
end

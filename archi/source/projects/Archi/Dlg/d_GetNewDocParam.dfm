inherited NewDocParam: TNewDocParam
  Left = 424
  Top = 205
  VertScrollBar.Range = 0
  ActiveControl = edtDocID
  AutoScroll = False
  Caption = #1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
  ClientHeight = 392
  ClientWidth = 513
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 347
    Width = 513
    inherited OK: TBitBtn
      Left = 236
    end
    inherited Cancel: TBitBtn
      Left = 327
    end
    inherited Help: TBitBtn
      Left = 417
    end
  end
  inherited Panel1: TPanel
    Width = 513
    Height = 347
    object lblDocID: TLabel
      Left = 13
      Top = 51
      Width = 87
      Height = 16
      Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      FocusControl = edtDocID
    end
    object lblDocName: TLabel
      Left = 13
      Top = 82
      Width = 140
      Height = 16
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Label4: TLabel
      Left = 12
      Top = 16
      Width = 99
      Height = 16
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edtDocID: TvtSpinEdit
      Left = 118
      Top = 48
      Width = 152
      Height = 24
      MaxValue = 2000000000.000000000000000000
      TabOrder = 1
    end
    object edtDocName: TevMemo
      Left = 10
      Top = 107
      Width = 492
      Height = 116
      Anchors = [akLeft, akTop, akRight, akBottom]
      RMargin = 8
      TabOrder = 2
      TabStop = True
      BorderStyle = bsSingle
    end
    object cbDocKind: TComboBox
      Left = 120
      Top = 13
      Width = 382
      Height = 24
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 0
      Text = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnChange = cbDocKindChange
      Items.Strings = (
        #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        #1044#1086#1082#1091#1084#1077#1085#1090'-'#1086#1073#1098#1077#1082#1090
        #1057#1083#1086#1074#1072#1088#1085#1072#1103' '#1089#1090#1072#1090#1100#1103
        'Flash-'#1089#1093#1077#1084#1072)
    end
    object gbImportFromFile: TGroupBox
      Left = 10
      Top = 227
      Width = 493
      Height = 108
      Anchors = [akLeft, akRight, akBottom]
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1072' '#1086#1089#1085#1086#1074#1077' '#1092#1072#1081#1083#1072' '
      TabOrder = 3
      DesignSize = (
        493
        108)
      object Label3: TLabel
        Left = 10
        Top = 20
        Width = 170
        Height = 16
        AutoSize = False
        Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
      end
      object FileEdit: TFilenameEdit
        Left = 8
        Top = 41
        Width = 477
        Height = 24
        DefaultExt = 'txt'
        Filter = 
          #1044#1086#1082#1091#1084#1077#1085#1090#1099' (*.docx, *.doc, *rtf)|*.docx;*.doc;*rtf|'#1069#1074#1077#1088#1077#1089#1090' (*.evd' +
          ')|*.evd|'#1043#1072#1088#1072#1085#1090' (*.nsr)|*.nsr|'#1048#1085#1090#1077#1088#1085#1077#1090' (*.htm, *html)|*.htm;*.htm' +
          'l|'#1058#1077#1082#1089#1090' (*.txt)|*.txt|'#1043#1088#1072#1092#1080#1082#1072'|*.bmp;*.wmf;*.jpg;*.jpeg;*.tif;*.t' +
          'iff;*.gif;*.png;*.ico;*.tga;*.pcx|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
        Anchors = [akLeft, akTop, akRight]
        NumGlyphs = 1
        TabOrder = 0
        OnChange = FileEditChange
      end
      object AnalizeChkBox: TCheckBox
        Left = 13
        Top = 75
        Width = 328
        Height = 17
        Caption = ' '#1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1075#1086#1083#1086#1074#1082#1072
        TabOrder = 1
      end
    end
  end
end

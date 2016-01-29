inherited ExportDlg: TExportDlg
  Left = 402
  Top = 189
  HorzScrollBar.Range = 0
  ActiveControl = cbWorkDir
  AutoScroll = False
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 558
  ClientWidth = 556
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Left = 459
    Height = 558
    inherited OK: TBitBtn
      OnClick = OKClick
    end
  end
  inherited PageCtrl: TPageControl
    Width = 459
    Height = 558
    ActivePage = TabSheet1
    object TabSheet1: TTabSheet
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      DesignSize = (
        451
        527)
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 355
        Height = 18
        AutoSize = False
        Caption = #1050#1072#1090#1072#1083#1086#1075' '#1076#1083#1103' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1101#1082#1089#1087#1086#1088#1090#1072
      end
      object Label6: TLabel
        Left = 8
        Top = 159
        Width = 115
        Height = 16
        Caption = #1060#1086#1088#1084#1072#1090' '#1101#1082#1089#1087#1086#1088#1090#1072
      end
      object btnSelectDir: TSpeedButton
        Left = 417
        Top = 25
        Width = 24
        Height = 24
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          55555555FFFFFFFFFF55555000000000055555577777777775F55500B8B8B8B8
          B05555775F555555575F550F0B8B8B8B8B05557F75F555555575550BF0B8B8B8
          B8B0557F575FFFFFFFF7550FBF0000000000557F557777777777500BFBFBFBFB
          0555577F555555557F550B0FBFBFBFBF05557F7F555555FF75550F0BFBFBF000
          55557F75F555577755550BF0BFBF0B0555557F575FFF757F55550FB700007F05
          55557F557777557F55550BFBFBFBFB0555557F555555557F55550FBFBFBFBF05
          55557FFFFFFFFF7555550000000000555555777777777755555550FBFB055555
          5555575FFF755555555557000075555555555577775555555555}
        NumGlyphs = 2
        OnClick = btnSelectDirClick
      end
      object Label8: TLabel
        Left = 8
        Top = 480
        Width = 177
        Height = 16
        Caption = #1055#1088#1080#1089#1074#1086#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1076#1086#1089#1090#1091#1087#1072
      end
      object cbWorkDir: TComboBox
        Left = 8
        Top = 25
        Width = 406
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 16
        TabOrder = 0
      end
      object gbExpType: TRadioGroup
        Left = 8
        Top = 55
        Width = 177
        Height = 92
        Caption = ' '#1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '
        ItemIndex = 0
        Items.Strings = (
          #1058#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
          #1042#1089#1102' '#1074#1099#1073#1086#1088#1082#1091)
        TabOrder = 1
        OnClick = gbExpTypeClick
      end
      object cbxViaServer: TCheckBox
        Left = 7
        Top = 502
        Width = 355
        Height = 17
        Caption = #1042#1099#1083#1080#1074#1072#1090#1100' '#1095#1077#1088#1077#1079' '#1089#1077#1088#1074#1077#1088
        TabOrder = 6
        Visible = False
      end
      object gbExportThings: TGroupBox
        Left = 8
        Top = 384
        Width = 433
        Height = 89
        Caption = ' '#1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1083#1077#1076#1091#1102#1097#1080#1077' '#1095#1072#1089#1090#1080': '
        TabOrder = 5
        DesignSize = (
          433
          89)
        object checkExportParts: TCheckListBox
          Left = 8
          Top = 16
          Width = 417
          Height = 65
          OnClickCheck = checkExportPartsClickCheck
          Anchors = [akLeft, akTop, akBottom]
          Columns = 2
          ItemHeight = 16
          Items.Strings = (
            #1058#1077#1082#1089#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
            #1058#1077#1082#1089#1090' '#1089#1087#1088#1072#1074#1086#1082
            #1040#1085#1085#1086#1090#1072#1094#1080#1080
            #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1077' '#1086#1073#1088#1072#1079#1099
            #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
            #1060#1086#1088#1084#1091#1083#1099' '#1082#1072#1082' '#1082#1072#1088#1090#1080#1085#1082#1080)
          TabOrder = 0
        end
      end
      object cbOutFormat: TComboBox
        Left = 128
        Top = 156
        Width = 313
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 3
        OnChange = cbOutFormatChange
        Items.Strings = (
          'Everest'
          'Everest ('#1090#1077#1082#1089#1090#1086#1074#1099#1081')'
          #1058#1077#1082#1089#1090
          'NSRC'
          'RTF'
          'HTML'
          'XML')
      end
      object gbExpMethod: TGroupBox
        Left = 192
        Top = 55
        Width = 249
        Height = 92
        Caption = ' '#1052#1077#1090#1086#1076' '#1101#1082#1089#1087#1086#1088#1090#1072' '
        TabOrder = 2
        object Label4: TLabel
          Left = 216
          Top = 45
          Width = 20
          Height = 16
          AutoSize = False
          Caption = #1050#1073
        end
        object rbSeparatedFiles: TRadioButton
          Left = 12
          Top = 68
          Width = 221
          Height = 17
          Caption = #1050#1072#1078#1076#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1086#1090#1076#1077#1083#1100#1085#1086
          TabOrder = 3
          OnClick = rbSeparatedFilesClick
        end
        object rbOneFile: TRadioButton
          Left = 11
          Top = 22
          Width = 214
          Height = 17
          Caption = #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1074' '#1086#1076#1080#1085' '#1092#1072#1081#1083
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbOneFileClick
        end
        object cbxPieceSize: TCheckBox
          Left = 36
          Top = 44
          Width = 147
          Height = 17
          Caption = #1053#1072#1088#1077#1079#1072#1090#1100' '#1087#1086
          TabOrder = 1
        end
        object edPieceSize: TvtSpinEdit
          Left = 143
          Top = 41
          Width = 70
          Height = 24
          MaxValue = 2000000.000000000000000000
          UseMinValue = False
          TabOrder = 2
        end
      end
      object gbPaths: TGroupBox
        Left = 8
        Top = 184
        Width = 433
        Height = 193
        Caption = ' '#1060#1072#1081#1083#1099' '
        TabOrder = 4
        object Label2: TLabel
          Left = 8
          Top = 21
          Width = 273
          Height = 17
          AutoSize = False
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '
        end
        object Label3: TLabel
          Left = 8
          Top = 62
          Width = 273
          Height = 17
          AutoSize = False
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1089#1087#1088#1072#1074#1086#1082' '
        end
        object Label5: TLabel
          Left = 8
          Top = 104
          Width = 273
          Height = 17
          AutoSize = False
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1086#1073#1098#1077#1082#1090#1085#1099#1093' '#1090#1086#1087#1080#1082#1086#1074
        end
        object Label7: TLabel
          Left = 8
          Top = 144
          Width = 273
          Height = 17
          AutoSize = False
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1072#1085#1085#1086#1090#1072#1094#1080#1081
        end
        object edtDocFileName: TEdit
          Left = 8
          Top = 40
          Width = 417
          Height = 24
          TabOrder = 0
        end
        object edtSprFileName: TEdit
          Left = 8
          Top = 81
          Width = 417
          Height = 24
          TabOrder = 1
        end
        object edtObjFileName: TEdit
          Left = 7
          Top = 121
          Width = 418
          Height = 24
          TabOrder = 2
        end
        object edtAnnoFileName: TEdit
          Left = 7
          Top = 161
          Width = 418
          Height = 24
          TabOrder = 3
        end
      end
      object comboToRegionList: TComboBox
        Left = 200
        Top = 475
        Width = 241
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 7
        Items.Strings = (
          '')
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1057#1083#1086#1074#1072#1088#1080
      ImageIndex = 1
      DesignSize = (
        451
        527)
      object cbxWithDict: TCheckBox
        Left = 7
        Top = 11
        Width = 234
        Height = 16
        Caption = ' '#1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1083#1086#1074#1072#1088#1080' '
        TabOrder = 0
      end
      object lstDicts: TvtDStringLister
        Left = 4
        Top = 38
        Width = 442
        Height = 481
        Sorted = False
        AutoRowHeight = False
        IntegralHeight = False
        MultiSelect = True
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        PickedList = True
        ParentColor = False
        TabOrder = 1
        TabStop = True
        Anchors = [akLeft, akTop, akRight, akBottom]
      end
    end
  end
end

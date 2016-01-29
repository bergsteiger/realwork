object en_PageSetup: Ten_PageSetup
  Left = 420
  Top = 212
  Width = 488
  Height = 300
  BorderIcons = [biSystemMenu, biHelp]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1088#1072#1085#1080#1094#1099
  Color = $00F9F8FA
  Constraints.MinHeight = 300
  Constraints.MinWidth = 480
  Scaled = False
  Position = poScreenCenter
  OnShow = vcmEntityFormRefShow
  OnCloseQueryEx = vcmEntityFormCloseQueryEx
  ZoneType = vcm_ztManualModal
  PixelsPerInch = 96
  TextHeight = 13
  object SettingsPageControl: TnscPageControl
    Left = 0
    Top = 0
    Width = 472
    Height = 264
    TabIndex = 0
    ActivePage = MarginsTabSheet
    Align = alClient
    TabOrder = 0
    ParentColor = False
    DockOrientation = doNoOrient
    OnChanging = SettingsPageControlChanging
    OnChange = SettingsPageControlChange
    object MarginsTabSheet: TElTabSheet
      Width = 468
      Height = 240
      PageControl = SettingsPageControl
      Caption = #1055#1086#1083#1103
      ParentColor = True
      object LeftMarginLabel: TvtLabel
        Left = 16
        Top = 11
        Width = 41
        Height = 16
        Caption = #1057#1083#1077#1074#1072':'
      end
      object LeftMarginUnitsLabel: TvtLabel
        Left = 176
        Top = 11
        Width = 18
        Height = 16
        Caption = #1084#1084
      end
      object UpMarginLabel: TvtLabel
        Left = 16
        Top = 35
        Width = 48
        Height = 16
        Caption = #1057#1074#1077#1088#1093#1091':'
      end
      object UpMarginUnitsLabel: TvtLabel
        Left = 176
        Top = 35
        Width = 18
        Height = 16
        Caption = #1084#1084
      end
      object RightMarginLabel: TvtLabel
        Left = 16
        Top = 59
        Width = 48
        Height = 16
        Caption = #1057#1087#1088#1072#1074#1072':'
      end
      object RightMarginUnitsLabel: TvtLabel
        Left = 176
        Top = 59
        Width = 18
        Height = 16
        Caption = #1084#1084
      end
      object DownMarginLabel: TvtLabel
        Left = 16
        Top = 83
        Width = 40
        Height = 16
        Caption = #1057#1085#1080#1079#1091':'
      end
      object DownMarginUnitsLabel: TvtLabel
        Left = 176
        Top = 83
        Width = 18
        Height = 16
        Caption = #1084#1084
      end
      object vtLabel1: TvtLabel
        Left = 6
        Top = 190
        Width = 194
        Height = 32
        Caption = '* '#1056#1072#1079#1084#1077#1088' '#1073#1091#1084#1072#1075#1080' '#1086#1087#1088#1077#1076#1077#1083#1103#1077#1090#1089#1103' '#1085#1072#1089#1090#1088#1086#1081#1082#1072#1084#1080' '#1087#1088#1080#1085#1090#1077#1088#1072
        WordWrap = True
      end
      object LeftMarginEdit: TvtSpinEdit
        Left = 88
        Top = 8
        Width = 81
        Height = 24
        MaxValue = 1000.000000000000000000
        EmptyValue = -1.000000000000000000
        TabOrder = 0
        OnChange = LeftMarginEditChange
        OnKeyPress = LeftMarginEditKeyPress
      end
      object UpMarginEdit: TvtSpinEdit
        Left = 88
        Top = 32
        Width = 81
        Height = 24
        MaxValue = 1000.000000000000000000
        EmptyValue = -1.000000000000000000
        TabOrder = 1
        OnChange = LeftMarginEditChange
        OnKeyPress = LeftMarginEditKeyPress
      end
      object RightMarginEdit: TvtSpinEdit
        Left = 88
        Top = 56
        Width = 81
        Height = 24
        MaxValue = 1000.000000000000000000
        EmptyValue = -1.000000000000000000
        TabOrder = 2
        OnChange = LeftMarginEditChange
        OnKeyPress = LeftMarginEditKeyPress
      end
      object DownMarginEdit: TvtSpinEdit
        Left = 88
        Top = 80
        Width = 81
        Height = 24
        MaxValue = 1000.000000000000000000
        EmptyValue = -1.000000000000000000
        TabOrder = 3
        OnChange = LeftMarginEditChange
        OnKeyPress = LeftMarginEditKeyPress
      end
      object PreviewGroupBox: TvtGroupBox
        Left = 277
        Top = 0
        Width = 191
        Height = 240
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' '#1042#1080#1076' '
        Color = $00F9F8FA
        ParentColor = False
        TabOrder = 4
        object ColontitulPaintBox: TPaintBox
          Left = 2
          Top = 18
          Width = 187
          Height = 220
          Align = alClient
          OnMouseDown = ColontitulPaintBoxMouseDown
          OnPaint = ColontitulPaintBoxPaint
        end
      end
      object OrientationGroupBox: TvtGroupBox
        Left = 5
        Top = 112
        Width = 195
        Height = 67
        Caption = ' '#1041#1091#1084#1072#1075#1072'* '
        TabOrder = 5
        object PaperFormatLabel: TvtLabel
          Left = 6
          Top = 15
          Width = 106
          Height = 16
          Caption = 'PaperFormatLabel'
        end
        object PageWidthLabel: TvtLabel
          Left = 6
          Top = 30
          Width = 95
          Height = 16
          Caption = 'PageWidthLabel'
        end
        object PageHeightLabel: TvtLabel
          Left = 6
          Top = 45
          Width = 98
          Height = 16
          Caption = 'PageHeightLabel'
        end
      end
    end
    object HeaderTabSheet: TElTabSheet
      Width = 468
      Height = 240
      PageControl = SettingsPageControl
      ImageIndex = 1
      Caption = #1055#1077#1088#1074#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
      Visible = False
      object ColontitulsPanel: TvtPanel
        Left = 0
        Top = 0
        Width = 293
        Height = 240
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          293
          240)
        object ColontitulLabel: TvtLabel
          Left = 6
          Top = 3
          Width = 71
          Height = 16
          Caption = #1050#1086#1083#1086#1085#1090#1080#1090#1091#1083':'
        end
        object AddMacroButton: TvtSpeedButton
          Left = 252
          Top = 0
          Width = 22
          Height = 22
          Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1084#1072#1082#1088#1086'...'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            6DF4834BFE7823FD6F01FA680FFA6537FC7C4CFC7846FE6E71FD8C91AA91FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF17FC232FC85F2FC85F2FC85F2FC95F2F
            C85F34C5632DAD4E317B41FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            10F31F2EC95E2FC85F2FC85F2FC85F36CF691E8B3970B47CFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF16F42C2FC85F2FC85F2FC85F35CE682F
            C85F33BF59509D61A6C8ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            1DF53A2FC85F2FC85F2FC85F2FC85F2FC9602FC95F47C66B579C67C7DDC7FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF24F64B2FC85F2FC85F38CC662FC95F2F
            C85F2FC95F41BA643B824A8AA78AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            2BF7542DB8532B96483BB65A2FC95F2FC85F2FC85F3C8B4F65996CFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF30F755297E375BA06266A36C41BB5D30
            C960317B41699070FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            31B6358AA88AFF00FFFF00FF91B791228C2D89AB8BFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentShowHint = False
          ShowHint = True
          OnClick = AddMacroButtonClick
        end
        object ColontitulComboBox: TvtComboBoxQS
          Left = 92
          Top = 0
          Width = 158
          Height = 22
          OnChange = ColontitulComboBoxChange
          Items.Strings = (
            #1042#1077#1088#1093#1085#1080#1081' '#1083#1077#1074#1099#1081
            #1042#1077#1088#1093#1085#1080#1081' '#1087#1088#1072#1074#1099#1081
            #1053#1080#1078#1085#1080#1081' '#1083#1077#1074#1099#1081
            #1053#1080#1078#1085#1080#1081' '#1087#1088#1072#1074#1099#1081)
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ComboStyle = ct_cbDropDownList
        end
        object ColontitulFomatMemo: TeeMemoWithEditOperations
          Left = 0
          Top = 24
          Width = 281
          Height = 222
          TextSource.OnChangeModified = ColontitulFomatMemoTextSourceChangeModified
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
          TabStop = True
        end
      end
    end
    object PageTabSheet: TElTabSheet
      Width = 468
      Height = 240
      PageControl = SettingsPageControl
      ImageIndex = 2
      Caption = #1057#1090#1088#1072#1085#1080#1094#1072
      Visible = False
    end
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enResult'
        Operations = <
          item
            Name = 'opOk'
          end
          item
            Name = 'opCancel'
          end
          item
            Name = 'opRestore'
          end
          item
            Name = 'opSaveAsDefault'
          end>
        ToolbarPos = vcm_tbpBottom
      end
      item
        Name = 'enColontitulMacro'
        Operations = <
          item
            Name = 'opAppTitle'
          end
          item
            Name = 'opDocName'
          end
          item
            Name = 'opDocFullName'
          end
          item
            Name = 'opDocRedactionDate'
          end
          item
            Name = 'opDocCurrentPage'
          end
          item
            Name = 'opDocPagesCount'
          end
          item
            Name = 'opCurrentDate'
          end
          item
            Name = 'opCurrentTime'
          end
          item
            Name = 'opInternalDocNumber'
          end
          item
            Name = 'opDocumentSIze'
          end
          item
            Name = 'opFilePosition'
          end>
        Controls = <
          item
            Control = ColontitulFomatMemo
          end>
      end
      item
        Name = 'enEdit'
        Controls = <
          item
            Control = ColontitulFomatMemo
          end
          item
            Control = ColontitulComboBox
          end>
      end
      item
        Name = 'enFile'
        Operations = <
          item
            Name = 'opPrint'
          end
          item
            Name = 'opPrintDialog'
          end
          item
            Name = 'opPrintPreview'
          end>
        Controls = <
          item
            Control = ColontitulFomatMemo
          end>
      end
      item
        Name = 'enText'
        Controls = <
          item
            Control = ColontitulComboBox
          end>
      end>
    Left = 354
    Top = 2
  end
  object PortraitLadscapeImageList: TvtNonFixedPngImageList
    Width = 48
    Height = 48
    Left = 386
    Top = 2
    PNGData = {
      89504E470D0A1A0A0000000D4948445200000090000000300806000000FE5AF3
      5600000006624B4744000000000000F943BB7F00000009704859730000000000
      00000001EA6516A40000029249444154789CED96816EDB300C44F3E9F9F315CE
      20C37025BE932C250E7B7CF0B65697E87864BA3EFE3D8C190705C644A0C09808
      1418138102632250604C040A8C894081311128C8C6E3F1FA63CA4377FD055090
      8DD7E0279497E83F28C8C6CC05DAFFC65BF382826CCC5EA0FDDF78734E50908D
      150BB47F8DB7F743BF87CD78C843E88F04D958B540FBF7D0411FB3FCB6EAEA12
      A1201BB306B2EA137D6696DF5695F71FF58D826CF40E645F0AB136EDF3F91C1A
      468D9EBB4BF5783EEA46960805D950832DD5338CADBE7981F6AFD1D5C11F09B2
      A106BBD5AFFF9A84FAF402F57AAE697A960805D950422DD53B8CADBE71815A0F
      797BF923C1282366DE8112EA56C701F40EE4530B34EAB9566A1F703CC67969EE
      B4446AA0475DCF30D4E055943B4B8D7AAE95DA071C8FF1ED0B740EFE380C7ABD
      1ABC0ADD57EA8AE75AA97DC0F175EEB43C1B4A98358D3A0C357815BAAFD415CF
      B552FB80E36BDC6D793628CC56E0EA275A0D5E85FC963BAF78AE95DA071C5FE3
      5B17283AA361A8C1AB90DF726774469E6BA5F601C7F950C3569ED67B28C1ABD0
      E0C9A3E2B9566A1F707C8DDD342ADF4714A212300D430D5E853CD179D1788126
      110D5E09983ED16AF02AB4F0333CD74AED038EF3112D905A775A20B5BC409368
      0D5D0D76ABE813AD06AF122DFC2CCF2DBDD2071CE7E318DE39D428DC96F6FC3A
      357895DA82AA9E23BDF23AA50F38CE4714DA8C52835759EDB7556A1FD8403656
      0F440D5E65B5DF56A97D6003D9583D10357895D57E5BA5F6810D6463F540D4E0
      5556FB6D95DA0736908DD50351835739FEC2FBEE47E9038EF3B105B3B2D4E055
      B6F7FAE443FEB0816C7CDB02DD1D1464837E6CCF78BC40C9A11FDB331EF29005
      1418138102632250604C040A8C89408131112830260205C644A0C098881F20B5
      BF20334807F00000000049454E44AE42608289504E470D0A1A0A0000000D4948
      445200000090000000300806000000FE5AF35600000006624B47440000000000
      00F943BB7F0000000970485973000000000000000001EA6516A4000002924944
      4154789CED96816EDB300C44F3E9F9F315CE20C37025BE932C250E7B7CF0B656
      97E87864BA3EFE3D8C190705C644A0C098081418138102632250604C040A8C89
      4081311128C8C6E3F1FA63CA4377FD0550908DD7E0279497E83F28C8C6CC05DA
      FFC65BF382826CCC5EA0FDDF78734E50908D150BB47F8DB7F743BF87CD78C843
      E88F04D958B540FBF7D0411FB3FCB6EAEA12A1201BB306B2EA137D6696DF5695
      F71FF58D826CF40E645F0AB136EDF3F91C1A468D9EBB4BF5783EEA46960805D9
      50832DD5338CADBE7981F6AFD1D5C11F09B2A106BBD5AFFF9A84FAF402F57AAE
      697A960805D950422DD53B8CADBE71815A0F797BF923C1282366DE8112EA56C7
      01F40EE4530B34EAB9566A1F703CC67969EEB4446AA0475DCF30D4E055943B4B
      8D7AAE95DA071C8FF1ED0B740EFE380C7ABD1ABC0ADD57EA8AE75AA97DC0F175
      EEB43C1B4A98358D3A0C357815BAAFD415CFB552FB80E36BDC6D793628CC56E0
      EA275A0D5E85FC963BAF78AE95DA071C5FE35B17283AA361A8C1AB90DF726774
      469E6BA5F601C7F950C3569ED67B28C1ABD0E0C9A3E2B9566A1F707C8DDD342A
      DF4714A212300D430D5E853CD179D1788126110D5E09983ED16AF02AB4F0333C
      D74AED038EF3112D905A775A20B5BC4093680D5D0D76ABE813AD06AF122DFC2C
      CF2DBDD2071CE7E318DE39D428DC96F6FC3A357895DA82AA9E23BDF23AA50F38
      CE4714DA8C52835759EDB7556A1FD84036560F440D5E65B5DF56A97D6003D958
      3D10357895D57E5BA5F6810D6463F540D4E05556FB6D95DA0736908DD5035183
      5739FEC2FBEE47E9038EF3B105B3B2D4E055B6F7FAE443FEB0816C7CDB02DD1D
      1464837E6CCF78BC40C9A11FDB331EF290051418138102632250604C040A8C89
      408131112830260205C644A0C098881F20B5BF20334807F00000000049454E44
      AE42608289504E470D0A1A0A0000000D49484452000000900000003008060000
      00FE5AF35600000006624B4744000000000000F943BB7F000000097048597300
      0000000000000001EA6516A40000029249444154789CED96816EDB300C44F3E9
      F9F315CE20C37025BE932C250E7B7CF0B65697E87864BA3EFE3D8C190705C644
      A0C098081418138102632250604C040A8C894081311128C8C6E3F1FA63CA4377
      FD0550908DD7E0279497E83F28C8C6CC05DAFFC65BF382826CCC5EA0FDDF7873
      4E50908D150BB47F8DB7F743BF87CD78C843E88F04D958B540FBF7D0411FB3FC
      B6EAEA12A1201BB306B2EA137D6696DF5695F71FF58D826CF40E645F0AB136ED
      F3F91C1A468D9EBB4BF5783EEA46960805D950832DD5338CADBE7981F6AFD1D5
      C11F09B2A106BBD5AFFF9A84FAF402F57AAE697A960805D950422DD53B8CADBE
      71815A0F797BF923C1282366DE8112EA56C701F40EE4530B34EAB9566A1F703C
      C67969EEB4446AA0475DCF30D4E055943B4B8D7AAE95DA071C8FF1ED0B740EFE
      380C7ABD1ABC0ADD57EA8AE75AA97DC0F175EEB43C1B4A98358D3A0C357815BA
      AFD415CFB552FB80E36BDC6D793628CC56E0EA275A0D5E85FC963BAF78AE95DA
      071C5FE35B17283AA361A8C1AB90DF726774469E6BA5F601C7F950C3569ED67B
      28C1ABD0E0C9A3E2B9566A1F707C8DDD342ADF4714A212300D430D5E853CD179
      D1788126110D5E09983ED16AF02AB4F0333CD74AED038EF3112D905A775A20B5
      BC4093680D5D0D76ABE813AD06AF122DFC2CCF2DBDD2071CE7E318DE39D428DC
      96F6FC3A357895DA82AA9E23BDF23AA50F38CE4714DA8C52835759EDB7556A1F
      D84036560F440D5E65B5DF56A97D6003D9583D10357895D57E5BA5F6810D6463
      F540D4E05556FB6D95DA0736908DD50351835739FEC2FBEE47E9038EF3B105B3
      B2D4E055B6F7FAE443FEB0816C7CDB02DD1D1464837E6CCF78BC40C9A11FDB33
      1EF290051418138102632250604C040A8C89408131112830260205C644A0C098
      881F20B5BF20334807F00000000049454E44AE426082}
  end
end

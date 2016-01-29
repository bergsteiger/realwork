inherited ChangeDocWizardDlg: TChangeDocWizardDlg
  Left = 411
  Top = 154
  Width = 569
  Height = 578
  Caption = #1042#1085#1077#1089#1077#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
  PixelsPerInch = 96
  TextHeight = 16
  object Label5: TLabel [0]
    Left = 16
    Top = 375
    Width = 106
    Height = 16
    AutoSize = False
    Caption = #1044#1072#1090#1072' '#1080#1079#1076#1072#1085#1080#1103
  end
  inherited ButtonPanel: TPanel
    Top = 495
    Width = 553
    inherited OK: TBitBtn
      Left = 287
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 378
    end
    inherited Help: TBitBtn
      Left = 468
    end
  end
  inherited Panel1: TPanel
    Width = 553
    Height = 495
    object GroupBox2: TGroupBox
      Left = 8
      Top = 5
      Width = 545
      Height = 159
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1048#1079#1084#1077#1085#1103#1077#1084#1099#1081' '
      TabOrder = 0
      DesignSize = (
        545
        159)
      object stChangingDocName: TStaticText
        Left = 8
        Top = 60
        Width = 528
        Height = 90
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        BevelKind = bkTile
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 2
        Top = 18
        Width = 541
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 9
          Width = 200
          Height = 16
          AutoSize = False
          Caption = 'ID '#1048#1079#1084#1077#1085#1103#1077#1084#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangingDocIDName: TSpeedButton
          Left = 337
          Top = 6
          Width = 23
          Height = 22
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF3333FFFF
            FFFFF0003333FFFFF00FF0FF3FFFFFFF000FF0FFFFF0000800FFF0FF33087780
            8FFFF00030877E880FFFF0FF307777870FFFF0FFF07E77870FFFF0FF308EE788
            0FFFF00033087780FFFFF0FF3FF0000FFFFFF0FFFFFFFFFFFFFFF0FFF3333FFF
            FFFFF00003333FFFFFFFF0FFF3FFFFFFFFFFF0FFFFFFFFFFFFFF}
          OnClick = sbChangingDocIDNameClick
        end
        object edtChangingDocID: TEdit
          Left = 211
          Top = 5
          Width = 121
          Height = 24
          TabOrder = 0
          OnExit = edtChangingDocIDExit
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 171
      Width = 545
      Height = 236
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1048#1079#1084#1077#1085#1103#1102#1097#1080#1081' '
      TabOrder = 1
      DesignSize = (
        545
        236)
      object Label4: TLabel
        Left = 8
        Top = 167
        Width = 107
        Height = 16
        AutoSize = False
        Caption = #1044#1072#1090#1072' '#1080#1079#1076#1072#1085#1080#1103
      end
      object Label6: TLabel
        Left = 8
        Top = 201
        Width = 166
        Height = 16
        AutoSize = False
        Caption = #1044#1072#1090#1072' '#1074#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1074' '#1089#1080#1083#1091
      end
      object Panel2: TPanel
        Left = 2
        Top = 18
        Width = 541
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 9
          Width = 200
          Height = 16
          AutoSize = False
          Caption = 'ID '#1048#1079#1084#1077#1085#1103#1102#1097#1077#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangeDocIDName: TSpeedButton
          Left = 337
          Top = 6
          Width = 23
          Height = 22
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF3333FFFF
            FFFFF0003333FFFFF00FF0FF3FFFFFFF000FF0FFFFF0000800FFF0FF33087780
            8FFFF00030877E880FFFF0FF307777870FFFF0FFF07E77870FFFF0FF308EE788
            0FFFF00033087780FFFFF0FF3FF0000FFFFFF0FFFFFFFFFFFFFFF0FFF3333FFF
            FFFFF00003333FFFFFFFF0FFF3FFFFFFFFFFF0FFFFFFFFFFFFFF}
          OnClick = sbChangeDocIDNameClick
        end
        object edtChangeDocID: TEdit
          Left = 211
          Top = 5
          Width = 121
          Height = 24
          TabOrder = 0
          OnExit = edtChangeDocIDExit
        end
      end
      object stChangeDocName: TStaticText
        Left = 8
        Top = 60
        Width = 528
        Height = 90
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        BevelKind = bkTile
        FocusControl = edtChangeDocID
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 1
      end
      object edtChangeDate: TvtDateEdit
        Left = 173
        Top = 162
        Width = 121
        Height = 24
        Style = csDropDown
        TabOrder = 2
      end
      object edtChangerActivDate: TvtDateEdit
        Left = 173
        Top = 198
        Width = 121
        Height = 24
        Style = csDropDown
        TabOrder = 3
      end
    end
    object GroupBox4: TGroupBox
      Left = 9
      Top = 417
      Width = 544
      Height = 75
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1056#1077#1076#1072#1082#1094#1080#1103' '
      TabOrder = 2
      object Label3: TLabel
        Left = 234
        Top = 34
        Width = 93
        Height = 16
        AutoSize = False
        Caption = 'ID '#1088#1077#1076#1072#1082#1094#1080#1080
      end
      object edtEditionDocID: TvtSpinEdit
        Left = 326
        Top = 30
        Width = 121
        Height = 24
        UseMaxValue = False
        TabOrder = 2
      end
      object rbEditionKindOld: TRadioButton
        Left = 14
        Top = 23
        Width = 142
        Height = 17
        Caption = #1057#1090#1072#1088#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbEditionKindNext: TRadioButton
        Left = 14
        Top = 45
        Width = 155
        Height = 17
        Caption = #1041#1091#1076#1091#1097#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
        TabOrder = 1
      end
    end
  end
end

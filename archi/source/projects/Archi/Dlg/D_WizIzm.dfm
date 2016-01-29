inherited IzmWizardDlg: TIzmWizardDlg
  Left = 408
  Top = 199
  VertScrollBar.Range = 0
  ActiveControl = edtChangingDocID
  AutoScroll = False
  Caption = #1042#1053#1045#1057#1045#1053#1048#1045' '#1048#1047#1052#1045#1053#1045#1053#1048#1049
  ClientHeight = 339
  ClientWidth = 512
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 294
    Width = 512
    inherited OK: TBitBtn
      Left = 239
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 329
    end
    inherited Help: TBitBtn
      Left = 419
    end
  end
  inherited PageCtrl: TPageControl
    Width = 512
    Height = 294
    ActivePage = TabSheet1
    object TabSheet1: TTabSheet
      Caption = #1048#1079#1084#1077#1085#1103#1077#1084#1099#1081
      DesignSize = (
        504
        263)
      object stChangingDocName: TStaticText
        Left = 6
        Top = 44
        Width = 492
        Height = 210
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 504
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          504
          41)
        object Label1: TLabel
          Left = 4
          Top = 13
          Width = 192
          Height = 16
          AutoSize = False
          Caption = 'ID '#1048#1079#1084#1077#1085#1103#1077#1084#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangingDocIDName: TSpeedButton
          Left = 332
          Top = 10
          Width = 23
          Height = 22
          Anchors = [akTop, akRight]
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
        object edtChangingDocID: TvtSpinEdit
          Left = 207
          Top = 9
          Width = 121
          Height = 24
          UseMaxValue = False
          TabOrder = 0
          OnExit = edtChangingDocIDExit
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1079#1084#1077#1085#1103#1102#1097#1080#1081
      ImageIndex = 1
      DesignSize = (
        504
        263)
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 504
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          504
          41)
        object Label2: TLabel
          Left = 4
          Top = 13
          Width = 200
          Height = 16
          AutoSize = False
          Caption = 'ID '#1048#1079#1084#1077#1085#1103#1102#1097#1077#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangeDocIDName: TSpeedButton
          Left = 332
          Top = 10
          Width = 23
          Height = 22
          Anchors = [akTop, akRight]
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
        object edtChangeDocID: TvtSpinEdit
          Left = 207
          Top = 9
          Width = 121
          Height = 24
          UseMaxValue = False
          TabOrder = 0
          OnExit = edtChangeDocIDExit
        end
      end
      object stChangeDocName: TStaticText
        Left = 7
        Top = 44
        Width = 492
        Height = 110
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        FocusControl = edtChangeDocID
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 157
        Width = 492
        Height = 94
        Anchors = [akLeft, akTop, akRight]
        Caption = #1048#1079#1076#1072#1085
        TabOrder = 2
        object Label4: TLabel
          Left = 12
          Top = 27
          Width = 44
          Height = 16
          AutoSize = False
          Caption = #1044#1072#1090#1072
        end
        object Label5: TLabel
          Left = 15
          Top = 63
          Width = 43
          Height = 16
          Caption = #1053#1086#1084#1077#1088
        end
        object edtChangeDate: TvtDateEdit
          Left = 67
          Top = 21
          Width = 121
          Height = 24
          Style = csDropDown
          TabOrder = 0
        end
        object edtChangeName: TEdit
          Left = 67
          Top = 58
          Width = 170
          Height = 24
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      ImageIndex = 2
      object Label3: TLabel
        Left = 6
        Top = 17
        Width = 136
        Height = 16
        AutoSize = False
        Caption = 'ID '#1089#1090#1072#1088#1086#1081' '#1088#1077#1076#1072#1082#1094#1080#1080
      end
      object edtOldEditionDocID: TvtSpinEdit
        Left = 146
        Top = 12
        Width = 121
        Height = 24
        UseMaxValue = False
        TabOrder = 0
      end
    end
  end
end

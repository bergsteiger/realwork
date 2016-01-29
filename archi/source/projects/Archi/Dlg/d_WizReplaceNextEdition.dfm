inherited ReplaceNextEditionDlg: TReplaceNextEditionDlg
  Left = 442
  Top = 210
  Width = 569
  Height = 416
  BorderStyle = bsSizeable
  Caption = #1047#1072#1084#1077#1097#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1081' '#1088#1077#1076#1072#1082#1094#1080#1080
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 344
    Width = 561
    inherited OK: TBitBtn
      Left = 287
    end
    inherited Cancel: TBitBtn
      Left = 378
    end
    inherited Help: TBitBtn
      Left = 468
    end
  end
  inherited Panel1: TPanel
    Width = 561
    Height = 344
    object GroupBox2: TGroupBox
      Left = 8
      Top = 6
      Width = 545
      Height = 159
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1041#1091#1076#1091#1097#1072#1103' '#1088#1077#1076#1082#1094#1080#1103' '
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
          Top = 11
          Width = 103
          Height = 16
          AutoSize = False
          Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangingDocIDName: TSpeedButton
          Left = 234
          Top = 10
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
        object edtNextEditionDocID: TvtSpinEdit
          Left = 109
          Top = 8
          Width = 121
          Height = 24
          UseMaxValue = False
          TabOrder = 0
          OnExit = edtNextEditionDocIDExit
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 171
      Width = 545
      Height = 162
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1058#1077#1082#1091#1097#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103' '
      TabOrder = 1
      DesignSize = (
        545
        162)
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
          Top = 11
          Width = 101
          Height = 16
          AutoSize = False
          Caption = 'ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object sbChangeDocIDName: TSpeedButton
          Left = 236
          Top = 8
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
        object edtCurEditionDocID: TvtSpinEdit
          Left = 111
          Top = 7
          Width = 121
          Height = 24
          UseMaxValue = False
          TabOrder = 0
          OnExit = edtCurEditionDocIDExit
        end
      end
      object stChangeDocName: TStaticText
        Left = 8
        Top = 60
        Width = 528
        Height = 90
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BevelKind = bkTile
        FocusControl = edtCurEditionDocID
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
end

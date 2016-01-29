inherited MainForm: TMainForm
  PixelsPerInch = 120
  TextHeight = 16
  inherited StatusLine: TvtHeader
   Sections =<
              item
                Width = 380
              end
              item
                Width = 152
              end
              item
                Width = 8
              end
    >          
  end
  inherited dcTop: TDock97
    Height = 110
    inherited tbAdd: TToolbar97
      Left = 302
      DockPos = 302
    end
    inherited tbJustification: TToolbar97
      Left = 174
      DockPos = 174
    end
    inherited tbFont: TToolbar97
      inherited btVisible: TevButton
        Left = 92
      end
      object btBold: TevButton
        Left = 0
        Operation = ev_ccBold
        AllowAllUp = True
        GroupIndex = 6
        ImageIndex = 98
        Images = dmStandardRes.ilOffice
      end
      object btItalic: TevButton
        Left = 23
        Operation = ev_ccItalic
        AllowAllUp = True
        GroupIndex = 2
        ImageIndex = 99
        Images = dmStandardRes.ilOffice
      end
      object btUnderline: TevButton
        Left = 46
        Operation = ev_ccUnderline
        AllowAllUp = True
        GroupIndex = 3
        ImageIndex = 100
        Images = dmStandardRes.ilOffice
      end
      object btStrikeout: TevButton
        Left = 69
        Operation = ev_ccStrikeout
        AllowAllUp = True
        GroupIndex = 4
        ImageIndex = 113
        Images = dmStandardRes.ilOffice
      end
      object btSubScript: TevButton
        Left = 138
        Operation = ev_ccSubscript
        AllowAllUp = True
        GroupIndex = 13
        ImageIndex = 118
        Images = dmStandardRes.ilOffice
      end
      object btSuperScript: TevButton
        Left = 115
        Operation = ev_ccSuperscript
        AllowAllUp = True
        GroupIndex = 13
        ImageIndex = 117
        Images = dmStandardRes.ilOffice
      end
    end
    inherited tbTable: TToolbar97
      Left = 361
      DockPos = 361
    end
    inherited tbZoom: TToolbar97
      Left = 514
      DockPos = 514
    end
    inherited tbVerticalAligment: TToolbar97
      Left = 604
      DockPos = 604
    end
    inherited tbOutline: TToolbar97
      Left = 0
      Top = 82
      DockPos = 0
      DockRow = 3
    end
    object tbBackColor: TToolbar97
      Left = 450
      Top = 54
      Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072
      DockPos = 450
      DockRow = 2
      object BackColorComboBox: TvtColorBox
        Left = 0
        Top = 0
        Width = 51
        Height = 23
        Hint = #1062#1074#1077#1090' '#1092#1086#1085#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        ColorStyle = [cbStandardColors, cbExtendedColors, cbSystemColors, cbNoName]
        OnChange = BackColorComboBoxChange
      end
    end
    object tbFontName: TToolbar97
      Left = 160
      Top = 54
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1096#1088#1080#1092#1090#1072
      DockPos = 160
      DockRow = 2
      object FontComboBox: TFontComboBox
        Left = 0
        Top = 0
        Width = 148
        Height = 23
        Hint = #1064#1088#1080#1092#1090
        Device = fdBoth
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnChange = FontComboBoxChange
      end
    end
    object tbForeColor: TToolbar97
      Left = 386
      Top = 54
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      DockPos = 386
      DockRow = 2
      object ColorComboBox: TvtColorBox
        Left = 0
        Top = 0
        Width = 51
        Height = 23
        Hint = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        ColorStyle = [cbStandardColors, cbExtendedColors, cbSystemColors, cbNoName]
        OnChange = ColorComboBoxChange
      end
    end
    object tbFontSize: TToolbar97
      Left = 321
      Top = 54
      Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      DockPos = 321
      DockRow = 2
      object FontSizeComboBox: TFontSizeComboBox
        Left = 0
        Top = 0
        Width = 52
        Height = 24
        Hint = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnChange = FontSizeComboBoxChange
        FontSize = 0
      end
    end
  end
  inherited dcLeft: TDock97
    Top = 110
    Height = 280
  end
  inherited MainMenu: TMainMenu
    inherited miFormat: TevMenuItem
      inherited N5: TMenuItem
        GroupIndex = 6
      end
      object miBold: TevMenuItem [6]
        AutoCheck = True
        Caption = #1046#1080#1088#1085#1099#1081
        GroupIndex = 6
        ImageIndex = 98
        ShortCut = 16450
        Operation = ev_ccBold
      end
      object miItalic: TevMenuItem [7]
        AutoCheck = True
        Caption = #1050#1091#1088#1089#1080#1074
        GroupIndex = 6
        ImageIndex = 99
        ShortCut = 16457
        Operation = ev_ccItalic
      end
      object miUnderline: TevMenuItem [8]
        AutoCheck = True
        Caption = #1055#1086#1076#1095#1077#1088#1082#1080#1074#1072#1085#1080#1077
        GroupIndex = 6
        ImageIndex = 100
        ShortCut = 16469
        Operation = ev_ccUnderline
      end
      object miSuperscript: TevMenuItem [9]
        AutoCheck = True
        Caption = #1042#1077#1088#1093#1085#1080#1081' '#1080#1085#1076#1077#1082#1089
        GroupIndex = 6
        ImageIndex = 117
        RadioItem = True
        ShortCut = 16571
        Operation = ev_ccSuperscript
      end
      object miSubscript: TevMenuItem [10]
        AutoCheck = True
        Caption = #1053#1080#1078#1085#1080#1081' '#1080#1085#1076#1077#1082#1089
        GroupIndex = 6
        ImageIndex = 118
        RadioItem = True
        ShortCut = 24763
        Operation = ev_ccSubscript
      end
      object N11: TevMenuItem [11]
        Caption = '-'
        GroupIndex = 6
      end
    end
  end
end

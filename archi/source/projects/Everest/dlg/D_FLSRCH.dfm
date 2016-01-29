object FileSrchForm: TFileSrchForm
  Left = 329
  Top = 131
  Width = 472
  Height = 539
  ActiveControl = edtRootDirectory
  Caption = #1060#1040#1049#1051#1067
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 277
    Width = 456
    Height = 226
    Align = alClient
    BevelWidth = 2
    BorderWidth = 4
    TabOrder = 0
    object lstSrchResult: TvtDStringLister
      Left = 6
      Top = 6
      Width = 444
      Height = 192
      Sorted = False
      AutoRowHeight = False
      BorderStyle = bsNone
      IntegralHeight = False
      MultiSelect = True
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 53
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clHighlight
      SelectNonFocusColor.TextColor = clHighlightText
      OnCurrentChanged = lstSrchResultCurrentChanged
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      ParentColor = False
      TabOrder = 0
      TabStop = True
    end
    object ResListFooter: TvtHeader
      Left = 6
      Top = 198
      Width = 444
      Height = 22
      Align = alBottom
      BevelInner = bvLowered
      BevelWidth = 2
      BorderStyle = bsNone
      Font.Name = 'Arial CYR'
      OnSizing = ResListFooterSizing
      Sections = <
        item
          Width = 104
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end
        item
          Width = 144
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end
        item
          Width = 20
          AutoResize = False
          MinWidth = 20
          MaxWidth = 2147483647
        end>
      TabOrder = 1
      object Progress: TvtW95Meter
        Left = 3
        Top = 3
        Width = 84
        Height = 16
        EdgeStyle = st95None
        Visible = False
      end
    end
  end
  object pnlParam: TPanel
    Left = 0
    Top = 30
    Width = 456
    Height = 247
    Align = alTop
    TabOrder = 1
    object sbAdvSettings: TToolbarButton97
      Left = 338
      Top = 2
      Width = 27
      Height = 27
      NumGlyphs = 2
      OnClick = sbAdvSettingsClick
    end
    object sbContUp: TToolbarButton97
      Left = 286
      Top = 18
      Width = 24
      Height = 27
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        7700777777777777777777777777777777777777770077777777777777777777
        777777777777777777007777777777777777777777FFFFFFFFFFFFFFF7007755
        55555555555557777888888888888888F70077757777757575757777778FFFFF
        8777778F7700777757777757575777777778F777877778F77700777775777575
        7577777777778F7787778F77770077777757775757777777777778F78778F777
        7700777777757575777777777777778F8F8F7777770077777777575777777777
        77777778F8F77777770077777777757777777777777777778F77777777007777
        777777777777777777FFFFFFFFFFFFFFF7007755555555555555577778888888
        88888888F7007755555555555555577778888888888888887700777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      NumGlyphs = 2
      Visible = False
    end
    object sbContDown: TToolbarButton97
      Left = 253
      Top = 18
      Width = 25
      Height = 27
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F77777777777
        7777777777777777777777777700777777777777777777777777777777777777
        77007777777777777777777777FFFFFFFFFFFFFFF70077555555555555555777
        7888888888888888F70077555555555555555777788888888888888877007777
        777777777777777777777777F777777777007777777775777777777777777777
        8F77777777007777777757577777777777777778F8F777777700777777757575
        777777777777778F878F7777770077777757775757777777777778F78778F777
        77007777757775757577777777778F7787778F77770077775777775757577777
        7778F777877778F7770077757777757575757777778FFFFF8777778F77007755
        55555555555557777888888888888888F7007777777777777777777777777777
        7777777777007777777777777777777777777777777777777700777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      NumGlyphs = 2
      Visible = False
    end
    object edtRootDirectory: TDirectoryEdit
      Left = 6
      Top = 5
      Width = 328
      Height = 21
      NumGlyphs = 1
      ButtonWidth = 25
      TabOrder = 0
    end
    object nbkParam: TOvcNotebook
      Left = 2
      Top = 34
      Width = 364
      Height = 208
      ActiveTabFont.Charset = DEFAULT_CHARSET
      ActiveTabFont.Color = clBlack
      ActiveTabFont.Height = -13
      ActiveTabFont.Name = 'Arial'
      ActiveTabFont.Style = [fsBold]
      ConserveResources = False
      PageHelpContext = 0
      TabIndent = 0
      TabWidth = 120
      AutoTabSize = False
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object TOvcNotebookPage
        Caption = '&'#1060#1072#1081#1083#1099
        object GroupBox1: TGroupBox
          Left = 5
          Top = 5
          Width = 341
          Height = 73
          Caption = ' '#1052#1072#1089#1082#1072' '
          TabOrder = 0
          object Label1: TLabel
            Left = 6
            Top = 21
            Width = 72
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1042#1082#1083#1102#1095#1072#1090#1100
          end
          object Label2: TLabel
            Left = 6
            Top = 47
            Width = 73
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1048#1089#1082#1083#1102#1095#1072#1090#1100
          end
          object EdIncFileMask: TevEdit
            Left = 82
            Top = 16
            Width = 253
            Height = 22
            LMargin = 1
            Text = '*.evd'
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 0
            TabStop = True
          end
          object EdExcFileMask: TevEdit
            Left = 82
            Top = 42
            Width = 253
            Height = 23
            LMargin = 1
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 1
            TabStop = True
          end
        end
        object FileAttrGroup: TGroupBox
          Left = 6
          Top = 82
          Width = 184
          Height = 96
          Caption = ' '#1040#1090#1090#1088#1080#1073#1091#1090#1099' '
          TabOrder = 1
          object ChkbxfileNormal: TCheckBox
            Left = 6
            Top = 18
            Width = 68
            Height = 20
            Caption = '&Normal'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object Chkbxfilearchive: TCheckBox
            Left = 6
            Top = 38
            Width = 80
            Height = 17
            Caption = 'Archi&ve'
            Checked = True
            Ctl3D = True
            ParentCtl3D = False
            State = cbChecked
            TabOrder = 1
          end
          object Chkbxfilereadonly: TCheckBox
            Left = 6
            Top = 55
            Width = 83
            Height = 17
            Caption = '&Readonly'
            TabOrder = 2
          end
          object Chkbxfilehidden: TCheckBox
            Left = 6
            Top = 73
            Width = 80
            Height = 17
            Caption = '&Hidden'
            TabOrder = 3
          end
          object Chkbxfilesystem: TCheckBox
            Left = 94
            Top = 18
            Width = 79
            Height = 19
            Caption = 'S&ystem'
            TabOrder = 4
          end
          object ChkbxfileVolume: TCheckBox
            Left = 94
            Top = 55
            Width = 88
            Height = 16
            Caption = 'Vol&ume ID'
            TabOrder = 6
          end
          object Chkbxfiledirectory: TCheckBox
            Left = 94
            Top = 38
            Width = 79
            Height = 16
            Caption = '&Directory'
            TabOrder = 5
          end
        end
        object GroupBox2: TGroupBox
          Left = 193
          Top = 82
          Width = 153
          Height = 72
          Caption = ' '#1044#1072#1090#1072' '
          TabOrder = 2
          object Label4: TLabel
            Left = 8
            Top = 21
            Width = 33
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1089
          end
          object Label5: TLabel
            Left = 10
            Top = 47
            Width = 32
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1076#1086
          end
          object LowDateEdit: TvtDateEdit
            Left = 49
            Top = 15
            Width = 97
            Height = 24
            Style = csDropDown
            TabOrder = 0
          end
          object HiDateEdit: TvtDateEdit
            Left = 49
            Top = 42
            Width = 97
            Height = 24
            Style = csDropDown
            TabOrder = 1
          end
        end
        object ChkbxWithSubDir: TCheckBox
          Left = 194
          Top = 158
          Width = 151
          Height = 17
          Caption = 'C &'#1087#1086#1076#1082#1072#1090#1072#1083#1086#1075#1072#1084#1080
          TabOrder = 3
        end
      end
      object TOvcNotebookPage
        Caption = '&'#1050#1072#1090#1072#1083#1086#1075#1080
        object Label3: TLabel
          Left = 9
          Top = 14
          Width = 62
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = #1052#1072#1089#1082#1072
        end
        object EdDirMask: TevEdit
          Left = 77
          Top = 8
          Width = 268
          Height = 22
          LMargin = 1
          Text = '*.*'
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          TabStop = True
        end
        object DirAttrGroup: TGroupBox
          Left = 6
          Top = 37
          Width = 104
          Height = 108
          Caption = ' '#1040#1090#1090#1088#1080#1073#1091#1090#1099' '
          TabOrder = 1
          object ChkbxdirNormal: TCheckBox
            Left = 10
            Top = 18
            Width = 69
            Height = 16
            Caption = '&Normal'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object Chkbxdirarchive: TCheckBox
            Left = 10
            Top = 34
            Width = 80
            Height = 16
            Caption = 'Archi&ve'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object Chkbxdirreadonly: TCheckBox
            Left = 10
            Top = 50
            Width = 80
            Height = 19
            Caption = '&Readonly'
            TabOrder = 2
          end
          object Chkbxdirhidden: TCheckBox
            Left = 10
            Top = 66
            Width = 80
            Height = 20
            Caption = '&Hidden'
            TabOrder = 3
          end
          object Chkbxdirsystem: TCheckBox
            Left = 10
            Top = 85
            Width = 80
            Height = 17
            Caption = 'S&ystem'
            TabOrder = 4
          end
        end
        object AddGroup: TGroupBox
          Left = 118
          Top = 34
          Width = 156
          Height = 46
          TabOrder = 2
          object ChkbxOnlyDir: TCheckBox
            Left = 10
            Top = 21
            Width = 139
            Height = 12
            Caption = '&'#1058#1086#1083#1100#1082#1086' '#1082#1072#1090#1072#1083#1086#1075#1080
            TabOrder = 0
          end
        end
      end
      object TOvcNotebookPage
        Caption = '&'#1058#1077#1082#1089#1090
        object TextLabel: TLabel
          Left = 6
          Top = 26
          Width = 47
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = #1058#1077#1082#1089#1090
          FocusControl = SrchStrEdit
          Transparent = True
        end
        object SrchStrEdit: TevEdit
          Left = 58
          Top = 22
          Width = 288
          Height = 23
          LMargin = 1
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          TabStop = True
        end
        object TextCaseCkBox: TCheckBox
          Left = 17
          Top = 63
          Width = 145
          Height = 15
          Caption = #1056#1072#1079#1083#1080#1095#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
          TabOrder = 1
        end
        object AnsiChkBox: TCheckBox
          Left = 17
          Top = 85
          Width = 135
          Height = 13
          Caption = 'ANSI '#1082#1086#1076#1080#1088#1086#1074#1082#1072
          TabOrder = 2
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 30
    Align = alTop
    TabOrder = 2
    object tbFindFile: TToolbarButton97
      Left = 2
      Top = 2
      Width = 27
      Height = 27
      Hint = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'|'
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        7700777777777777777777777777777777777777770077777777777777777777
        7FFFFFF7777FFFFFF70077000007777700000777788888F777788888F700770F
        000777770F00077778F888F77778F888F700770F000777770F00077778F888FF
        7FF8F888F7007700000007000000077778888888F8888888F7007700F000000F
        00000777788F888888F88888F7007700F000700F00000777788F888F88F88888
        F7007700F000700F00000777788F888F88F88888F70077700000000000007777
        778888888888888F770077770F00070F000777777778F888F8F888F777007777
        000007000007777777788888F88888F77700777770007770007777777777888F
        77888F777700777770F07770F077777777778F8F778F8F777700777770007770
        007777777777888F77888F777700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      NumGlyphs = 2
      OnClick = tbFindFileClick
    end
    object tbStopFind: TToolbarButton97
      Left = 29
      Top = 2
      Width = 25
      Height = 27
      Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086#1080#1089#1082'|'
      Enabled = False
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777777777777777777777777777777777777777777777777777777FFFFFFFF77
        77777777770000000077777777777788888888F7777777777099999999077777
        777778F77777778F77777777099999999990777777778F7777777778F7777770
        99999999999907777778F777777777778F7777090099009099099077778FFF77
        FF7F77FF78F77709BB09B09B09B09077778F88F78F78F78F78F7770998B0B0B0
        B0B09077778F7F8F8F8F8F8F78F777098B09B0B0B0BB0077778FF8F78F8F8F88
        F8F77708B099B0B0B0B0B077778F8F778F8F8F8F88F7770B0999B0B0B0B0B077
        7788FF778F8F8F8F88F77709BB0BBB0B09BB0077778F88F888F8F788F8F77709
        9999999999999077778F77777777777778F7777099999999999907777778F777
        777777778F777777099999999990777777778F7777777778F777777770999999
        99077777777778FFFFFFFF8F77777777770000000077777777777788888888F7
        7777777777777777777777777777777777777777777777777777777777777777
        77777777777777777777}
      NumGlyphs = 2
      OnClick = tbStopFindClick
    end
    object sbPrint: TToolbarButton97
      Left = 54
      Top = 2
      Width = 24
      Height = 27
      Hint = #1055#1072#1082#1077#1090#1085#1072#1103' '#1087#1077#1095#1072#1090#1100'|'
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        7700777777777777777777777777FFFFFFFFFF77770077770000000000077777
        77788888888888F77700777077777777707077777787FFFFFFFF8F8F77007700
        000000000007077778888888888888F8F700770777777BBB7700077778F77777
        77777888F7007707777778887707077778FFFFFFFFFFF878F700770000000000
        0007707778888888888888F78F007707777777777070707778FFFFFFFFFF8F8F
        8F0077700000000007070077778888888888F8F88F0077770FFFFFFFF0707077
        7778FFFFFFF78F8F8700777770F00000F000077777778F888887888877007777
        70FFFFFFFF07777777778FFFFFF778F777007777770F00000F077777777778F8
        888878F777007777770FFFFFFFF07777777778FFFFFFF78F7700777777700000
        00007777777777888888888F7700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      NumGlyphs = 2
      OnClick = sbPrintClick
    end
    object tbAnalizeFormat: TToolbarButton97
      Left = 78
      Top = 2
      Width = 25
      Height = 27
      AllowAllUp = True
      GroupIndex = 1
      Caption = '?'
    end
  end
  object DirNavigator: TvtDirNavigator
    IncludeFileFilter = '*.*'
    DirectoryFilter = '*.*'
    SrchFileAttr = [foNormalFiles, foReadOnlyFiles, foArchiveFiles]
    ExploreDirAttr = [foNormalDir, foReadOnlyDir, foArchiveDir, foSubDir]
    OnFound = DirNavigatorFound
    Left = 291
    Top = 2
  end
  object TextSearcher: TBMHFileSearch
    IgnoreCase = False
    OEMText = False
    OnFound = TextSearcherFound
    Left = 319
    Top = 2
  end
  object DOSFiler: Tl3DOSFiler
    TimeOut = 0
    Indicator.NeedProgressProc = True
    Indicator.OnProgressProc = TextSourceProgressProc
    Left = 261
    Top = 3
  end
  object TextSource: TevTextSource
    Indicator.NeedProgressProc = True
    Indicator.OnProgressProc = TextSourceProgressProc
    Left = 233
    Top = 3
  end
  object Reader: TevEvdReader
    Filer = DOSFiler
    Left = 205
    Top = 3
  end
end

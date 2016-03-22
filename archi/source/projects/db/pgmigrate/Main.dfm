object MainForm: TMainForm
  Left = 233
  Top = 223
  Width = 1305
  Height = 750
  Caption = 'Migrate to Postgres'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MigrateBtn: TButton
    Left = 42
    Top = 290
    Width = 161
    Height = 25
    Caption = 'Migrate !'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = MigrateBtnClick
  end
  object ReportMemo: TMemo
    Left = 15
    Top = 376
    Width = 306
    Height = 280
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 80
    Width = 418
    Height = 109
    Caption = ' Postgres '
    TabOrder = 2
    object Label1: TLabel
      Left = 25
      Top = 28
      Width = 26
      Height = 13
      Caption = 'Login'
    end
    object Label2: TLabel
      Left = 6
      Top = 55
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label3: TLabel
      Left = 216
      Top = 27
      Width = 31
      Height = 13
      Caption = 'Server'
    end
    object Label4: TLabel
      Left = 226
      Top = 49
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label6: TLabel
      Left = 3
      Top = 79
      Width = 79
      Height = 13
      Caption = 'Stored proc path'
    end
    object SpeedButton1: TSpeedButton
      Left = 383
      Top = 74
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
      OnClick = SpeedButton1Click
    end
    object edLogin: TEdit
      Left = 55
      Top = 24
      Width = 155
      Height = 21
      TabOrder = 0
      Text = 'edLogin'
    end
    object edPassword: TEdit
      Left = 55
      Top = 50
      Width = 155
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = 'edPassword'
    end
    object edServer: TEdit
      Left = 251
      Top = 23
      Width = 155
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
    object edPort: TvtSpinEdit
      Left = 252
      Top = 47
      Width = 70
      Height = 21
      MaxValue = 2000000.000000000000000000
      UseMinValue = False
      TabOrder = 3
    end
    object edStoredProcPath: TEdit
      Left = 91
      Top = 77
      Width = 290
      Height = 21
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 20
    Width = 418
    Height = 55
    Caption = ' HiTech '
    TabOrder = 3
    object Label5: TLabel
      Left = 6
      Top = 26
      Width = 70
      Height = 13
      Caption = 'Database path'
    end
    object btnSelectDir: TSpeedButton
      Left = 386
      Top = 21
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
    object edFamilyPath: TEdit
      Left = 84
      Top = 24
      Width = 300
      Height = 21
      TabOrder = 0
    end
  end
end

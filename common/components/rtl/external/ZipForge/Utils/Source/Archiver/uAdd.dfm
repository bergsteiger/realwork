object frmAdd: TfrmAdd
  Left = 317
  Top = 169
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Add'
  ClientHeight = 463
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 377
    Height = 417
    ActivePage = General
    TabOrder = 0
    object General: TTabSheet
      Caption = 'General'
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 68
        Height = 13
        Caption = 'Archive name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 128
        Width = 88
        Height = 13
        Caption = 'Compression level:'
      end
      object Label7: TLabel
        Left = 8
        Top = 336
        Width = 59
        Height = 13
        Caption = 'Zip64 mode:'
        Visible = False
      end
      object Label8: TLabel
        Left = 8
        Top = 256
        Width = 59
        Height = 13
        Caption = 'Volume size:'
      end
      object Label9: TLabel
        Left = 140
        Top = 312
        Width = 13
        Height = 13
        Alignment = taCenter
        Caption = 'Kb'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 48
        Top = 312
        Width = 23
        Height = 13
        Caption = 'Size:'
      end
      object cbArcName: TComboBox
        Left = 8
        Top = 40
        Width = 353
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object btnBrowse: TButton
        Left = 280
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = btnBrowseClick
      end
      object rgComprAlg: TRadioGroup
        Left = 8
        Top = 72
        Width = 161
        Height = 41
        Caption = 'Compression algorithm'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'BZIP'
          'PPM'
          'ZLIB')
        TabOrder = 2
        Visible = False
      end
      object cbComprLevel: TComboBox
        Left = 8
        Top = 144
        Width = 161
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 2
        TabOrder = 3
        Text = 'Normal'
        Items.Strings = (
          'None'
          'Fastest'
          'Normal'
          'Maximum')
      end
      object rgSpanMode: TRadioGroup
        Left = 8
        Top = 200
        Width = 161
        Height = 49
        Caption = 'Spanning Mode'
        Columns = 2
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          'Splitting'
          'Spanning')
        TabOrder = 4
      end
      object cbSpan: TCheckBox
        Left = 8
        Top = 176
        Width = 97
        Height = 17
        Caption = 'Span archive'
        TabOrder = 5
        OnClick = cbSpanClick
      end
      object gbArcOptions: TGroupBox
        Left = 200
        Top = 72
        Width = 161
        Height = 105
        Caption = 'Archiving Options'
        TabOrder = 6
        object cbDelete: TCheckBox
          Left = 8
          Top = 24
          Width = 145
          Height = 17
          Caption = 'Delete files after archiving'
          TabOrder = 0
        end
        object cbSFX: TCheckBox
          Left = 8
          Top = 48
          Width = 113
          Height = 17
          Caption = 'Create SFX archive'
          TabOrder = 1
        end
        object cbTestArc: TCheckBox
          Left = 8
          Top = 72
          Width = 105
          Height = 17
          Caption = 'Test archived files'
          TabOrder = 2
        end
      end
      object GroupBox1: TGroupBox
        Left = 200
        Top = 200
        Width = 161
        Height = 177
        Caption = 'Encryption'
        TabOrder = 7
        object Label3: TLabel
          Left = 10
          Top = 23
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object Label5: TLabel
          Left = 8
          Top = 120
          Width = 95
          Height = 13
          Caption = 'Encryption algorithm'
          Visible = False
        end
        object Label6: TLabel
          Left = 10
          Top = 71
          Width = 86
          Height = 13
          Caption = 'Reenter password'
        end
        object Pass: TEdit
          Left = 8
          Top = 44
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 0
          OnChange = PassChange
        end
        object cbEncrypt: TComboBox
          Left = 8
          Top = 140
          Width = 145
          Height = 21
          Style = csDropDownList
          Enabled = False
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'Blowfish'
          Visible = False
          Items.Strings = (
            'Blowfish'
            'DES Single'
            'DES Triple'
            'Rijndael 128'
            'Rijndael 256'
            'Square'
            'Twofish 128'
            'Twofish 256')
        end
        object Pass2: TEdit
          Left = 8
          Top = 92
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          OnChange = PassChange
        end
      end
      object cbZip64: TComboBox
        Left = 8
        Top = 352
        Width = 161
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 8
        Text = 'Auto'
        Visible = False
        Items.Strings = (
          'Disabled'
          'Auto'
          'Always')
      end
      object cbVolumeSize: TComboBox
        Left = 8
        Top = 272
        Width = 161
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        TabOrder = 9
        OnChange = cbVolumeSizeChange
        Items.Strings = (
          'AutoDetect'
          'Floppy'
          '100 Mb'
          '200 Mb'
          '250 Mb'
          '600 Mb'
          '650 Mb'
          '700 Mb'
          'Custom')
      end
      object edCustomSize: TEdit
        Left = 80
        Top = 304
        Width = 57
        Height = 21
        Enabled = False
        TabOrder = 10
        Text = '1024'
      end
    end
    object Comment: TTabSheet
      Caption = 'Comment'
      ImageIndex = 1
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Enter a comment:'
      end
      object reComment: TMemo
        Left = 8
        Top = 40
        Width = 353
        Height = 313
        TabOrder = 0
      end
    end
  end
  object btnOK: TBitBtn
    Left = 224
    Top = 432
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancel: TBitBtn
    Left = 312
    Top = 432
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object SaveDialog1: TSaveDialog
    Title = 'Save/Open archive'
    Left = 20
    Top = 432
  end
end

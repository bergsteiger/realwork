object Form1: TForm1
  Left = 192
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Security'
  ClientHeight = 461
  ClientWidth = 361
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 6
    Top = 41
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label14: TLabel
    Left = 6
    Top = 70
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object Label75: TLabel
    Left = 149
    Top = 8
    Width = 57
    Height = 16
    Caption = 'Security'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object gbEncryption: TGroupBox
    Left = 5
    Top = 100
    Width = 352
    Height = 328
    TabOrder = 0
    object lblConfirmOwnerPswd: TLabel
      Left = 18
      Top = 52
      Width = 121
      Height = 13
      Caption = 'Confirm Owner Password:'
    end
    object lblUserPswd: TLabel
      Left = 18
      Top = 81
      Width = 74
      Height = 13
      Caption = 'User Password:'
    end
    object lblConfirmUserPswd: TLabel
      Left = 18
      Top = 111
      Width = 112
      Height = 13
      Caption = 'Confirm User Password:'
    end
    object lblOwnerPswd: TLabel
      Left = 18
      Top = 21
      Width = 83
      Height = 13
      Caption = 'Owner Password:'
    end
    object rgEncryptionLevel: TRadioGroup
      Left = 16
      Top = 134
      Width = 321
      Height = 42
      Caption = ' Encryption Level '
      Columns = 2
      Enabled = False
      Items.Strings = (
        '40 Bit'
        '128 Bit')
      TabOrder = 0
    end
    object gbUserPermissions: TGroupBox
      Left = 16
      Top = 179
      Width = 321
      Height = 119
      Caption = ' User Permissions '
      TabOrder = 1
      object chklstUserPermissions: TCheckListBox
        Left = 11
        Top = 18
        Width = 301
        Height = 93
        Enabled = False
        ItemHeight = 13
        Items.Strings = (
          'Print'
          'Modify'
          'Copy'
          'Annotation'
          'Formfill'
          'Accessibilty'
          'Document assembly'
          'High resolution printing')
        TabOrder = 0
      end
    end
    object edtOwnerPassword: TEdit
      Left = 165
      Top = 16
      Width = 172
      Height = 21
      Enabled = False
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtConfirmOwnerPassword: TEdit
      Left = 165
      Top = 47
      Width = 172
      Height = 21
      Enabled = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object edtUserPassword: TEdit
      Left = 165
      Top = 78
      Width = 172
      Height = 21
      Enabled = False
      PasswordChar = '*'
      TabOrder = 4
    end
    object edtConfirmUserPassword: TEdit
      Left = 165
      Top = 109
      Width = 172
      Height = 21
      Enabled = False
      PasswordChar = '*'
      TabOrder = 5
    end
    object btnSetEncryption: TButton
      Left = 266
      Top = 302
      Width = 71
      Height = 21
      Caption = 'Set'
      Enabled = False
      TabOrder = 6
      OnClick = btnSetEncryptionClick
    end
  end
  object chkEnableEncryption: TCheckBox
    Left = 24
    Top = 95
    Width = 108
    Height = 17
    Caption = 'Encrypt Document'
    TabOrder = 1
    OnClick = chkEnableEncryptionClick
  end
  object edPDFfilename: TEdit
    Left = 58
    Top = 35
    Width = 206
    Height = 21
    TabOrder = 2
  end
  object edSavePDFTo: TEdit
    Left = 57
    Top = 67
    Width = 206
    Height = 21
    TabOrder = 3
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 266
    Top = 67
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = btnSaveFileNameClick
  end
  object btnLoadPDF: TButton
    Left = 266
    Top = 35
    Width = 89
    Height = 22
    Caption = 'Load Document'
    TabOrder = 5
    OnClick = btnLoadPDFClick
  end
  object btnSave: TButton
    Left = 280
    Top = 430
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnReset: TButton
    Left = 5
    Top = 430
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 7
    OnClick = btnResetClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 161
    Top = 434
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 8
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.0'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 276
    Top = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 236
    Top = 5
  end
  object SaveDialog1: TSaveDialog
    Left = 312
    Top = 64
  end
end

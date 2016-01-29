object frmMain: TfrmMain
  Left = 219
  Top = 77
  Width = 564
  Height = 569
  AutoScroll = True
  Caption = 'Add Digital Signature'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbInputFile: TLabel
    Left = 11
    Top = 11
    Width = 43
    Height = 13
    Caption = 'Input File'
  end
  object lbOutPutFile: TLabel
    Left = 11
    Top = 37
    Width = 48
    Height = 13
    Caption = 'OutputFile'
  end
  object gbSigProps: TGroupBox
    Left = 8
    Top = 154
    Width = 542
    Height = 152
    Caption = 'Signature Properties'
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 6
    object lbReason: TLabel
      Left = 9
      Top = 103
      Width = 37
      Height = 13
      Caption = 'Reason'
    end
    object lbLocation: TLabel
      Left = 10
      Top = 56
      Width = 41
      Height = 13
      Caption = 'Location'
    end
    object Label5: TLabel
      Left = 11
      Top = 80
      Width = 37
      Height = 13
      Caption = 'Contact'
    end
    object lbPFXFileName: TLabel
      Left = 9
      Top = 28
      Width = 36
      Height = 13
      Caption = 'PFXFile'
    end
    object lbPassword: TLabel
      Left = 278
      Top = 30
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object lbAppearanceText: TLabel
      Left = 278
      Top = 55
      Width = 91
      Height = 18
      Caption = 'Appearance Text'
    end
    object lbSelectFont: TLabel
      Left = 372
      Top = 95
      Width = 21
      Height = 13
      Caption = 'Font'
    end
    object Label7: TLabel
      Left = 439
      Top = 95
      Width = 87
      Height = 13
      Caption = 'BackGround Color'
    end
    object edPFXFileName: TEdit
      Left = 62
      Top = 25
      Width = 179
      Height = 21
      TabOrder = 0
    end
    object btnLoadPFXFile: TButton
      Left = 247
      Top = 23
      Width = 25
      Height = 23
      Caption = '...'
      TabOrder = 1
      OnClick = btnLoadPFXFileClick
    end
    object edPassword: TEdit
      Left = 330
      Top = 25
      Width = 188
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object edReason: TEdit
      Left = 62
      Top = 99
      Width = 179
      Height = 21
      TabOrder = 3
    end
    object edLocation: TEdit
      Left = 62
      Top = 52
      Width = 179
      Height = 21
      TabOrder = 4
    end
    object edContactInfo: TEdit
      Left = 62
      Top = 74
      Width = 179
      Height = 21
      TabOrder = 5
    end
    object cbTime: TCheckBox
      Left = 11
      Top = 126
      Width = 134
      Height = 17
      Caption = 'Sign with current time'
      TabOrder = 6
    end
    object cbName: TCheckBox
      Left = 280
      Top = 72
      Width = 97
      Height = 17
      Caption = 'Name'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object cbReason: TCheckBox
      Left = 280
      Top = 90
      Width = 67
      Height = 17
      Caption = 'Reason'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object cbLocation: TCheckBox
      Left = 280
      Top = 108
      Width = 67
      Height = 17
      Caption = 'Location'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object cbDate: TCheckBox
      Left = 280
      Top = 128
      Width = 67
      Height = 17
      Caption = 'Date'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object btnFont: TButton
      Left = 372
      Top = 114
      Width = 37
      Height = 25
      Caption = '...'
      TabOrder = 11
      OnClick = btnFontClick
    end
    object cbLabels: TCheckBox
      Left = 353
      Top = 72
      Width = 56
      Height = 17
      Caption = 'Labels'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object ColorBox1: TColorBox
      Left = 439
      Top = 114
      Width = 70
      Height = 22
      Selected = clWhite
      Color = clWhite
      ItemHeight = 16
      TabOrder = 13
    end
  end
  object btnAction: TButton
    Left = 8
    Top = 500
    Width = 97
    Height = 25
    Caption = 'Sign'
    TabOrder = 0
    OnClick = btnActionClick
  end
  object edInputFile: TEdit
    Left = 75
    Top = 8
    Width = 442
    Height = 21
    TabOrder = 1
    OnExit = edInputFileExit
  end
  object btnLoadFile: TButton
    Left = 523
    Top = 6
    Width = 25
    Height = 23
    Caption = '...'
    TabOrder = 2
    OnClick = btnLoadFileClick
  end
  object edOutPutFile: TEdit
    Left = 75
    Top = 35
    Width = 442
    Height = 21
    TabOrder = 3
  end
  object btnLoadOutputFile: TButton
    Left = 523
    Top = 34
    Width = 25
    Height = 24
    Caption = '...'
    TabOrder = 4
    OnClick = btnLoadOutputFileClick
  end
  object cbOpenAfterSave: TCheckBox
    Left = 8
    Top = 477
    Width = 97
    Height = 17
    Caption = 'Open after save'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object gbFieldProps: TGroupBox
    Left = 7
    Top = 312
    Width = 279
    Height = 147
    Caption = 'Field Properties'
    TabOrder = 7
    object lbFieldname: TLabel
      Left = 8
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Fieldname'
    end
    object lbPageNo: TLabel
      Left = 8
      Top = 52
      Width = 46
      Height = 13
      Caption = 'PageNo#'
    end
    object Label1: TLabel
      Left = 14
      Top = 93
      Width = 18
      Height = 13
      Caption = 'Left'
    end
    object Label2: TLabel
      Left = 93
      Top = 93
      Width = 19
      Height = 13
      Caption = 'Top'
    end
    object Label3: TLabel
      Left = 12
      Top = 123
      Width = 25
      Height = 13
      Caption = 'Right'
    end
    object Label4: TLabel
      Left = 91
      Top = 118
      Width = 33
      Height = 13
      Caption = 'Bottom'
    end
    object edFieldName: TEdit
      Left = 62
      Top = 17
      Width = 129
      Height = 21
      TabOrder = 0
    end
    object cbPageNo: TComboBox
      Left = 62
      Top = 44
      Width = 131
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object cbSetPos: TCheckBox
      Left = 11
      Top = 70
      Width = 137
      Height = 17
      Caption = 'Set signature position'
      TabOrder = 2
      OnClick = cbSetPosClick
    end
    object edRectLeft: TEdit
      Left = 43
      Top = 87
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edRectTop: TEdit
      Left = 130
      Top = 87
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object edRectRight: TEdit
      Left = 43
      Top = 113
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object edRectBotton: TEdit
      Left = 130
      Top = 113
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 6
    end
  end
  object gbFieldFill: TGroupBox
    Left = 292
    Top = 312
    Width = 256
    Height = 147
    Caption = 'Select field to fill'
    TabOrder = 8
    object lbField: TLabel
      Left = 12
      Top = 29
      Width = 50
      Height = 13
      Caption = 'FieldName'
    end
    object cbFieldName: TComboBox
      Left = 68
      Top = 24
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object rgOptions: TRadioGroup
    Left = 6
    Top = 60
    Width = 542
    Height = 89
    Caption = 'Select Operation'
    Items.Strings = (
      'Add Signature'
      'Insert blank signature field'
      'Fill blank signature field')
    TabOrder = 9
    OnClick = rgOptionsClick
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.4'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 520
    Top = 512
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 512
    Top = 96
  end
end

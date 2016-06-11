object InetCertFilesWizardFrame: TInetCertFilesWizardFrame
  Left = 0
  Top = 0
  Width = 474
  Height = 232
  Anchors = [akLeft, akTop, akRight]
  TabOrder = 0
  DesignSize = (
    474
    232)
  object LabelCertFile: TLabel
    Left = 0
    Top = 1
    Width = 100
    Height = 13
    Caption = 'Certificate file name:'
    FocusControl = CertFileEdit
  end
  object LabelKeyFile: TLabel
    Left = 0
    Top = 47
    Width = 68
    Height = 13
    Caption = 'Key file name:'
    FocusControl = KeyFileEdit
  end
  object LabelRootCertFile: TLabel
    Left = 0
    Top = 138
    Width = 124
    Height = 13
    Caption = 'Root certificate file name:'
    FocusControl = RootCertFileEdit
  end
  object LabelKeyFilePassword: TLabel
    Left = 0
    Top = 92
    Width = 88
    Height = 13
    Caption = 'Key file password:'
    FocusControl = KeyPasswordEdit
  end
  object CertFileEdit: TEdit
    Left = 0
    Top = 20
    Width = 443
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object BrowseCertFileBtn: TButton
    Left = 449
    Top = 20
    Width = 22
    Height = 22
    Hint = 'Open|Opens an existing file'
    Anchors = [akTop, akRight]
    Caption = '...'
    ImageIndex = 7
    TabOrder = 1
    OnClick = BrowseCertFileBtnClick
  end
  object KeyFileEdit: TEdit
    Left = 0
    Top = 65
    Width = 443
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object RootCertFileEdit: TEdit
    Left = 0
    Top = 157
    Width = 443
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
  end
  object BrowseKeyFileBtn: TButton
    Left = 449
    Top = 65
    Width = 22
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 3
    OnClick = BrowseKeyFileBtnClick
  end
  object BrowseRootCertFileBtn: TButton
    Left = 449
    Top = 157
    Width = 22
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 6
    OnClick = BrowseRootCertFileBtnClick
  end
  object KeyPasswordEdit: TEdit
    Left = 0
    Top = 111
    Width = 225
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
  end
  object ButtonTest: TButton
    Left = 396
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Test'
    TabOrder = 7
    OnClick = ButtonTestClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.pem'
    Filter = 'PEM File(*.pem)|*.pem|Any file (*.*)|*.*'
    FilterIndex = 0
    Left = 360
    Top = 96
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 264
    Top = 104
  end
end

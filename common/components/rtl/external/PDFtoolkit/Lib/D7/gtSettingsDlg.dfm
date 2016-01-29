object gtPDFSettingsDlg: TgtPDFSettingsDlg
  Left = 374
  Top = 187
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Document Settings and Preferences'
  ClientHeight = 449
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 201
    Top = 416
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 281
    Top = 416
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pcSettings: TPageControl
    Left = 0
    Top = 0
    Width = 366
    Height = 409
    ActivePage = tsDocInfo
    TabOrder = 2
    object tsDocInfo: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      object gbGeneral: TGroupBox
        Left = 8
        Top = 8
        Width = 341
        Height = 363
        TabOrder = 0
        object chkOpenAfterSave: TCheckBox
          Left = 8
          Top = 253
          Width = 129
          Height = 17
          Caption = 'Open After Save'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object gbDocInfo: TGroupBox
          Left = 8
          Top = 4
          Width = 325
          Height = 241
          Caption = ' Document Information '
          TabOrder = 0
          object lblCreator: TLabel
            Left = 35
            Top = 134
            Width = 49
            Height = 13
            Caption = 'Creator:'
          end
          object lblProducer: TLabel
            Left = 27
            Top = 158
            Width = 56
            Height = 13
            Caption = 'Producer:'
          end
          object lblPDFVer: TLabel
            Left = 9
            Top = 183
            Width = 74
            Height = 13
            Caption = 'PDF Version:'
          end
          object lblNoOfPages: TLabel
            Left = 6
            Top = 208
            Width = 77
            Height = 13
            Caption = 'No. of Pages:'
          end
          object lblTitle: TLabel
            Left = 55
            Top = 28
            Width = 29
            Height = 13
            Caption = 'Title:'
          end
          object lblDocSubject: TLabel
            Left = 36
            Top = 53
            Width = 48
            Height = 13
            Caption = 'Subject:'
          end
          object lblAuthor: TLabel
            Left = 41
            Top = 81
            Width = 43
            Height = 13
            Caption = 'Author:'
          end
          object lblKeywords: TLabel
            Left = 23
            Top = 109
            Width = 61
            Height = 13
            Caption = 'Keywords:'
          end
          object edtCreator: TEdit
            Left = 86
            Top = 130
            Width = 233
            Height = 21
            Color = clInactiveCaptionText
            ReadOnly = True
            TabOrder = 0
          end
          object edtProducer: TEdit
            Left = 86
            Top = 154
            Width = 233
            Height = 21
            Color = clInactiveCaptionText
            ReadOnly = True
            TabOrder = 1
          end
          object edtVersion: TEdit
            Left = 86
            Top = 179
            Width = 233
            Height = 21
            Color = clInactiveCaptionText
            ReadOnly = True
            TabOrder = 2
          end
          object edtNoPages: TEdit
            Left = 86
            Top = 204
            Width = 233
            Height = 21
            Color = clInactiveCaptionText
            ReadOnly = True
            TabOrder = 3
          end
          object edtTitle: TEdit
            Left = 86
            Top = 24
            Width = 233
            Height = 21
            TabOrder = 4
          end
          object edtDocSubject: TEdit
            Left = 86
            Top = 51
            Width = 233
            Height = 21
            TabOrder = 5
          end
          object edtAuthor: TEdit
            Left = 86
            Top = 78
            Width = 233
            Height = 21
            TabOrder = 6
          end
          object edtKeywords: TEdit
            Left = 86
            Top = 104
            Width = 233
            Height = 21
            TabOrder = 7
          end
        end
      end
    end
    object tsSecurity: TTabSheet
      Caption = 'Security'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbEncryption: TGroupBox
        Left = 8
        Top = 8
        Width = 340
        Height = 362
        TabOrder = 1
        object lblConfirmOwnerPswd: TLabel
          Left = 7
          Top = 51
          Width = 150
          Height = 13
          Caption = 'Confirm Owner Password:'
        end
        object lblUserPswd: TLabel
          Left = 68
          Top = 80
          Width = 89
          Height = 13
          Caption = 'User Password:'
        end
        object lblConfirmUserPswd: TLabel
          Left = 18
          Top = 110
          Width = 139
          Height = 13
          Caption = 'Confirm User Password:'
        end
        object lblOwnerPswd: TLabel
          Left = 57
          Top = 20
          Width = 100
          Height = 13
          Caption = 'Owner Password:'
        end
        object rgEncryptionLevel: TRadioGroup
          Left = 9
          Top = 133
          Width = 321
          Height = 49
          Caption = ' Encryption Level '
          Columns = 2
          Enabled = False
          TabOrder = 0
        end
        object gbUserPermissions: TGroupBox
          Left = 9
          Top = 186
          Width = 321
          Height = 121
          Caption = ' User Permissions '
          TabOrder = 1
          object chklstUserPermissions: TCheckListBox
            Left = 10
            Top = 22
            Width = 301
            Height = 85
            Enabled = False
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object edtOwnerPassword: TEdit
          Left = 158
          Top = 15
          Width = 172
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtConfirmOwnerPassword: TEdit
          Left = 158
          Top = 46
          Width = 172
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
        object edtUserPassword: TEdit
          Left = 158
          Top = 77
          Width = 172
          Height = 21
          PasswordChar = '*'
          TabOrder = 4
        end
        object edtConfirmUserPassword: TEdit
          Left = 158
          Top = 108
          Width = 172
          Height = 21
          PasswordChar = '*'
          TabOrder = 5
        end
      end
      object chkEnableEncryption: TCheckBox
        Left = 17
        Top = -4
        Width = 122
        Height = 25
        Caption = 'Encrypt Document'
        TabOrder = 0
        OnClick = chkEnableEncryptionClick
      end
    end
    object tsView: TTabSheet
      Caption = 'View'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 341
        Height = 361
        TabOrder = 0
        object lblPageLayout: TLabel
          Left = 11
          Top = 5
          Width = 75
          Height = 13
          Caption = 'Page Layout:'
        end
        object lblPageMode: TLabel
          Left = 176
          Top = 5
          Width = 67
          Height = 13
          Caption = 'Page Mode:'
        end
        object cbPageLayout: TComboBox
          Left = 11
          Top = 20
          Width = 156
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = cbPageLayoutChange
        end
        object cbPageMode: TComboBox
          Left = 176
          Top = 20
          Width = 156
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
        object gbPresentationMode: TGroupBox
          Left = 11
          Top = 48
          Width = 321
          Height = 177
          Caption = ' Presentation Mode '
          TabOrder = 2
          object lblPageTransitionEffect: TLabel
            Left = 12
            Top = 22
            Width = 129
            Height = 13
            Caption = 'Page Transition Effect:'
          end
          object lblSecs: TLabel
            Left = 230
            Top = 54
            Width = 25
            Height = 13
            Caption = 'secs'
          end
          object lblPageTransitionDur: TLabel
            Left = 27
            Top = 50
            Width = 114
            Height = 13
            Caption = 'Transition Duration:'
          end
          object cbPageTransitionEffect: TComboBox
            Left = 143
            Top = 18
            Width = 167
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
            OnChange = cbPageTransitionEffectChange
          end
          object edtDur: TEdit
            Left = 143
            Top = 46
            Width = 82
            Height = 21
            TabOrder = 1
            OnKeyPress = edtDurKeyPress
          end
          object gbPresentationPageRange: TGroupBox
            Left = 12
            Top = 75
            Width = 298
            Height = 91
            Caption = ' Presentation Page Range '
            TabOrder = 2
            object lblPageExample: TLabel
              Left = 13
              Top = 38
              Width = 200
              Height = 39
              Caption = 
                'Enter page numbers and/or page ranges separated by commas. For e' +
                'xample, 1,3,5-12'
              WordWrap = True
            end
            object rbAllPages: TRadioButton
              Left = 10
              Top = 22
              Width = 113
              Height = 17
              Caption = 'All Pages'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rbAllPagesClick
            end
            object rbPages: TRadioButton
              Left = 106
              Top = 21
              Width = 71
              Height = 17
              Caption = 'Pages:'
              TabOrder = 1
              TabStop = True
              OnClick = rbPagesClick
            end
            object edtPresentationPages: TEdit
              Left = 185
              Top = 19
              Width = 96
              Height = 21
              TabOrder = 2
              OnKeyPress = edtPresentationPagesKeyPress
            end
          end
        end
        object gbViewerPreferences: TGroupBox
          Left = 11
          Top = 228
          Width = 321
          Height = 121
          Caption = ' Viewer Preferences '
          TabOrder = 3
          object chklstViewerPreferences: TCheckListBox
            Left = 12
            Top = 22
            Width = 296
            Height = 85
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
    end
    object tsEmailDoc: TTabSheet
      Caption = 'Email'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 340
        Height = 362
        TabOrder = 0
        object gbConnection: TGroupBox
          Left = 6
          Top = 11
          Width = 329
          Height = 86
          TabOrder = 0
          object lblHost: TLabel
            Left = 35
            Top = 17
            Width = 34
            Height = 13
            Caption = 'Host: '
          end
          object lblUserID: TLabel
            Left = 20
            Top = 40
            Width = 49
            Height = 13
            Caption = 'UserID: '
          end
          object lblPassword: TLabel
            Left = 6
            Top = 64
            Width = 63
            Height = 13
            Caption = 'Password: '
          end
          object edtUserID: TEdit
            Left = 69
            Top = 36
            Width = 250
            Height = 21
            TabOrder = 1
          end
          object edtHost: TEdit
            Left = 69
            Top = 13
            Width = 250
            Height = 21
            TabOrder = 0
          end
          object edtPassword: TEdit
            Left = 69
            Top = 60
            Width = 250
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
        end
        object gbAddresses: TGroupBox
          Left = 6
          Top = 102
          Width = 329
          Height = 104
          TabOrder = 1
          object lblTo: TLabel
            Left = 46
            Top = 34
            Width = 23
            Height = 13
            Caption = 'To: '
          end
          object lblCC: TLabel
            Left = 42
            Top = 58
            Width = 27
            Height = 13
            Caption = 'CC: '
          end
          object lblBCC: TLabel
            Left = 34
            Top = 82
            Width = 35
            Height = 13
            Caption = 'BCC: '
          end
          object lblFrom: TLabel
            Left = 31
            Top = 10
            Width = 38
            Height = 13
            Caption = 'From: '
          end
          object edtTo: TEdit
            Left = 70
            Top = 30
            Width = 250
            Height = 21
            TabOrder = 1
          end
          object edtCC: TEdit
            Left = 70
            Top = 54
            Width = 250
            Height = 21
            TabOrder = 2
          end
          object edtBCC: TEdit
            Left = 70
            Top = 78
            Width = 250
            Height = 21
            TabOrder = 3
          end
          object edtFrom: TEdit
            Left = 70
            Top = 6
            Width = 250
            Height = 21
            TabOrder = 0
          end
        end
        object gbMessage: TGroupBox
          Left = 6
          Top = 211
          Width = 329
          Height = 142
          TabOrder = 2
          object lblMessage: TLabel
            Left = 8
            Top = 31
            Width = 54
            Height = 13
            Caption = 'Message:'
          end
          object lblSubject: TLabel
            Left = 8
            Top = 9
            Width = 52
            Height = 13
            Caption = 'Subject: '
          end
          object memoBody: TMemo
            Left = 8
            Top = 48
            Width = 313
            Height = 86
            TabOrder = 1
          end
          object edtSubject: TEdit
            Left = 70
            Top = 5
            Width = 250
            Height = 21
            TabOrder = 0
          end
        end
      end
      object chkEmailAfterSave: TCheckBox
        Left = 20
        Top = -1
        Width = 116
        Height = 17
        Caption = 'Email After Save'
        TabOrder = 1
        OnClick = chkEmailAfterSaveClick
      end
    end
    object tsCompress: TTabSheet
      Caption = 'Compress'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbComp: TGroupBox
        Left = 8
        Top = 8
        Width = 340
        Height = 364
        TabOrder = 0
        object gbCompType: TGroupBox
          Left = 11
          Top = 15
          Width = 268
          Height = 62
          TabOrder = 0
          object lblCompType: TLabel
            Left = 10
            Top = 11
            Width = 107
            Height = 13
            Caption = 'Compression Type'
          end
          object lblCompLevel: TLabel
            Left = 10
            Top = 37
            Width = 109
            Height = 13
            Caption = 'Compression Level'
          end
          object cbCompType: TComboBox
            Left = 138
            Top = 7
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
            OnChange = cbCompTypeChange
          end
          object cbCompLevel: TComboBox
            Left = 138
            Top = 33
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 1
          end
        end
      end
      object chkCompressDoc: TCheckBox
        Left = 18
        Top = 0
        Width = 137
        Height = 17
        Caption = 'Compress Document'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = chkCompressDocClick
      end
    end
  end
end

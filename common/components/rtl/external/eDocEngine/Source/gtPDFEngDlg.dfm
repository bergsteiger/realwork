inherited gtPDFEngineDlg: TgtPDFEngineDlg
  Caption = 'gtPDFEngineDlg'
  ClientWidth = 492
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TButton
    Left = 326
  end
  inherited btnCancel: TButton
    Left = 408
  end
  inherited pnlDocDlg: TPanel
    Width = 475
    inherited Panel2: TPanel
      Width = 350
      inherited Panel3: TPanel
        Width = 350
      end
      inherited pcDocument: TPageControl
        Width = 350
        ActivePage = tsDigitalSign
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            Width = 329
            inherited gbPageRange: TGroupBox
              Width = 313
            end
            inherited chkActiveHyperLinks: TCheckBox
              TabOrder = 5
            end
            object rgpEmbedTrueTypeFonts: TRadioGroup
              Left = 8
              Top = 168
              Width = 310
              Height = 41
              Caption = 'Embed Used TrueType Fonts'
              Columns = 3
              Items.Strings = (
                'None'
                'Full'
                'Subset')
              TabOrder = 4
            end
          end
        end
        inherited tsContent: TTabSheet
          inherited gbContentOptions: TGroupBox
            Width = 329
            inherited gbItemsToRender: TGroupBox
              Width = 313
            end
            inherited gbDocInfo: TGroupBox
              Width = 313
            end
          end
        end
        inherited tsBackground: TTabSheet
          inherited gbBackground: TGroupBox
            Width = 329
          end
        end
        object tsPDFAdvanced: TTabSheet [3]
          Caption = 'Advanced'
          ImageIndex = 3
          TabVisible = False
          DesignSize = (
            342
            385)
          object gbPDFOptions: TGroupBox
            Left = 8
            Top = 0
            Width = 329
            Height = 372
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            object lblFontEncoding: TLabel
              Left = 8
              Top = 327
              Width = 84
              Height = 13
              Caption = 'Font Encoding:'
            end
            object gbEncryption: TGroupBox
              Left = 8
              Top = 62
              Width = 313
              Height = 255
              TabOrder = 3
              object lblOwnerPassword: TLabel
                Left = 8
                Top = 20
                Width = 100
                Height = 13
                Caption = 'Owner Password:'
              end
              object lblConfirmOwnerPassword: TLabel
                Left = 8
                Top = 44
                Width = 150
                Height = 13
                Caption = 'Confirm Owner Password:'
              end
              object lblUserPassword: TLabel
                Left = 8
                Top = 68
                Width = 89
                Height = 13
                Caption = 'User Password:'
              end
              object lblConfirmUserPassword: TLabel
                Left = 8
                Top = 92
                Width = 139
                Height = 13
                Caption = 'Confirm User Password:'
              end
              object lblEncryptionLevel: TLabel
                Left = 8
                Top = 116
                Width = 35
                Height = 13
                Caption = 'Level:'
              end
              object edOwnerPassword: TEdit
                Left = 168
                Top = 16
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 0
              end
              object edConfirmOwnerPassword: TEdit
                Left = 168
                Top = 40
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 1
                OnExit = edConfirmPasswordExit
              end
              object gbUserPermissions: TGroupBox
                Left = 8
                Top = 136
                Width = 293
                Height = 113
                Caption = 'User Permissions'
                Enabled = False
                TabOrder = 5
                object chkPrint: TCheckBox
                  Left = 7
                  Top = 65
                  Width = 51
                  Height = 17
                  Caption = 'Print'
                  TabOrder = 2
                end
                object chkModify: TCheckBox
                  Left = 7
                  Top = 41
                  Width = 64
                  Height = 17
                  Caption = 'Modify'
                  TabOrder = 1
                end
                object chkCopy: TCheckBox
                  Left = 7
                  Top = 17
                  Width = 58
                  Height = 17
                  Caption = 'Copy'
                  TabOrder = 0
                end
                object chkAnnotation: TCheckBox
                  Left = 144
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = 'Annotation'
                  TabOrder = 4
                end
                object chkFormFill: TCheckBox
                  Left = 7
                  Top = 88
                  Width = 97
                  Height = 17
                  Caption = 'Form Fill'
                  TabOrder = 3
                end
                object chkAccessibility: TCheckBox
                  Left = 144
                  Top = 40
                  Width = 97
                  Height = 17
                  Caption = 'Accessibility'
                  TabOrder = 5
                end
                object chkDocumentAssembly: TCheckBox
                  Left = 144
                  Top = 64
                  Width = 145
                  Height = 17
                  Caption = 'Document Assembly'
                  TabOrder = 6
                end
                object chkHighResolutionPrint: TCheckBox
                  Left = 144
                  Top = 88
                  Width = 145
                  Height = 17
                  Caption = 'High Resolution Print'
                  TabOrder = 7
                end
              end
              object edUserPassword: TEdit
                Left = 168
                Top = 64
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 2
              end
              object edConfirmUserPassword: TEdit
                Left = 168
                Top = 88
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 3
                OnExit = edConfirmPasswordExit
              end
              object cbEncryptionLevel: TComboBox
                Left = 168
                Top = 112
                Width = 133
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 4
                OnChange = cbEncryptionLevelChange
              end
            end
            object gbUseCompression: TGroupBox
              Left = 8
              Top = 8
              Width = 313
              Height = 47
              TabOrder = 1
              object lblCompressionLevel: TLabel
                Left = 8
                Top = 20
                Width = 114
                Height = 13
                Caption = 'Compression Level:'
              end
              object cbCompressionLevel: TComboBox
                Left = 168
                Top = 16
                Width = 133
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 0
              end
            end
            object chkCompressDocument: TCheckBox
              Left = 15
              Top = 7
              Width = 146
              Height = 17
              Caption = 'Compress Document'
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = chkCompressDocumentClick
            end
            object cbEncoding: TComboBox
              Left = 168
              Top = 323
              Width = 133
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 4
            end
            object chkEnableEncryption: TCheckBox
              Left = 16
              Top = 60
              Width = 137
              Height = 17
              Caption = 'Encrypt Document'
              TabOrder = 2
              OnClick = chkEnableEncryptionClick
            end
          end
        end
        object tsViewerPreferences: TTabSheet [4]
          Caption = 'Viewer Preferences'
          ImageIndex = 4
          TabVisible = False
          object gbViewerPreferences: TGroupBox
            Left = 8
            Top = 0
            Width = 329
            Height = 372
            TabOrder = 0
            object lblPageLayout: TLabel
              Left = 8
              Top = 16
              Width = 75
              Height = 13
              Caption = 'Page Layout:'
            end
            object lblPageMode: TLabel
              Left = 168
              Top = 16
              Width = 67
              Height = 13
              Caption = 'Page Mode:'
            end
            object cbPageLayout: TComboBox
              Left = 8
              Top = 32
              Width = 153
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 0
            end
            object cbPageMode: TComboBox
              Left = 168
              Top = 32
              Width = 149
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 1
            end
            object gbHideUIElements: TGroupBox
              Left = 8
              Top = 61
              Width = 309
              Height = 58
              Caption = 'Hide Viewer Interface Elements'
              TabOrder = 2
              object chkMenuBar: TCheckBox
                Left = 8
                Top = 16
                Width = 97
                Height = 17
                Caption = 'Menu Bar'
                TabOrder = 0
              end
              object chkToolBar: TCheckBox
                Left = 161
                Top = 16
                Width = 97
                Height = 17
                Caption = 'Toolbars'
                TabOrder = 1
              end
              object chkNavigationControls: TCheckBox
                Left = 8
                Top = 35
                Width = 145
                Height = 17
                Caption = 'Navigation Controls'
                TabOrder = 2
              end
            end
            object gbPresentationMode: TGroupBox
              Left = 8
              Top = 123
              Width = 309
              Height = 66
              Caption = 'Presentation Mode'
              TabOrder = 3
              object lblPageTransitionEffect: TLabel
                Left = 8
                Top = 16
                Width = 129
                Height = 13
                Caption = 'Page Transition Effect:'
              end
              object lblPageTransitionDuration: TLabel
                Left = 8
                Top = 41
                Width = 146
                Height = 13
                Caption = 'Page Transition Duration:'
              end
              object lblSecs: TLabel
                Left = 274
                Top = 45
                Width = 27
                Height = 13
                Caption = 'Secs'
              end
              object edPageTransitionDuration: TEdit
                Left = 160
                Top = 37
                Width = 109
                Height = 21
                TabOrder = 1
              end
              object cbPageTransitionEffect: TComboBox
                Left = 160
                Top = 12
                Width = 141
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 0
                OnChange = cbPageTransitionEffectChange
              end
            end
          end
        end
        object tsDigitalSign: TTabSheet [5]
          Caption = 'Digital Signature'
          ImageIndex = 6
          TabVisible = False
          DesignSize = (
            342
            385)
          object gbDigitalSign: TGroupBox
            Left = 3
            Top = 6
            Width = 336
            Height = 376
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
            object pgPropertyControl: TPageControl
              Left = 8
              Top = 16
              Width = 321
              Height = 353
              ActivePage = pgtFieldProperties
              TabOrder = 0
              object pgtFieldProperties: TTabSheet
                Caption = 'Field Properties'
                object lblSigFieldName: TLabel
                  Left = 8
                  Top = 35
                  Width = 68
                  Height = 13
                  Caption = 'Field Name:'
                end
                object edSigFieldName: TEdit
                  Left = 117
                  Top = 33
                  Width = 133
                  Height = 21
                  TabOrder = 0
                  OnKeyPress = edSigFieldNameKeyPress
                end
                object gbSigFieldPos: TGroupBox
                  Left = 8
                  Top = 68
                  Width = 296
                  Height = 250
                  TabOrder = 2
                  object lblSigFieldPageNo: TLabel
                    Left = 8
                    Top = 15
                    Width = 76
                    Height = 13
                    Caption = 'Field Page #:'
                  end
                  object shpSigFillColor: TShape
                    Left = 129
                    Top = 105
                    Width = 31
                    Height = 21
                    Hint = 'Click to Select Background Color'
                    Brush.Color = clYellow
                    ParentShowHint = False
                    ShowHint = True
                    OnMouseDown = shpBackgroundColorMouseDown
                    OnMouseUp = shpBackgroundColorMouseUp
                  end
                  object lblSigFillColor: TLabel
                    Left = 8
                    Top = 105
                    Width = 55
                    Height = 13
                    Caption = 'Fill Color:'
                  end
                  object edSigFieldPageNo: TEdit
                    Left = 129
                    Top = 15
                    Width = 156
                    Height = 21
                    TabOrder = 0
                    OnKeyPress = edSigFieldPageNoValidate
                  end
                  object gbSigAppearenceText: TGroupBox
                    Left = 8
                    Top = 128
                    Width = 276
                    Height = 90
                    Caption = 'Appearence Text'
                    TabOrder = 1
                    object chkSigShowName: TCheckBox
                      Left = 9
                      Top = 20
                      Width = 97
                      Height = 17
                      Caption = 'Show Name'
                      TabOrder = 0
                    end
                    object chkSigShowReason: TCheckBox
                      Left = 121
                      Top = 20
                      Width = 97
                      Height = 17
                      Caption = 'Show Reason'
                      TabOrder = 1
                    end
                    object chkSigShowLocation: TCheckBox
                      Left = 9
                      Top = 40
                      Width = 97
                      Height = 17
                      Caption = 'Show Location'
                      TabOrder = 2
                    end
                    object chkSigShowDate: TCheckBox
                      Left = 121
                      Top = 40
                      Width = 97
                      Height = 17
                      Caption = 'Show Date'
                      TabOrder = 3
                    end
                    object chkSigShowLabels: TCheckBox
                      Left = 9
                      Top = 60
                      Width = 97
                      Height = 17
                      Caption = 'Show Labels'
                      TabOrder = 4
                    end
                  end
                  object gbSigFieldBounds: TGroupBox
                    Left = 8
                    Top = 40
                    Width = 277
                    Height = 56
                    Caption = 'Field Bounds (inches):'
                    TabOrder = 2
                    object lblSigFieldLeft: TLabel
                      Left = 42
                      Top = 31
                      Width = 21
                      Height = 13
                      Caption = 'Left'
                    end
                    object lblSigFieldTop: TLabel
                      Left = 98
                      Top = 31
                      Width = 21
                      Height = 13
                      Caption = 'Top'
                    end
                    object lblSigFieldRight: TLabel
                      Left = 154
                      Top = 31
                      Width = 29
                      Height = 13
                      Caption = 'Right'
                    end
                    object lblSigFieldBottom: TLabel
                      Left = 219
                      Top = 31
                      Width = 41
                      Height = 13
                      Caption = 'Bottom'
                    end
                    object edSigFieldLeft: TEdit
                      Left = 9
                      Top = 23
                      Width = 32
                      Height = 21
                      TabOrder = 0
                      OnExit = edSigFieldBoundsRangeValidate
                      OnKeyPress = edSigFieldBoundsValidate
                    end
                    object edSigFieldTop: TEdit
                      Left = 65
                      Top = 23
                      Width = 32
                      Height = 21
                      TabOrder = 1
                      OnKeyPress = edSigFieldBoundsValidate
                    end
                    object edSigFieldRight: TEdit
                      Left = 121
                      Top = 23
                      Width = 32
                      Height = 21
                      TabOrder = 2
                      OnExit = edSigFieldBoundsRangeValidate
                      OnKeyPress = edSigFieldBoundsValidate
                    end
                    object edSigFieldBottom: TEdit
                      Left = 185
                      Top = 23
                      Width = 32
                      Height = 21
                      TabOrder = 3
                      OnKeyPress = edSigFieldBoundsValidate
                    end
                  end
                end
                object chkSigFieldVisible: TCheckBox
                  Left = 16
                  Top = 60
                  Width = 137
                  Height = 17
                  Caption = 'Field Visible On Page'
                  TabOrder = 1
                  OnClick = chkSigFieldVisibleClick
                end
              end
              object pgtSignatureProperties: TTabSheet
                Caption = 'Signature Properties'
                ImageIndex = 1
                object lblSigCertFileName: TLabel
                  Left = 8
                  Top = 20
                  Width = 87
                  Height = 13
                  Caption = 'Certificate File:'
                end
                object lblSigCertPassword: TLabel
                  Left = 8
                  Top = 62
                  Width = 122
                  Height = 13
                  Caption = 'Certificate Password:'
                end
                object lblSigConfirmCertPassword: TLabel
                  Left = 159
                  Top = 62
                  Width = 109
                  Height = 13
                  Caption = 'Confirm Password:'
                end
                object btnSelectCertFile: TSpeedButton
                  Left = 282
                  Top = 35
                  Width = 23
                  Height = 22
                  Caption = '...'
                  OnClick = btnSelectCertFileClick
                end
                object lblSigAuthor: TLabel
                  Left = 8
                  Top = 102
                  Width = 43
                  Height = 13
                  Caption = 'Author:'
                end
                object lblSigContactInfo: TLabel
                  Left = 159
                  Top = 102
                  Width = 120
                  Height = 13
                  Caption = 'Contact Information:'
                end
                object lblSigReason: TLabel
                  Left = 7
                  Top = 142
                  Width = 47
                  Height = 13
                  Caption = 'Reason:'
                end
                object lblSigLocation: TLabel
                  Left = 159
                  Top = 142
                  Width = 52
                  Height = 13
                  Caption = 'Location:'
                end
                object edSigCertFileName: TEdit
                  Left = 8
                  Top = 36
                  Width = 273
                  Height = 21
                  ReadOnly = True
                  TabOrder = 0
                end
                object edSigCertPassword: TEdit
                  Left = 8
                  Top = 78
                  Width = 146
                  Height = 21
                  PasswordChar = '*'
                  TabOrder = 1
                end
                object edSigConfirmCertPassword: TEdit
                  Left = 159
                  Top = 78
                  Width = 146
                  Height = 21
                  PasswordChar = '*'
                  TabOrder = 2
                  OnExit = edConfirmPasswordExit
                end
                object edSigAuthor: TEdit
                  Left = 8
                  Top = 118
                  Width = 146
                  Height = 21
                  TabOrder = 3
                  OnKeyPress = edAutherValidate
                end
                object edSigContactInfo: TEdit
                  Left = 159
                  Top = 118
                  Width = 146
                  Height = 21
                  TabOrder = 4
                end
                object edSigReason: TEdit
                  Left = 7
                  Top = 158
                  Width = 146
                  Height = 21
                  TabOrder = 5
                  OnKeyPress = edReasonValidate
                end
                object edSigLocation: TEdit
                  Left = 159
                  Top = 158
                  Width = 146
                  Height = 21
                  TabOrder = 6
                  OnKeyPress = edLocationValidate
                end
                object rgDate: TRadioGroup
                  Left = 7
                  Top = 182
                  Width = 298
                  Height = 75
                  Caption = 'Date:'
                  Items.Strings = (
                    'Current System Date'
                    'Fixed :')
                  TabOrder = 7
                  OnClick = rgDateClick
                end
                object datetimeSigDateTime: TDateTimePicker
                  Left = 87
                  Top = 229
                  Width = 210
                  Height = 21
                  Date = 41216.709212962960000000
                  Format = 'dd-MMM-yyyy hh:mm tt'
                  Time = 41216.709212962960000000
                  Enabled = False
                  TabOrder = 8
                  OnChange = datetimeSigDateTimeValidate
                end
              end
            end
          end
          object chkDigitallySign: TCheckBox
            Left = 16
            Top = 0
            Width = 158
            Height = 18
            Caption = 'Digitally Sign Document'
            TabOrder = 0
            OnClick = chkDigitallySignClick
          end
        end
        inherited tsEMailInfo: TTabSheet
          inherited gbEMailInfo: TGroupBox
            Width = 329
            inherited edHost: TEdit
              Width = 247
            end
            inherited edPort: TEdit
              Width = 247
            end
            inherited edFrom: TEdit
              Width = 247
            end
            inherited edTo: TEdit
              Width = 247
            end
            inherited edCC: TEdit
              Width = 247
            end
            inherited edBCC: TEdit
              Width = 247
            end
            inherited edEmailSubject: TEdit
              Width = 247
            end
            inherited memoBody: TMemo
              Width = 311
            end
            inherited gbAuthentication: TGroupBox
              Width = 312
              inherited edPassword: TEdit
                Width = 226
              end
              inherited edUserID: TEdit
                Width = 226
              end
            end
          end
          inherited chkEmailAfterCreate: TCheckBox
            Top = 0
          end
        end
      end
    end
  end
  inherited OpenPictureDialog: TOpenPictureDialog
    Left = 360
    Top = 65532
  end
  inherited ColorDialog: TColorDialog
    Left = 432
    Top = 65532
  end
end

object gtDocumentDlg: TgtDocumentDlg
  Left = 290
  Top = 152
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = 'gtDocumentDlg'
  ClientHeight = 458
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    479
    458)
  PixelsPerInch = 96
  TextHeight = 13
  object lblGnostice: TLabel
    Left = 12
    Top = 433
    Width = 120
    Height = 13
    Cursor = crHandPoint
    Anchors = [akLeft, akBottom]
    Caption = 'Gnostice eDocEngine'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lblGnosticeClick
  end
  object btnOK: TButton
    Left = 313
    Top = 427
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 395
    Top = 427
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pnlDocDlg: TPanel
    Left = 8
    Top = 8
    Width = 462
    Height = 410
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 123
      Height = 408
      Align = alLeft
      Color = clNavy
      TabOrder = 0
      object lbDocumentDlg: TListBox
        Left = 1
        Top = 1
        Width = 121
        Height = 406
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbDocumentDlgClick
      end
    end
    object Panel2: TPanel
      Left = 124
      Top = 1
      Width = 337
      Height = 408
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 337
        Height = 13
        Align = alTop
        BevelOuter = bvNone
        Color = clInfoBk
        TabOrder = 0
        object lblDialogCaption: TLabel
          Left = 12
          Top = 0
          Width = 4
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pcDocument: TPageControl
        Left = 0
        Top = 13
        Width = 337
        Height = 395
        ActivePage = tsPreferences
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 1
        object tsPreferences: TTabSheet
          Caption = 'Preferences'
          TabVisible = False
          DesignSize = (
            329
            385)
          object gbPreferences: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 377
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            DesignSize = (
              313
              377)
            object chkUseImagesAsResources: TCheckBox
              Left = 8
              Top = 120
              Width = 177
              Height = 17
              Caption = 'Use Images As Resources'
              TabOrder = 1
            end
            object chkOpenAfterCreate: TCheckBox
              Left = 180
              Top = 120
              Width = 129
              Height = 17
              Caption = 'Open After Create'
              TabOrder = 3
            end
            object chkProcessAfterEachPage: TCheckBox
              Left = 8
              Top = 144
              Width = 161
              Height = 17
              Caption = 'Process After Each Page'
              TabOrder = 2
            end
            object gbPageRange: TGroupBox
              Left = 8
              Top = 8
              Width = 297
              Height = 110
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Page Range'
              TabOrder = 0
              object lblPageExample: TLabel
                Left = 8
                Top = 67
                Width = 267
                Height = 26
                AutoSize = False
                WordWrap = True
              end
              object rbtnAll: TRadioButton
                Left = 8
                Top = 17
                Width = 113
                Height = 17
                Caption = 'All Pages'
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = rbtnAllClick
              end
              object rbtnPages: TRadioButton
                Left = 8
                Top = 38
                Width = 125
                Height = 17
                Caption = 'Pages:'
                TabOrder = 1
                OnClick = rbtnPagesClick
              end
              object edPages: TEdit
                Left = 137
                Top = 36
                Width = 150
                Height = 21
                TabOrder = 2
                OnChange = edPagesChange
                OnKeyPress = edPagesKeyPress
              end
            end
          end
        end
        object tsContent: TTabSheet
          Caption = 'Content'
          ImageIndex = 1
          TabVisible = False
          DesignSize = (
            329
            385)
          object gbContentOptions: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 377
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            DesignSize = (
              313
              377)
            object gbItemsToRender: TGroupBox
              Left = 8
              Top = 8
              Width = 297
              Height = 190
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = 'Items To Render'
              TabOrder = 0
              object chkText: TCheckBox
                Left = 16
                Top = 16
                Width = 57
                Height = 17
                Caption = 'Text'
                TabOrder = 0
              end
              object chkShape: TCheckBox
                Left = 16
                Top = 36
                Width = 57
                Height = 17
                Caption = 'Shape'
                TabOrder = 1
              end
              object gbImageSettings: TGroupBox
                Left = 8
                Top = 56
                Width = 257
                Height = 121
                TabOrder = 3
                object lblOutputImageFormat: TLabel
                  Left = 8
                  Top = 20
                  Width = 128
                  Height = 13
                  Caption = 'Output Image Format:'
                end
                object lblJPEGQuality: TLabel
                  Left = 8
                  Top = 44
                  Width = 77
                  Height = 13
                  Caption = 'JPEG Quality:'
                end
                object lblImagePixelFormat: TLabel
                  Left = 8
                  Top = 68
                  Width = 117
                  Height = 13
                  Caption = 'Image Pixel Format:'
                end
                object lblSourceDPI: TLabel
                  Left = 8
                  Top = 92
                  Width = 70
                  Height = 13
                  Caption = 'Source DPI:'
                end
                object cbOutputImageFormat: TComboBox
                  Left = 152
                  Top = 16
                  Width = 97
                  Height = 21
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 0
                  OnChange = cbOutputImageFormatChange
                end
                object edJPEGQuality: TEdit
                  Left = 152
                  Top = 40
                  Width = 97
                  Height = 21
                  MaxLength = 3
                  TabOrder = 1
                end
                object cbImagePixelFormat: TComboBox
                  Left = 152
                  Top = 64
                  Width = 97
                  Height = 21
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 2
                end
                object edSourceDPI: TEdit
                  Left = 152
                  Top = 88
                  Width = 97
                  Height = 21
                  TabOrder = 3
                end
              end
              object chkImage: TCheckBox
                Left = 16
                Top = 56
                Width = 57
                Height = 17
                Caption = 'Image'
                TabOrder = 2
              end
            end
            object gbDocInfo: TGroupBox
              Left = 8
              Top = 200
              Width = 297
              Height = 169
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = 'Document Information'
              TabOrder = 1
              object lblAuthor: TLabel
                Left = 16
                Top = 24
                Width = 43
                Height = 13
                Caption = 'Author:'
              end
              object lblCreator: TLabel
                Left = 16
                Top = 48
                Width = 49
                Height = 13
                Caption = 'Creator:'
              end
              object lblKeywords: TLabel
                Left = 16
                Top = 72
                Width = 61
                Height = 13
                Caption = 'Keywords:'
              end
              object lblSubject: TLabel
                Left = 16
                Top = 96
                Width = 48
                Height = 13
                Caption = 'Subject:'
              end
              object lblTitle: TLabel
                Left = 16
                Top = 120
                Width = 29
                Height = 13
                Caption = 'Title:'
              end
              object edAuthor: TEdit
                Left = 96
                Top = 20
                Width = 100
                Height = 21
                TabOrder = 0
              end
              object edCreator: TEdit
                Left = 96
                Top = 44
                Width = 100
                Height = 21
                TabOrder = 1
              end
              object edKeywords: TEdit
                Left = 96
                Top = 68
                Width = 100
                Height = 21
                TabOrder = 2
              end
              object edSubject: TEdit
                Left = 96
                Top = 92
                Width = 100
                Height = 21
                TabOrder = 3
              end
              object edTitle: TEdit
                Left = 96
                Top = 116
                Width = 100
                Height = 21
                TabOrder = 4
              end
            end
          end
        end
        object tsBackground: TTabSheet
          Caption = 'Background'
          ImageIndex = 2
          TabVisible = False
          DesignSize = (
            329
            385)
          object gbBackground: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 377
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            object lblBackgroundImage: TLabel
              Left = 8
              Top = 12
              Width = 114
              Height = 13
              Caption = 'Background Image:'
            end
            object lblBackgroundDisplayType: TLabel
              Left = 8
              Top = 136
              Width = 151
              Height = 13
              Caption = 'Background Display Type:'
            end
            object lblBackgroundColor: TLabel
              Left = 8
              Top = 159
              Width = 108
              Height = 13
              Caption = 'Background Color:'
            end
            object shpBackgroundColor: TShape
              Left = 183
              Top = 155
              Width = 31
              Height = 21
              Hint = 'Click to Select Background Color'
              ParentShowHint = False
              ShowHint = True
              OnMouseDown = shpBackgroundColorMouseDown
              OnMouseUp = shpBackgroundColorMouseUp
            end
            object btnSelectImage: TButton
              Left = 216
              Top = 48
              Width = 89
              Height = 22
              Caption = '&Select Image'
              TabOrder = 1
              OnClick = btnSelectImageClick
            end
            object btnClear: TButton
              Left = 216
              Top = 100
              Width = 89
              Height = 22
              Caption = 'C&lear'
              TabOrder = 3
              OnClick = btnClearClick
            end
            object pnlBackgroundImage: TPanel
              Left = 8
              Top = 33
              Width = 204
              Height = 89
              BevelInner = bvLowered
              BevelOuter = bvLowered
              TabOrder = 0
              object imgBackgroundImage: TImage
                Left = 2
                Top = 2
                Width = 200
                Height = 85
                Align = alClient
                Stretch = True
              end
            end
            object cbBackgroundDisplayType: TComboBox
              Left = 183
              Top = 130
              Width = 122
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
            end
            object btnImgPrvw: TButton
              Left = 216
              Top = 74
              Width = 89
              Height = 22
              Caption = '&Preview'
              TabOrder = 2
              OnClick = btnImgPrvwClick
            end
          end
        end
        object tsEMailInfo: TTabSheet
          Caption = 'EMail Information'
          ImageIndex = 3
          TabVisible = False
          object gbEMailInfo: TGroupBox
            Left = 8
            Top = 6
            Width = 313
            Height = 368
            TabOrder = 0
            DesignSize = (
              313
              368)
            object lblHost: TLabel
              Left = 32
              Top = 20
              Width = 34
              Height = 13
              Caption = 'Host: '
            end
            object Label1: TLabel
              Left = 21
              Top = 44
              Width = 45
              Height = 13
              Caption = 'Port #: '
            end
            object lblFrom: TLabel
              Left = 28
              Top = 149
              Width = 38
              Height = 13
              Caption = 'From: '
            end
            object lblTo: TLabel
              Left = 43
              Top = 174
              Width = 23
              Height = 13
              Caption = 'To: '
            end
            object lblCC: TLabel
              Left = 39
              Top = 198
              Width = 27
              Height = 13
              Caption = 'CC: '
            end
            object lblBCC: TLabel
              Left = 31
              Top = 223
              Width = 35
              Height = 13
              Caption = 'BCC: '
            end
            object Label3: TLabel
              Left = 14
              Top = 248
              Width = 52
              Height = 13
              Caption = 'Subject: '
            end
            object Label2: TLabel
              Left = 8
              Top = 267
              Width = 58
              Height = 13
              Caption = 'Message: '
            end
            object edHost: TEdit
              Left = 72
              Top = 16
              Width = 231
              Height = 21
              Anchors = [akLeft, akRight]
              TabOrder = 0
            end
            object edPort: TEdit
              Left = 72
              Top = 40
              Width = 231
              Height = 21
              TabOrder = 1
            end
            object edFrom: TEdit
              Left = 72
              Top = 145
              Width = 231
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edTo: TEdit
              Left = 72
              Top = 170
              Width = 231
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
            end
            object edCC: TEdit
              Left = 72
              Top = 194
              Width = 231
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 5
            end
            object edBCC: TEdit
              Left = 72
              Top = 219
              Width = 231
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 6
            end
            object edEmailSubject: TEdit
              Left = 72
              Top = 244
              Width = 231
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 7
            end
            object memoBody: TMemo
              Left = 8
              Top = 287
              Width = 295
              Height = 73
              Anchors = [akLeft, akRight]
              TabOrder = 8
            end
            object gbAuthentication: TGroupBox
              Left = 8
              Top = 66
              Width = 295
              Height = 75
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 9
              DesignSize = (
                295
                75)
              object lblUserID: TLabel
                Left = 22
                Top = 20
                Width = 49
                Height = 13
                Caption = 'UserID: '
              end
              object lblPassword: TLabel
                Left = 8
                Top = 45
                Width = 63
                Height = 13
                Caption = 'Password: '
              end
              object edPassword: TEdit
                Left = 77
                Top = 41
                Width = 209
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                PasswordChar = '*'
                TabOrder = 0
              end
              object edUserID: TEdit
                Left = 77
                Top = 16
                Width = 209
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 1
              end
            end
            object chkAuthentication: TCheckBox
              Left = 16
              Top = 63
              Width = 201
              Height = 17
              Caption = 'Server Requires Authentication'
              TabOrder = 2
              OnClick = chkAuthenticationClick
            end
          end
          object chkEmailAfterCreate: TCheckBox
            Left = 16
            Top = 1
            Width = 129
            Height = 18
            Caption = 'Email After Create'
            TabOrder = 1
            OnClick = chkEmailAfterCreateClick
          end
        end
      end
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 396
  end
  object ColorDialog: TColorDialog
    Left = 436
    Top = 8
  end
  object OpenFileDialog: TOpenDialog
    Filter = 'PFX|*.PFX'
    Left = 336
    Top = 65528
  end
end

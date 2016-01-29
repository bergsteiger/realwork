inherited GetIssuePropsDlg: TGetIssuePropsDlg
  Left = 609
  Top = 311
  ActiveControl = edtDate1
  Caption = #1053#1086#1084#1077#1088' '#1080#1079#1076#1072#1085#1080#1103
  ClientHeight = 332
  ClientWidth = 367
  PixelsPerInch = 96
  TextHeight = 16
  object Label6: TLabel [0]
    Left = 16
    Top = 69
    Width = 38
    Height = 16
    Caption = ' '#1044#1072#1090#1072' '
  end
  object Bevel3: TBevel [1]
    Left = 9
    Top = 77
    Width = 312
    Height = 46
    Shape = bsFrame
  end
  inherited ButtonPanel: TPanel
    Top = 287
    Width = 367
    object vtSpeedButton1: TvtSpeedButton [0]
      Left = 8
      Top = 10
      Width = 27
      Height = 27
      Action = acAddIssueImage
      Flat = False
      Images = ArchiResources.CommonImageList
      Margin = 2
    end
    inherited OK: TBitBtn
      Left = 90
    end
    inherited Cancel: TBitBtn
      Left = 181
    end
    inherited Help: TBitBtn
      Left = 271
    end
  end
  inherited Panel1: TPanel
    Width = 367
    Height = 287
    object Bevel4: TBevel
      Left = 7
      Top = 15
      Width = 350
      Height = 77
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 8
      Top = 167
      Width = 350
      Height = 46
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 8
      Top = 104
      Width = 350
      Height = 46
      Shape = bsFrame
    end
    object Label2: TLabel
      Left = 16
      Top = 95
      Width = 38
      Height = 16
      Caption = ' '#1044#1072#1090#1072' '
    end
    object Label3: TLabel
      Left = 11
      Top = 120
      Width = 14
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1089
    end
    object Label4: TLabel
      Left = 164
      Top = 120
      Width = 26
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1087#1086
    end
    object Label5: TLabel
      Left = 16
      Top = 160
      Width = 49
      Height = 16
      Caption = ' '#1053#1086#1084#1077#1088' '
    end
    object lblPubSource: TLabel
      Left = 14
      Top = 27
      Width = 335
      Height = 59
      AutoSize = False
      Caption = ' '
      WordWrap = True
    end
    object Label7: TLabel
      Left = 16
      Top = 9
      Width = 64
      Height = 16
      Caption = ' '#1048#1079#1076#1072#1085#1080#1077' '
    end
    object Bevel5: TBevel
      Left = 8
      Top = 230
      Width = 350
      Height = 46
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 16
      Top = 223
      Width = 95
      Height = 16
      Caption = ' '#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '
    end
    object edtDate1: TvtDateEdit
      Left = 31
      Top = 115
      Width = 121
      Height = 24
      Style = csDropDown
      TabOrder = 0
    end
    object edtDate2: TvtDateEdit
      Left = 196
      Top = 115
      Width = 121
      Height = 24
      Style = csDropDown
      TabOrder = 1
      OnEnter = edtDate2Enter
    end
    object edtNumber: TEdit
      Left = 19
      Top = 179
      Width = 327
      Height = 24
      MaxLength = 10
      TabOrder = 2
    end
    object edtComment: TEdit
      Left = 19
      Top = 242
      Width = 327
      Height = 24
      MaxLength = 70
      TabOrder = 3
    end
  end
  object ActionList1: TActionList
    Images = ArchiResources.CommonImageList
    Left = 45
    Top = 296
    object acAddIssueImage: TAction
      Caption = 'acAddIssueImage'
      Enabled = False
      Hint = #1054#1073#1088#1072#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 29
      OnExecute = acAddIssueImageExecute
    end
  end
end

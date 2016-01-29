inherited PublishedInEditDlg: TPublishedInEditDlg
  Left = 478
  Top = 259
  Width = 496
  Height = 333
  Caption = #1048#1057#1058#1054#1063#1053#1048#1050' '#1054#1055#1059#1041#1051#1048#1050#1054#1042#1040#1053#1048#1071
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 250
    Width = 480
    object vtSpeedButton1: TvtSpeedButton [0]
      Left = 8
      Top = 10
      Width = 27
      Height = 27
      Action = acAddIssueImage
      Flat = False
      Images = ArchiResources.CommonImageList
      Margin = 2
      ParentShowHint = False
      ShowHint = True
    end
    inherited OK: TBitBtn
      Left = 211
    end
    inherited Cancel: TBitBtn
      Left = 302
    end
    inherited Help: TBitBtn
      Left = 392
    end
  end
  inherited Panel1: TPanel
    Width = 480
    Height = 250
    object Label3: TLabel
      Left = 7
      Top = 118
      Width = 340
      Height = 16
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = #1053#1086#1084#1077#1088#1072' '#1089#1090#1088#1072#1085#1080#1094' '#1074' '#1080#1089#1090#1086#1095#1085#1080#1082#1077
    end
    object Label4: TLabel
      Left = 7
      Top = 170
      Width = 334
      Height = 14
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object Bevel4: TBevel
      Left = 7
      Top = 12
      Width = 467
      Height = 90
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label7: TLabel
      Left = 16
      Top = 4
      Width = 64
      Height = 16
      Caption = ' '#1048#1079#1076#1072#1085#1080#1077' '
    end
    object lblPubSource: TLabel
      Left = 15
      Top = 22
      Width = 451
      Height = 72
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = ' '
      WordWrap = True
    end
    object edtPageNumbers: TEdit
      Left = 7
      Top = 139
      Width = 468
      Height = 24
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 0
    end
    object edtComment: TEdit
      Left = 6
      Top = 192
      Width = 469
      Height = 24
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 1
    end
    object cbClone: TCheckBox
      Left = 6
      Top = 226
      Width = 97
      Height = 17
      Caption = #1050#1083#1086#1085
      TabOrder = 2
    end
  end
  object ActionList1: TActionList
    Images = ArchiResources.CommonImageList
    Left = 57
    Top = 259
    object acAddIssueImage: TAction
      Caption = 'acAddIssueImage'
      Hint = #1054#1073#1088#1072#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 29
      ShortCut = 16467
      OnExecute = acAddIssueImageExecute
    end
  end
end

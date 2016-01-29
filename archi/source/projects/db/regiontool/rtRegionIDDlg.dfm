object RegionIDDlg: TRegionIDDlg
  Left = 496
  Top = 403
  ActiveControl = edRegionID
  BorderStyle = bsDialog
  Caption = #1047#1072#1084#1077#1085#1072' ID '#1074#1072#1096#1077#1075#1086' '#1088#1077#1075#1080#1086#1085#1072
  ClientHeight = 137
  ClientWidth = 313
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    313
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 84
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 242
    Height = 26
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1079#1076#1077#1089#1100' ID '#1074#1072#1096#1077#1075#1086' '#1088#1077#1075#1080#1086#1085#1072', '#1082#1086#1090#1086#1088#1099#1081' '#1074#1099' '#1087#1086#1083#1091#1095#1080#1083#1080' '#1080#1079' '#1094#1077#1085#1090#1088#1072#1083#1100 +
      #1085#1086#1075#1086' '#1086#1092#1080#1089#1072
    WordWrap = True
  end
  object OKBtn: TButton
    Left = 79
    Top = 103
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 159
    Top = 103
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object edRegionID: TEdit
    Left = 128
    Top = 56
    Width = 57
    Height = 21
    TabOrder = 2
  end
end

inherited ChangeHLAddrDlg: TChangeHLAddrDlg
  Left = 539
  Top = 373
  VertScrollBar.Range = 0
  ActiveControl = edtAddrFrom
  BorderStyle = bsDialog
  Caption = #1047#1072#1084#1077#1085#1072' '#1072#1076#1088#1077#1089#1072' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1080
  ClientHeight = 161
  ClientWidth = 336
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 116
    Width = 336
    inherited OK: TBitBtn
      Left = 63
    end
    inherited Cancel: TBitBtn
      Left = 154
    end
    inherited Help: TBitBtn
      Left = 244
    end
  end
  inherited Panel1: TPanel
    Width = 336
    Height = 116
    object lblAddrFrom: TLabel
      Left = 10
      Top = 12
      Width = 127
      Height = 16
      Caption = #1040#1076#1088#1077#1089' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1080
    end
    object lblAddrTo: TLabel
      Left = 10
      Top = 61
      Width = 83
      Height = 16
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1085#1072
    end
    object edtAddrFrom: TEdit
      Left = 10
      Top = 32
      Width = 313
      Height = 24
      TabOrder = 0
      OnChange = edtAddrFromChange
    end
    object edtAddrTo: TEdit
      Left = 10
      Top = 80
      Width = 313
      Height = 24
      TabOrder = 1
      OnChange = edtAddrFromChange
    end
  end
end

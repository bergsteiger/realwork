inherited TGetJurOpDlg: TTGetJurOpDlg
  Left = 497
  Top = 333
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1072#1103' '#1086#1087#1077#1088#1072#1094#1080#1103
  ClientHeight = 182
  ClientWidth = 305
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 137
    Width = 305
    inherited OK: TBitBtn
      Left = 31
    end
    inherited Cancel: TBitBtn
      Left = 122
    end
    inherited Help: TBitBtn
      Left = 212
    end
  end
  inherited Panel1: TPanel
    Width = 305
    Height = 137
    object vtBoundedLabel1: TvtBoundedLabel
      Left = 14
      Top = 11
      Width = 89
      Height = 16
      Autosize = False
      BoundedControl = cbOperation
      Caption = #1054#1087#1077#1088#1072#1094#1080#1103
      Position = lpAbove
    end
    object vtBoundedLabel2: TvtBoundedLabel
      Left = 14
      Top = 73
      Width = 28
      Height = 16
      BoundedControl = edtDate
      Caption = #1044#1072#1090#1072
      Position = lpAbove
    end
    object cbOperation: TvtComboBox
      Left = 14
      Top = 32
      Width = 275
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      OnChange = cbOperationChange
    end
    object edtDate: TvtDateEdit
      Left = 14
      Top = 94
      Width = 121
      Height = 24
      Style = csDropDown
      TabOrder = 1
    end
  end
end

inherited DateNumEditorDlg: TDateNumEditorDlg
  Left = 428
  Top = 173
  VertScrollBar.Range = 0
  ActiveControl = cbDNType
  AutoScroll = False
  Caption = #1044#1072#1090#1072', '#1053#1086#1084#1077#1088
  ClientHeight = 195
  ClientWidth = 490
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 150
    Width = 490
    inherited OK: TBitBtn
      Left = 213
      ModalResult = 0
      OnClick = OKClick
      Kind = bkCustom
    end
    inherited Cancel: TBitBtn
      Left = 304
    end
    inherited Help: TBitBtn
      Left = 394
    end
  end
  inherited Panel1: TPanel
    Width = 490
    Height = 150
    Font.Name = 'Arial'
    ParentFont = False
    object Bevel3: TBevel
      Left = 13
      Top = 17
      Width = 466
      Height = 47
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 12
      Top = 91
      Width = 302
      Height = 46
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 321
      Top = 91
      Width = 158
      Height = 46
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 28
      Height = 16
      Caption = ' '#1058#1080#1087' '
    end
    object lblDate: TLabel
      Left = 328
      Top = 83
      Width = 36
      Height = 16
      Caption = ' '#1044#1072#1090#1072' '
    end
    object lblNumber: TLabel
      Left = 19
      Top = 83
      Width = 47
      Height = 16
      Caption = ' '#1053#1086#1084#1077#1088' '
    end
    object edtDate: TvtDateEdit
      Left = 340
      Top = 103
      Width = 127
      Height = 24
      ParentFont = True
      Style = csDropDown
      TabOrder = 2
      OnChange = edtDateChange
    end
    object cbDNType: TComboBox
      Left = 25
      Top = 29
      Width = 441
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      OnChange = cbDNTypeChange
    end
    object edtNumber: TEdit
      Left = 26
      Top = 102
      Width = 275
      Height = 24
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnChange = edtNumberChange
    end
    object cbMOJNOTREG: TCheckBox
      Left = 29
      Top = 68
      Width = 186
      Height = 16
      Caption = #1042' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1086#1090#1082#1072#1079#1072#1085#1086
      TabOrder = 3
      Visible = False
      OnClick = cbMOJNOTREGClick
    end
  end
end

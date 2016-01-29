inherited SrcCheckDlg: TSrcCheckDlg
  Left = 286
  Top = 238
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1042#1099#1095#1080#1090#1082#1072
  ClientHeight = 290
  ClientWidth = 492
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel5: TBevel [0]
    Left = 330
    Top = 75
    Width = 150
    Height = 45
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 338
    Top = 67
    Width = 49
    Height = 16
    Caption = ' '#1053#1086#1084#1077#1088' '
  end
  inherited ButtonPanel: TPanel
    Top = 245
    Width = 492
    inherited OK: TBitBtn
      Left = 215
    end
    inherited Cancel: TBitBtn
      Left = 306
    end
    inherited Help: TBitBtn
      Left = 396
    end
  end
  inherited Panel1: TPanel
    Width = 492
    Height = 245
    object Bevel4: TBevel
      Left = 12
      Top = 185
      Width = 469
      Height = 47
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 12
      Top = 127
      Width = 131
      Height = 47
      Shape = bsFrame
    end
    object Bevel3: TBevel
      Left = 11
      Top = 70
      Width = 469
      Height = 47
      Shape = bsFrame
    end
    object Label6: TLabel
      Left = 19
      Top = 177
      Width = 86
      Height = 16
      Caption = ' '#1050#1086#1084#1077#1085#1090#1072#1088#1080#1081' '
    end
    object Label2: TLabel
      Left = 17
      Top = 119
      Width = 38
      Height = 16
      Caption = ' '#1044#1072#1090#1072' '
    end
    object Label3: TLabel
      Left = 17
      Top = 62
      Width = 69
      Height = 16
      Caption = ' '#1048#1089#1090#1086#1095#1085#1080#1082' '
    end
    object Bevel6: TBevel
      Left = 151
      Top = 127
      Width = 330
      Height = 47
      Shape = bsFrame
    end
    object Label4: TLabel
      Left = 160
      Top = 121
      Width = 76
      Height = 16
      Caption = ' '#1050#1086#1088#1088#1077#1082#1090#1086#1088' '
    end
    object Bevel2: TBevel
      Left = 11
      Top = 12
      Width = 181
      Height = 47
      Shape = bsFrame
    end
    object Label5: TLabel
      Left = 21
      Top = 6
      Width = 31
      Height = 16
      Caption = ' '#1058#1080#1087' '
    end
    object cbSource: TComboBox
      Left = 24
      Top = 82
      Width = 445
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
    end
    object cbUser: TComboBox
      Left = 162
      Top = 141
      Width = 308
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 3
    end
    object edtDate: TvtDateEdit
      Left = 24
      Top = 140
      Width = 108
      Height = 24
      Style = csDropDown
      TabOrder = 2
    end
    object edtComment: TEdit
      Left = 25
      Top = 198
      Width = 445
      Height = 24
      TabOrder = 4
    end
    object cbType: TComboBox
      Left = 22
      Top = 25
      Width = 159
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      Items.Strings = (
        #1044#1086#1082#1091#1084#1077#1085#1090
        #1048#1079#1084#1077#1085#1077#1085#1080#1103)
    end
  end
end

inherited PaperWhereDlg: TPaperWhereDlg
  Left = 467
  Top = 90
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1052#1077#1089#1090#1086#1085#1072#1093#1086#1078#1076#1077#1085#1080#1077' '#1073#1091#1084#1072#1078#1085#1086#1081' '#1082#1086#1087#1080#1080
  ClientHeight = 295
  ClientWidth = 509
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 250
    Width = 509
    inherited OK: TBitBtn
      Left = 234
    end
    inherited Cancel: TBitBtn
      Left = 325
    end
    inherited Help: TBitBtn
      Left = 415
    end
  end
  inherited Panel1: TPanel
    Width = 509
    Height = 250
    OnResize = Panel1Resize
    object rbDocPlaceUser: TRadioButton
      Left = 9
      Top = 12
      Width = 135
      Height = 17
      Caption = ' '#1059' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object cbDocPlaceUser: TComboBox
      Left = 30
      Top = 30
      Width = 470
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
      OnChange = cbDocPlaceUserChange
    end
    object rbDocPlaceArchieve: TRadioButton
      Left = 9
      Top = 62
      Width = 113
      Height = 17
      Caption = ' '#1042' '#1072#1088#1093#1080#1074#1077
      TabOrder = 2
      OnClick = rbDocPlaceArchieveClick
    end
    object memDocPlaceAddr: TevMemo
      Left = 30
      Top = 86
      Width = 470
      Height = 146
      RMargin = 8
      Wrap = False
      TabOrder = 3
      TabStop = True
      BorderStyle = bsSingle
    end
  end
end

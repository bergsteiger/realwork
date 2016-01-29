inherited DictItemRequest: TDictItemRequest
  Left = 349
  Top = 208
  VertScrollBar.Range = 0
  AutoScroll = False
  ClientHeight = 227
  ClientWidth = 370
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 182
    Width = 370
    inherited OK: TBitBtn
      Left = 96
    end
    inherited Cancel: TBitBtn
      Left = 187
    end
    inherited Help: TBitBtn
      Left = 277
    end
  end
  inherited Panel1: TPanel
    Width = 370
    Height = 182
    object lblDictID: TLabel
      Left = 11
      Top = 103
      Width = 214
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'ID '
    end
    object lblBanner: TLabel
      Left = 8
      Top = 5
      Width = 352
      Height = 83
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      WordWrap = True
    end
    object sbItemList: TSpeedButton
      Left = 336
      Top = 100
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = sbItemListClick
    end
    object labelDeleted: TvtLabel
      Left = 136
      Top = 152
      Width = 89
      Height = 16
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1091#1076#1072#1083#1077#1085#1080#1103
      Visible = False
    end
    object edtDictID: TvtSpinEdit
      Left = 236
      Top = 99
      Width = 93
      Height = 24
      UseMaxValue = False
      TabOrder = 0
      OnKeyDown = edtDictIDKeyDown
    end
    object cbxAddBackEq: TCheckBox
      Left = 11
      Top = 133
      Width = 324
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1073#1088#1072#1090#1085#1091#1102' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1086#1089#1090#1100
      TabOrder = 1
    end
    object comboDateDeleted: TComboBox
      Left = 236
      Top = 152
      Width = 125
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 2
      Visible = False
      Items.Strings = (
        #1090#1077#1082#1091#1097#1072#1103' '#1074#1077#1088#1089#1080#1103
        #1089#1083#1077#1076#1091#1102#1097#1072#1103' '#1074#1077#1088#1089#1080#1103)
    end
  end
end

inherited TreeDesignerForm: TTreeDesignerForm
  Left = 696
  Top = 167
  VertScrollBar.Range = 0
  AutoScroll = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Name = 'Arial'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited DictOutliner: TvtOutliner
    OnGetItemImage = DictOutlinerGetItemImage
    OnGetItemFont = DictOutlinerGetItemFont
    OnIsCommandProcessed = DictOutlinerIsCommandProcessed
    Font.Charset = RUSSIAN_CHARSET
    Font.Name = 'Arial'
    PopupMenu = ListPopUpMenu
  end
  inherited Panel1: TPanel
    inherited sbSearch: TSpeedButton
      Left = 456
      Top = 3
    end
    object tbShowEqLeaf: TSpeedButton [5]
      Left = 107
      Top = 3
      Width = 25
      Height = 25
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1077'|'
      Flat = True
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        77007777777777777777777777777777777F7777770077777777777707777777
        7777777777F8F777770077777777777500777777777777777F888F7777007777
        7777775D000777777FFFFF77F88888F777007000007775D50000777788888F7F
        8888888F7700700000775D5D00000777888887F888888888F70077777775D5D5
        000000777FFFFF8888888888870070000077DFDFDDDDD77788888F78F7788888
        7700700000777DFDDDDD7777888887778F78888777007777777777DFDDD77777
        7777777778F88877770077777777777DDD777777777777777788877777007777
        77777777D7777777777777777778777777007777777777777777777777777777
        7777777777007777777777777777777777777777777777777700777777777777
        7777777777777777777777777700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = acShowEqLeafClick
    end
    inherited cbSearch: TvtComboBox
      Left = 136
      Width = 316
    end
  end
  inherited menuDictions: TMainMenu
    Left = 52
    Top = 54
    inherited miDictions: TMenuItem
      object miInsertClassToObjList2: TMenuItem
        Action = acKeepItemToObjList
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miShowEqLeaf: TMenuItem
        Action = acShowEqLeaf
      end
      object miAddEqLeaf: TMenuItem
        Action = acAddEqLeaf
      end
      object miDelEqLeaf: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1081
        OnClick = acDelClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miTransformToDivision: TMenuItem
        Action = acTransformToDivision
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miLoadFromFile: TMenuItem
        Action = acLoadFromFile
      end
    end
    object N3: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      GroupIndex = 6
      object miMostLinked: TMenuItem
        Caption = '"'#1055#1077#1088#1077#1075#1088#1091#1078#1077#1085#1085#1099#1077'" '#1101#1083#1077#1084#1077#1085#1090#1099
        OnClick = miMostLinkedClick
      end
      object miEmptyItems: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' "'#1087#1091#1089#1090#1099#1077'" '#1101#1083#1077#1084#1077#1085#1090#1099
        OnClick = miEmptyItemsClick
      end
    end
  end
  object ListPopUpMenu: TPopupMenu [5]
    Left = 102
    Top = 65
    object miInsertClassToObjList: TMenuItem
      Action = acKeepItemToObjList
    end
  end
  inherited DictEditActionList: TActionList
    Left = 70
    Top = 118
    object acKeepItemToObjList: TAction
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnExecute = acKeepItemToObjListClick
    end
    object acShowEqLeaf: TAction
      Category = 'Equal'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1077
      OnExecute = acShowEqLeafClick
    end
    object acAddEqLeaf: TAction
      Category = 'Equal'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1081
      OnExecute = acAddEqLeafClick
    end
    object acDelEqLeaf: TAction
      Category = 'Equal'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1081
      OnExecute = acDelClick
    end
    object acTransformToDivision: TAction
      Category = 'Edit'
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1088#1072#1079#1076#1077#1083
      OnExecute = acTransformToDivisionClick
    end
    object acLoadFromFile: TAction
      Category = 'Edit'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      OnExecute = acLoadFromFileClick
    end
  end
end

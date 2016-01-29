object en_SimpleMainMenu: Ten_SimpleMainMenu
  Left = 280
  Top = 125
  Width = 800
  Height = 483
  ActiveControl = tvSearch
  Caption = #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102
  Color = $00F9F8FA
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TvtPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 447
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object hfSearch: TnscHideField
      Left = 16
      Top = 8
      Width = 200
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1099#1081' '#1087#1086#1080#1089#1082
      ClientControl = tvSearch
      ClientIndent = 20
      HeaderImage = 3
      Images = dmMainMenuNew.ilMainMenuNew
      LeftHeaderIndent = 20
      LeftImageIndent = 10
      Options = []
      TopHeaderIndent = 15
      TabOrder = 0
      StyleId = -33
      object tvSearch: TnscTreeView
        Left = 20
        Top = 35
        Width = 180
        Height = 65
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        MultiStrokeItem = True
        ActionElementMode = l3_amSingleClick
        ViewOptions = [voShowIcons, voShowExpandable, voWithoutImages]
        ClearTreeStructOnSaveState = False
        StyleId = -31
      end
    end
    object hfLawNews: TnscHideField
      Left = 464
      Top = 8
      Width = 200
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1074' '#1079#1072#1082#1086#1085#1086#1076#1072#1090#1077#1083#1100#1089#1090#1074#1077
      ClientControl = tvLawNews
      ClientIndent = 20
      HeaderImage = 0
      Images = dmMainMenuNew.ilMainMenuNew
      LeftHeaderIndent = 20
      LeftImageIndent = 10
      Options = []
      TopHeaderIndent = 15
      TabOrder = 1
      StyleId = -33
      object tvLawNews: TnscTreeViewHotTruck
        Left = 20
        Top = 35
        Width = 180
        Height = 65
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        MultiStrokeItem = True
        ActionElementMode = l3_amSingleClick
        ViewOptions = [voShowIcons, voShowExpandable, voWithoutImages]
        ClearTreeStructOnSaveState = False
        StyleId = -31
      end
    end
    object hfLawSupport: TnscHideField
      Left = 16
      Top = 112
      Width = 200
      Height = 97
      Caption = #1055#1088#1072#1074#1086#1074#1072#1103' '#1087#1086#1076#1076#1077#1088#1078#1082#1072' '#1086#1085#1083#1072#1081#1085
      ClientControl = tvLawSupport
      ClientIndent = 20
      HeaderImage = 9
      Images = dmMainMenuNew.ilMainMenuNew
      LeftHeaderIndent = 20
      LeftImageIndent = 10
      Options = []
      TopHeaderIndent = 15
      TabOrder = 4
      StyleId = -33
      object tvLawSupport: TnscTreeView
        Left = 20
        Top = 35
        Width = 180
        Height = 62
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        MultiStrokeItem = True
        ActionElementMode = l3_amSingleClick
        ViewOptions = [voShowIcons, voShowExpandable, voWithoutImages]
        ClearTreeStructOnSaveState = False
        StyleId = -31
      end
    end
    object hfReferences: TnscHideField
      Left = 464
      Top = 112
      Width = 200
      Height = 89
      Caption = #1041#1080#1079#1085#1077#1089'-'#1089#1087#1088#1072#1074#1082#1080
      ClientControl = tvReferences
      ClientIndent = 20
      HeaderImage = 1
      Images = dmMainMenuNew.ilMainMenuNew
      LeftHeaderIndent = 20
      LeftImageIndent = 10
      Options = []
      TopHeaderIndent = 15
      TabOrder = 3
      StyleId = -33
      object tvReferences: TnscTreeViewHotTruck
        Left = 20
        Top = 35
        Width = 180
        Height = 54
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        MultiStrokeItem = True
        ActionElementMode = l3_amSingleClick
        ViewOptions = [voShowIcons, voShowExpandable, voWithoutImages]
        ClearTreeStructOnSaveState = False
        StyleId = -31
      end
    end
    object hfLastOpenDocs: TnscHideField
      Left = 16
      Top = 216
      Width = 649
      Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' '#1086#1090#1082#1088#1099#1090#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      ButtonCloseImage = 1
      ButtonImageList = dmMainMenuNew.ilSmallIcons
      ButtonOpenImage = 0
      ClientControl = tvLastOpenDocs
      ClientIndent = 20
      HeaderImage = 2
      Images = dmMainMenuNew.ilMainMenuNew
      LeftHeaderIndent = 20
      LeftImageIndent = 10
      Options = []
      TopHeaderIndent = 15
      TabOrder = 2
      StyleId = -33
      object tvLastOpenDocs: TnscTreeViewHotTruck
        Left = 20
        Top = 35
        Width = 629
        Height = 65
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        MultiStrokeItem = True
        ActionElementMode = l3_amSingleClick
        ViewOptions = [voShowInterRowSpace, voShowExpandable, voVariableItemHeight, voWithoutImages]
        ClearTreeStructOnSaveState = False
        StyleId = -32
      end
    end
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enEdit'
        Controls = <
          item
            Control = tvSearch
          end
          item
            Control = tvLawNews
          end
          item
            Control = tvLawSupport
          end
          item
            Control = tvReferences
          end
          item
            Control = tvLastOpenDocs
          end>
      end
      item
        Name = 'enTree'
        Controls = <
          item
            Control = tvSearch
          end
          item
            Control = tvLawNews
          end
          item
            Control = tvLawSupport
          end
          item
            Control = tvReferences
          end
          item
            Control = tvLastOpenDocs
          end>
      end>
    Left = 258
    Top = 146
  end
end

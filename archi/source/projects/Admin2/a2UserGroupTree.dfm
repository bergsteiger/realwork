object enUserTree: TenUserTree
  Left = 881
  Top = 307
  Width = 187
  Height = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  OnCloseQuery = vcmEntityFormCloseQuery
  OnCreate = vcmEntityFormCreate
  UserTypes = <
    item
      Name = 'utUsersTree'
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  OnGetStatus = vcmEntityFormGetStatus
  PixelsPerInch = 96
  TextHeight = 16
  object GroupUserTree: TvtOutliner
    Left = 0
    Top = 0
    Width = 171
    Height = 228
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 18
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    ShowRoot = True
    OnGetItemImage = GroupUserTreeGetItemImage
    OnGetItemFont = GroupUserTreeGetItemFont
    OnCurrentChanged = GroupUserTreeCurrentChanged
    OnValidateCurrent = GroupUserTreeValidateCurrent
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Height = -16
    ParentColor = False
    TabOrder = 0
    TabStop = True
    ViewOptions = [voShowIcons, voShowExpandable, voShowRoot, voShowLines, voShowOpenChip]
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enEdit'
        Operations = <
          item
            Name = 'opCreate'
            OnExecute = enEditopCreateExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end
          item
            Name = 'opDelete'
            OnTest = enEditopDeleteTest
            OnExecute = enEditopDeleteExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end>
        Category = 'enEdit'
      end
      item
        Name = 'enFile'
        Operations = <
          item
            Name = 'opSave'
            OnExecute = enToolsopSaveExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end
          item
            Name = 'opPrint'
            OnExecute = enToolsopPrintExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end>
      end
      item
        Name = 'enFind'
        Operations = <
          item
            Name = 'opSearch'
            OnExecute = enToolsopSearchExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end
          item
            Name = 'opSearchMore'
            OnTest = enToolsopSearchMoreTest
            OnExecute = enToolsopSearchMoreExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end>
      end
      item
        Name = 'enTools'
        Operations = <
          item
            Name = 'opBigBrother'
            OnTest = enToolsopBigBrotherTest
            OnExecute = enToolsopBigBrotherExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end>
      end
      item
        Name = 'enHelp'
        Operations = <
          item
            Name = 'opAbout'
            OnExecute = enHelpopAboutExecute
            Options = [vcm_ooShowInMainMenu]
          end>
      end>
    Left = 10
    Top = 18
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 
      #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (*.txt)|*.txt|'#1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (DOS) (*.txt)|*.txt|' +
      'Rich Text Format (*.rtf)|*.rtf|Everest (*.evd)|*.evd'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = #1047#1072#1087#1080#1089#1100' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1074' '#1092#1072#1081#1083
    Left = 43
    Top = 18
  end
  object PrintDialog: TPrintDialog
    Left = 76
    Top = 18
  end
end

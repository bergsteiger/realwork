object CustomizeFrm: TCustomizeFrm
  Left = 8
  Top = 8
  BorderIcons = [biSystemMenu]
  Caption = 'Customize'
  ClientHeight = 334
  ClientWidth = 371
  Color = clBtnFace
  Constraints.MinHeight = 361
  Constraints.MinWidth = 379
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = CloseMenu
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    371
    334)
  PixelsPerInch = 96
  TextHeight = 13
  object CloseBtn: TButton
    Left = 288
    Top = 304
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = CloseBtnClick
  end
  object Tabs: TPageControl
    Left = 6
    Top = 7
    Width = 358
    Height = 291
    ActivePage = ActionsTab
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 1
    object ToolbarsTab: TTabSheet
      Caption = 'Toolbars'
      DesignSize = (
        350
        263)
      object ToolbarsLbl: TLabel
        Left = 4
        Top = 1
        Width = 85
        Height = 13
        HelpType = htKeyword
        AutoSize = False
        Caption = 'Toolb&ars:'
        FocusControl = ActionBarList
      end
      object Label2: TLabel
        Left = 90
        Top = 1
        Width = 257
        Height = 13
        HelpType = htKeyword
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '(Checkmark toggles visibility)'
      end
      object ActionBarList: TCheckListBox
        Left = 4
        Top = 19
        Width = 237
        Height = 150
        OnClickCheck = ActionBarListClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = ActionBarListClick
      end
      object ResetBtn: TButton
        Left = 249
        Top = 19
        Width = 97
        Height = 21
        Action = ResetActn
        Anchors = [akTop, akRight]
        TabOrder = 2
      end
      object CaptionOptionsGrp: TGroupBox
        Left = 4
        Top = 174
        Width = 239
        Height = 82
        Anchors = [akLeft, akRight, akBottom]
        Caption = '&Toolbar Options'
        TabOrder = 1
        DesignSize = (
          239
          82)
        object Label4: TLabel
          Left = 10
          Top = 17
          Width = 226
          Height = 13
          HelpType = htKeyword
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = '&Caption Options'
        end
        object ApplyToAllChk: TCheckBox
          Left = 20
          Top = 60
          Width = 213
          Height = 16
          Action = ApplyToAllActn
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object CaptionOptionsCombo: TComboBox
          Left = 8
          Top = 34
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = CaptionOptionsComboChange
          Items.Strings = (
            'None'
            'Selective'
            'All')
        end
      end
    end
    object ActionsTab: TTabSheet
      Caption = 'Actions'
      ImageIndex = 1
      DesignSize = (
        350
        263)
      object InfoLbl: TLabel
        Left = 7
        Top = 226
        Width = 339
        Height = 38
        HelpType = htKeyword
        Anchors = [akLeft, akRight, akBottom]
        AutoSize = False
        Caption = 
          'To add actions to your application simply drag and drop from eit' +
          'her Categories or Actions onto an existing ActionBar.'
        WordWrap = True
      end
      object ListPanel: TPanel
        Left = 0
        Top = 32
        Width = 350
        Height = 135
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          350
          135)
        object ActionsCatLbl: TLabel
          Left = 6
          Top = 1
          Width = 116
          Height = 13
          HelpType = htKeyword
          AutoSize = False
          Caption = 'Cate&gories:'
          FocusControl = CatList
        end
        object ActionsActionsLbl: TLabel
          Left = 131
          Top = 1
          Width = 209
          Height = 13
          HelpType = htKeyword
          AutoSize = False
          Caption = 'A&ctions:'
          FocusControl = ActionsList
        end
        object CatList: TListBox
          Left = 3
          Top = 18
          Width = 119
          Height = 117
          Anchors = [akLeft, akTop, akBottom]
          DragMode = dmAutomatic
          ItemHeight = 13
          TabOrder = 0
          OnClick = CatListClick
          OnMeasureItem = ActionsListMeasureItem
          OnStartDrag = CatListStartDrag
        end
        object ActionsList: TListBox
          Left = 130
          Top = 18
          Width = 215
          Height = 117
          Style = lbOwnerDrawVariable
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clBtnFace
          DragMode = dmAutomatic
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 1
          OnClick = ActionsListClick
          OnData = ActionsListData
          OnDrawItem = ActionsListDrawItem
          OnMeasureItem = ActionsListMeasureItem
          OnStartDrag = ActionsListStartDrag
        end
      end
      object DescGroupBox: TGroupBox
        Left = 3
        Top = 171
        Width = 342
        Height = 48
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Description'
        TabOrder = 2
        DesignSize = (
          342
          48)
        object HintLbl: TLabel
          Left = 8
          Top = 14
          Width = 326
          Height = 29
          HelpType = htKeyword
          Anchors = [akLeft, akRight, akBottom]
          AutoSize = False
          Caption = 'HintLbl'
          WordWrap = True
        end
      end
      object ComboPanel: TPanel
        Left = 0
        Top = 0
        Width = 350
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ListCombo: TComboBox
          Left = 3
          Top = 4
          Width = 170
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnSelect = ListComboSelect
        end
      end
    end
    object OptionsTab: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      DesignSize = (
        350
        263)
      object PersonalizeLbl: TLabel
        Left = 5
        Top = 4
        Width = 159
        Height = 13
        HelpType = htKeyword
        Caption = 'Personalized Menus and Toolbars'
      end
      object OptionsBevel2: TBevel
        Left = 171
        Top = 10
        Width = 158
        Height = 2
        HelpType = htKeyword
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object OptionsBevel1: TBevel
        Left = 44
        Top = 117
        Width = 285
        Height = 2
        HelpType = htKeyword
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object OtherLbl: TLabel
        Left = 11
        Top = 111
        Width = 28
        Height = 13
        HelpType = htKeyword
        Caption = 'Other'
      end
      object Label1: TLabel
        Left = 21
        Top = 196
        Width = 84
        Height = 13
        HelpType = htKeyword
        Caption = '&Menu animations:'
        FocusControl = MenuAnimationStyles
      end
      object RecentlyUsedChk: TCheckBox
        Left = 21
        Top = 33
        Width = 242
        Height = 17
        Action = RecentlyUsedActn
        Caption = 'Me&nu shows recently used items first'
        TabOrder = 0
      end
      object ResetUsageBtn: TButton
        Left = 24
        Top = 67
        Width = 122
        Height = 21
        Action = ResetUsageDataActn
        TabOrder = 1
      end
      object LargeIconsChk: TCheckBox
        Left = 21
        Top = 131
        Width = 97
        Height = 17
        Action = LargeIconsActn
        TabOrder = 2
      end
      object ShowTipsChk: TCheckBox
        Left = 21
        Top = 150
        Width = 308
        Height = 17
        Action = ShowHintsActn
        TabOrder = 3
      end
      object ShortCutTipsChk: TCheckBox
        Left = 45
        Top = 169
        Width = 284
        Height = 17
        Action = ShowShortCutsInTipsActn
        TabOrder = 4
      end
      object MenuAnimationStyles: TComboBox
        Left = 114
        Top = 192
        Width = 112
        Height = 21
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 5
        Text = 'Default'
        OnChange = MenuAnimationStylesChange
        Items.Strings = (
          '(None)'
          'Default'
          'UnFold'
          'Slide'
          'Fade')
      end
    end
  end
  object SeparatorBtn: TButton
    Left = 7
    Top = 304
    Width = 147
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Drag to create Separators'
    DragMode = dmAutomatic
    TabOrder = 2
    OnStartDrag = SeparatorBtnStartDrag
  end
  object CloseMenu: TPopupMenu
    Left = 286
    Top = 4
    object CloseItem: TMenuItem
      Caption = '&Close'
      ShortCut = 27
      Visible = False
      OnClick = CloseBtnClick
    end
  end
  object ActionImages: TImageList
    Left = 314
    Top = 4
  end
  object ActionList1: TActionList
    Left = 258
    Top = 4
    object ResetActn: TAction
      Category = 'Toolbars'
      Caption = '&Reset...'
      OnExecute = ResetActnExecute
      OnUpdate = ResetActnUpdate
    end
    object CloseActn: TAction
      Category = 'Dialog'
      Caption = 'Close'
    end
    object ResetUsageDataActn: TAction
      Category = 'Options'
      Caption = '&Reset Usage Data'
      OnExecute = ResetUsageDataActnExecute
    end
    object RecentlyUsedActn: TAction
      Category = 'Options'
      Caption = 'Me&nu show recently used items first'
      OnExecute = RecentlyUsedActnExecute
      OnUpdate = RecentlyUsedActnUpdate
    end
    object FullMenusActn: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Show f&ull menus after a short delay'
      Enabled = False
    end
    object ShowHintsActn: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Show &tips on toolbars'
      OnExecute = ShowHintsActnExecute
      OnUpdate = ShowHintsActnUpdate
    end
    object ShowShortCutsInTipsActn: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Show shortcut keys in tips'
      OnExecute = ShowShortCutsInTipsActnExecute
    end
    object ApplyToAllActn: TAction
      Category = 'Toolbars'
      AutoCheck = True
      Caption = 'Apply caption &options to all toolbars'
      OnUpdate = ApplyToAllActnUpdate
    end
    object LargeIconsActn: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = '&Large icons'
      OnExecute = LargeIconsActnExecute
      OnUpdate = LargeIconsActnUpdate
    end
  end
end

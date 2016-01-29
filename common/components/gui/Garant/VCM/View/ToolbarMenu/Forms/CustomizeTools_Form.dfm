object CustomizeToolsForm: TCustomizeToolsForm
  Left = 387
  Top = 164
  Width = 610
  Height = 400
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Настройка панелей инструментов'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 480
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = vcmEntityFormRefCreate
  OnResize = vcmEntityFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object SingleTopPanel: TPanel
      Left = 0
      Top = 0
      Width = 594
      Height = 38
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TvtLabel
        Left = 7
        Top = 11
        Width = 115
        Height = 13
        Caption = 'Панель инструментов:'
      end
      object edToolbars: TEdit
        Left = 147
        Top = 7
        Width = 278
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
    end
    object MultipleTopPanel: TPanel
      Left = 0
      Top = 0
      Width = 594
      Height = 38
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        594
        38)
      object lbObject: TvtLabel
        Left = 8
        Top = 14
        Width = 129
        Height = 16
        AutoSize = False
        Caption = 'Объект системы:'
      end
      object ConfirmSavaLabel: TvtLabel
        Left = 48
        Top = 0
        Width = 261
        Height = 13
        Caption = 'Объект системы изменен. Применить изменения?'
        Visible = False
      end
      object cbObject: TvtComboBoxQS
        Left = 137
        Top = 11
        Width = 452
        Height = 21
        OnChange = cbObjectChange
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ComboStyle = ct_cbDropDownList
      end
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 321
    Width = 594
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      594
      41)
    object ResetToDefaultButton: TvtButton
      Left = 8
      Top = 8
      Width = 104
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Восстановить'
      TabOrder = 0
      OnClick = ResetToDefaultButtonClick
    end
    object btOk: TvtButton
      Left = 318
      Top = 8
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ок'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object btCancel: TvtButton
      Left = 408
      Top = 8
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Отмена'
      ModalResult = 2
      TabOrder = 4
    end
    object ResetAllToDefaultButton: TvtButton
      Left = 120
      Top = 8
      Width = 136
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Восстановить все'
      TabOrder = 1
      OnClick = ResetAllToDefaultButtonClick
    end
    object btApply: TvtButton
      Left = 509
      Top = 8
      Width = 81
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Применить'
      TabOrder = 3
      OnClick = btApplyClick
    end
  end
  object PageControl: TnscPageControl
    Left = 0
    Top = 38
    Width = 594
    Height = 283
    TabIndex = 0
    ActivePage = ToolBarsTabSheet
    Align = alClient
    TabOrder = 1
    ParentColor = False
    DockOrientation = doNoOrient
    object ToolBarsTabSheet: TElTabSheet
      Width = 590
      Height = 259
      PageControl = PageControl
      Caption = 'Панели инструментов'
      object pnToolbar: TPanel
        Left = 0
        Top = 0
        Width = 590
        Height = 38
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          590
          38)
        object lbToolbar: TvtLabel
          Left = 7
          Top = 13
          Width = 137
          Height = 13
          AutoSize = False
          Caption = 'Панель инструментов:'
        end
        object cbToolBar: TvtComboBoxQS
          Left = 137
          Top = 9
          Width = 286
          Height = 21
          OnChange = cbToolBarChange
          Anchors = [akLeft, akTop, akRight]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ComboStyle = ct_cbDropDownList
        end
        object btAdd: TvtButton
          Left = 526
          Top = 9
          Width = 65
          Height = 19
          Anchors = [akTop, akRight]
          Caption = 'Добавить'
          Enabled = False
          TabOrder = 1
        end
      end
      object CenterPanel: TPanel
        Left = 0
        Top = 38
        Width = 590
        Height = 221
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          590
          221)
        object AvailableOperationsLabel: TvtLabel
          Left = 8
          Top = 7
          Width = 111
          Height = 13
          Caption = 'Доступные операции:'
        end
        object SelectedOperationsLabel: TvtLabel
          Left = 226
          Top = 7
          Width = 99
          Height = 13
          Caption = 'Текущие операции:'
        end
        object RemoveBitBtn: TBitBtn
          Left = 192
          Top = 71
          Width = 25
          Height = 25
          TabOrder = 1
          OnClick = RemoveBitBtnClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0000000808000000000C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080
            8000000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C00000008080008080008080008080008080008080008080000000
            00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080800080800080
            8000808000808000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C00000008080008080008080008080008080008080008080000000
            00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080
            8000000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0000000808000000000C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        end
        object AddBitBtn: TBitBtn
          Left = 192
          Top = 40
          Width = 25
          Height = 25
          TabOrder = 0
          OnClick = AddBitBtnClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000000
            0000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0000000808000808000808000808000808000808000808000000000C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080800080800080
            8000808000808000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0000000808000808000808000808000808000808000808000000000C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000000
            0000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        end
        object WhotShowRadioGroup: TGroupBox
          Left = 455
          Top = 151
          Width = 130
          Height = 58
          Anchors = [akRight, akBottom]
          Caption = ' Отображать '
          TabOrder = 4
          OnClick = WhotShowRadioGroupClick
          object cbIcon: TvtRadioButton
            Left = 8
            Top = 16
            Width = 117
            Height = 17
            Caption = 'Значок'
            TabOrder = 0
            OnClick = WhotShowRadioGroupClick
          end
          object cbTextAndIcon: TvtRadioButton
            Left = 8
            Top = 37
            Width = 118
            Height = 17
            Caption = 'Текст и значок'
            TabOrder = 1
            OnClick = WhotShowRadioGroupClick
          end
        end
        object DownBitBtn: TBitBtn
          Left = 455
          Top = 77
          Width = 24
          Height = 25
          Anchors = [akTop, akRight]
          TabOrder = 3
          OnClick = DownBitBtnClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080
            8000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080800080
            8000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0000000808000808000808000808000808000808000808000000000C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000080800080
            8000808000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080
            8000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000
            0000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        end
        object UpBitBtn: TBitBtn
          Left = 455
          Top = 46
          Width = 24
          Height = 25
          Anchors = [akTop, akRight]
          TabOrder = 2
          OnClick = UpBitBtnClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000
            0000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080
            8000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000080800080
            8000808000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0000000808000808000808000808000808000808000808000000000C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080800080800080
            8000808000808000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0000000808000808000808000000000C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000080
            8000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        end
      end
      object pnToolbarProps: TPanel
        Left = 0
        Top = 259
        Width = 590
        Height = 0
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        DesignSize = (
          590
          0)
        object IconSizeLabel: TvtLabel
          Left = 313
          Top = -16
          Width = 92
          Height = 13
          Alignment = taRightJustify
          Anchors = [akRight, akBottom]
          AutoSize = False
          Caption = 'Размер значков:'
          Visible = False
        end
        object chkShowMisplaced: TvtCheckBox
          Left = 8
          Top = -20
          Width = 246
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Показывать только не размещенные'
          Checked = True
          State = cbChecked
          TabOrder = 0
          Visible = False
        end
        object IconSizeComboBox: TvtComboBoxQS
          Left = 410
          Top = -24
          Width = 130
          Height = 21
          Anchors = [akRight, akBottom]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          ComboStyle = ct_cbDropDownList
        end
      end
    end
    object ShortCutsTabSheet: TElTabSheet
      Width = 590
      Height = 259
      PageControl = PageControl
      ImageIndex = 1
      Caption = 'Быстрый вызов'
      Visible = False
      DesignSize = (
        590
        259)
      object AllOperationsLabel: TvtLabel
        Left = 8
        Top = 7
        Width = 53
        Height = 13
        Caption = 'Операции:'
      end
      object ShortCutLabel: TvtLabel
        Left = 303
        Top = 95
        Width = 84
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Быстрый вызов:'
      end
      object DescriptionLabel: TvtLabel
        Left = 300
        Top = 7
        Width = 53
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Описание:'
      end
      object DescriptionContentLabel: TvtLabel
        Left = 300
        Top = 24
        Width = 281
        Height = 65
        Anchors = [akTop, akRight]
        AutoSize = False
        Transparent = True
        WordWrap = True
      end
      object lwShortCuts: TListView
        Left = 303
        Top = 136
        Width = 206
        Height = 118
        Anchors = [akTop, akRight, akBottom]
        Columns = <
          item
            AutoSize = True
          end>
        DragMode = dmAutomatic
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        TabOrder = 3
        ViewStyle = vsReport
        OnChange = lwShortCutsChange
      end
      object ShortCutEdit: TeeShortCutEdit
        Left = 303
        Top = 110
        Width = 135
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        TabOrder = 0
        OnChange = ShortCutEditChange
      end
      object RemoveButton: TvtButton
        Left = 516
        Top = 141
        Width = 67
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Удалить'
        TabOrder = 4
        OnClick = RemoveButtonClick
      end
      object AddButton: TvtButton
        Left = 516
        Top = 109
        Width = 67
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Добавить'
        TabOrder = 2
        OnClick = AddButtonClick
      end
      object ClearShortcutButton: TvtButton
        Left = 444
        Top = 109
        Width = 65
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Очистить'
        TabOrder = 1
        OnClick = ClearShortcutButtonClick
      end
    end
    object MiscTabSheet: TElTabSheet
      Width = 590
      Height = 259
      PageControl = PageControl
      ImageIndex = 2
      Caption = 'Дополнительные настройки'
      Visible = False
      object Bevel1: TBevel
        Left = 8
        Top = 40
        Width = 529
        Height = 9
        Shape = bsTopLine
      end
      object Label2: TvtLabel
        Left = 8
        Top = 16
        Width = 489
        Height = 17
        AutoSize = False
        Caption = 
          'Эти настройки влияют на отображение кнопок на всех панелях инстр' +
          'ументов.'
      end
      object gbGlyphSize: TGroupBox
        Left = 8
        Top = 57
        Width = 192
        Height = 105
        Caption = ' Размер кнопок '
        TabOrder = 0
        OnClick = rgGlyphSizeClick
        object rbGlyphSizeAuto: TvtRadioButton
          Left = 8
          Top = 16
          Width = 117
          Height = 17
          Caption = 'автоматически'
          TabOrder = 0
          OnClick = rgGlyphSizeClick
        end
        object rbGlyphSizeSmall: TvtRadioButton
          Left = 8
          Top = 37
          Width = 117
          Height = 17
          Caption = 'маленькие'
          TabOrder = 1
          OnClick = rgGlyphSizeClick
        end
        object rbGlyphSizeMedium: TvtRadioButton
          Left = 8
          Top = 58
          Width = 117
          Height = 17
          Caption = 'средние'
          TabOrder = 2
          OnClick = rgGlyphSizeClick
        end
        object rbGlyphSizeLarge: TvtRadioButton
          Left = 8
          Top = 79
          Width = 117
          Height = 17
          Caption = 'большие'
          TabOrder = 3
          OnClick = rgGlyphSizeClick
        end
      end
      object gbGlyphColor: TGroupBox
        Left = 216
        Top = 57
        Width = 193
        Height = 105
        Caption = ' Цветность изображений '
        TabOrder = 1
        OnClick = rgGlyphColorClick
        object rbGlyphColorAuto: TvtRadioButton
          Left = 8
          Top = 16
          Width = 117
          Height = 17
          Caption = 'автоматически'
          TabOrder = 0
          OnClick = rgGlyphColorClick
        end
        object rbGlyphColor16: TvtRadioButton
          Left = 8
          Top = 37
          Width = 117
          Height = 17
          Caption = '16 цветов'
          TabOrder = 1
          OnClick = rgGlyphColorClick
        end
        object rbGlyphColor256: TvtRadioButton
          Left = 8
          Top = 58
          Width = 117
          Height = 17
          Caption = '256 цветов'
          TabOrder = 2
          OnClick = rgGlyphColorClick
        end
        object rbGlyphColorFull: TvtRadioButton
          Left = 8
          Top = 79
          Width = 117
          Height = 17
          Caption = 'полноцветные'
          TabOrder = 3
          OnClick = rgGlyphColorClick
        end
      end
    end
  end
end

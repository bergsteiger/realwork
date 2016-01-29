object SQLEditForm: TSQLEditForm
  Left = 8
  Top = 8
  Action = FormUpdateAction
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'CommandText Editor'
  ClientHeight = 323
  ClientWidth = 524
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 520
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 524
    Height = 323
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object MetaInfoSQLSplitter: TSplitter
      Left = 159
      Top = 0
      Height = 288
      MinSize = 100
      OnCanResize = MetaInfoSQLSplitterCanResize
      OnMoved = MetaInfoSQLSplitterMoved
      ExplicitHeight = 0
    end
    object ButtonPanel: TPanel
      Left = 0
      Top = 288
      Width = 524
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        524
        35)
      object Image1: TImage
        Left = 51
        Top = 16
        Width = 10
        Height = 6
        AutoSize = True
        Picture.Data = {
          07544269746D6170A6000000424DA60000000000000076000000280000000A00
          000006000000010004000000000030000000CE0E0000C40E0000100000000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00333333333300000030999999030000003309999033000000333099033300
          000033330033330000003333333333000000}
        Transparent = True
        Visible = False
      end
      object OkButton: TButton
        Left = 271
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object CancelButton: TButton
        Left = 356
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object HelpButton: TButton
        Left = 441
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Help'
        TabOrder = 2
        OnClick = HelpButtonClick
      end
    end
    object MetaInfoPanel: TPanel
      Left = 0
      Top = 0
      Width = 159
      Height = 288
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object TableFieldsSplitter: TSplitter
        Left = 0
        Top = 115
        Width = 159
        Height = 3
        Cursor = crVSplit
        Align = alTop
        Beveled = True
        MinSize = 1
        OnCanResize = TableFieldsSplitterCanResize
        ExplicitHeight = 0
      end
      object TableListPanel: TPanel
        Left = 0
        Top = 0
        Width = 159
        Height = 115
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object TablePanel: TPanel
          Left = 0
          Top = 20
          Width = 159
          Height = 95
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            159
            95)
          object TableList: TListBox
            Left = 0
            Top = 0
            Width = 159
            Height = 73
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
            TabOrder = 0
            OnClick = TableListClick
            OnDblClick = AddTableButtonClick
          end
          object AddTableButton: TButton
            Left = 2
            Top = 73
            Width = 156
            Height = 22
            Anchors = [akLeft, akRight, akBottom]
            Caption = 'Add T&able to SQL'
            TabOrder = 1
            OnClick = AddTableButtonClick
          end
        end
        object TableLabelPanel: TPanel
          Left = 0
          Top = 0
          Width = 159
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object TableListLabel: TLabel
            Left = 3
            Top = 3
            Width = 35
            Height = 13
            Caption = '&Tables:'
            FocusControl = TableList
          end
        end
      end
      object FieldsPanel: TPanel
        Left = 0
        Top = 118
        Width = 159
        Height = 170
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          159
          170)
        object FieldListLabel: TLabel
          Left = 3
          Top = 3
          Width = 31
          Height = 13
          Caption = '&Fields:'
          FocusControl = FieldList
        end
        object FieldList: TListBox
          Left = 0
          Top = 19
          Width = 159
          Height = 126
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 0
          OnDblClick = AddFieldButtonClick
        end
        object AddFieldButton: TButton
          Left = 2
          Top = 146
          Width = 156
          Height = 22
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Add F&ield to SQL'
          TabOrder = 1
          OnClick = AddFieldButtonClick
        end
      end
    end
    object SqlPanel: TPanel
      Left = 162
      Top = 0
      Width = 362
      Height = 288
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object SQLMemo: TMemo
        Left = 0
        Top = 20
        Width = 362
        Height = 268
        Align = alClient
        HideSelection = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        OnEnter = SQLMemoEnter
        OnExit = SQLMemoExit
      end
      object SqlLabelPanel: TPanel
        Left = 0
        Top = 0
        Width = 362
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object SQLLabel: TLabel
          Left = 6
          Top = 3
          Width = 23
          Height = 13
          Caption = '&SQL:'
          FocusControl = SQLMemo
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 256
    Top = 168
    object FormUpdateAction: TAction
      Caption = 'CommandText Editor'
      OnUpdate = FormUpdateActionUpdate
    end
  end
end

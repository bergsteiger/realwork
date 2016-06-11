object TreeViewItems: TTreeViewItems
  Left = 237
  Top = 142
  HelpContext = 26090
  ActiveControl = TreeView
  BorderIcons = [biSystemMenu]
  Caption = 'TreeView Items Editor'
  ClientHeight = 227
  ClientWidth = 527
  Color = clBtnFace
  Constraints.MinHeight = 236
  Constraints.MinWidth = 423
  ParentFont = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    527
    227)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 5
    Width = 293
    Height = 183
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '&Items'
    TabOrder = 0
    DesignSize = (
      293
      183)
    object New: TButton
      Left = 159
      Top = 20
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&New Item'
      Default = True
      TabOrder = 1
      OnClick = NewClick
      ExplicitLeft = 161
    end
    object Delete: TButton
      Left = 159
      Top = 78
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      TabOrder = 3
      OnClick = DeleteClick
      ExplicitLeft = 161
    end
    object TreeView: TTreeView
      Left = 8
      Top = 17
      Width = 144
      Height = 156
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      HideSelection = False
      Indent = 19
      TabOrder = 0
      OnChange = TreeViewChange
      OnChanging = TreeViewChanging
      OnDragDrop = TreeViewDragDrop
      OnDragOver = TreeViewDragOver
      OnEdited = TreeViewEdited
      ExplicitWidth = 146
    end
    object NewSub: TButton
      Left = 159
      Top = 49
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'N&ew SubItem'
      TabOrder = 2
      OnClick = NewSubClick
      ExplicitLeft = 161
    end
    object Load: TButton
      Left = 159
      Top = 107
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Load'
      TabOrder = 4
      OnClick = LoadClick
      ExplicitLeft = 161
    end
  end
  object PropGroupBox: TGroupBox
    Left = 305
    Top = 5
    Width = 214
    Height = 183
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Item Properties'
    TabOrder = 1
    DesignSize = (
      214
      183)
    object Label1: TLabel
      Left = 5
      Top = 25
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Text:'
      FocusControl = TextEdit
    end
    object Label2: TLabel
      Left = 5
      Top = 52
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'I&mage Index:'
      FocusControl = Image
    end
    object Label3: TLabel
      Left = 5
      Top = 107
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'State Inde&x:'
      FocusControl = StateImage
    end
    object Label4: TLabel
      Left = 5
      Top = 80
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Selected Index:'
      FocusControl = SelectedIndex
    end
    object Label5: TLabel
      Left = 5
      Top = 134
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Expanded Index:'
      FocusControl = ExpandedIndex
    end
    object TextEdit: TEdit
      Left = 124
      Top = 22
      Width = 79
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = ValueChange
      OnExit = TextEditExit
    end
    object Image: TEdit
      Left = 124
      Top = 49
      Width = 39
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = ValueChange
      OnExit = ImageExit
    end
    object StateImage: TEdit
      Left = 124
      Top = 104
      Width = 39
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      OnChange = ValueChange
      OnExit = StateImageExit
    end
    object SelectedIndex: TEdit
      Left = 124
      Top = 77
      Width = 39
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      OnChange = ValueChange
      OnExit = SelectedIndexExit
    end
    object ExpandedIndex: TEdit
      Left = 124
      Top = 131
      Width = 39
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      OnChange = ValueChange
      OnExit = ExpandedIndexExit
    end
    object cbEnabled: TCheckBox
      Left = 10
      Top = 158
      Width = 201
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Enabled'
      TabOrder = 5
      OnClick = EnabledChanged
      ExplicitWidth = 235
    end
  end
  object OkButton: TButton
    Left = 192
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 176
  end
  object Cancel: TButton
    Left = 275
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 259
  end
  object Apply: TButton
    Left = 358
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Apply'
    TabOrder = 4
    OnClick = ApplyClick
    ExplicitLeft = 342
  end
  object Help: TButton
    Left = 441
    Top = 196
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 5
    OnClick = HelpClick
    ExplicitLeft = 425
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All Files(*.*)|*.*'
    Left = 141
    Top = 194
  end
end

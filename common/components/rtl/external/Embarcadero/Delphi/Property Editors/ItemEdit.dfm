object ListViewItems: TListViewItems
  Left = 190
  Top = 158
  HelpContext = 26100
  ActiveControl = TreeView
  BorderIcons = [biSystemMenu]
  Caption = 'ListView Items Editor'
  ClientHeight = 221
  ClientWidth = 576
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = True
  PopupMode = pmAuto
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    576
    221)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 5
    Width = 317
    Height = 177
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '&Items'
    TabOrder = 0
    ExplicitWidth = 267
    DesignSize = (
      317
      177)
    object New: TButton
      Left = 185
      Top = 20
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&New Item'
      Default = True
      TabOrder = 1
      OnClick = NewClick
    end
    object Delete: TButton
      Left = 185
      Top = 81
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      TabOrder = 3
      OnClick = DeleteClick
    end
    object TreeView: TTreeView
      Left = 9
      Top = 13
      Width = 169
      Height = 154
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
      OnEditing = TreeViewEditing
      OnKeyDown = TreeViewKeyDown
    end
    object NewSub: TButton
      Left = 185
      Top = 51
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'N&ew SubItem'
      TabOrder = 2
      OnClick = NewSubClick
    end
  end
  object PropGroupBox: TGroupBox
    Left = 330
    Top = 5
    Width = 240
    Height = 177
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Item Properties'
    TabOrder = 1
    ExplicitLeft = 280
    DesignSize = (
      240
      177)
    object Label1: TLabel
      Left = 5
      Top = 25
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Caption:'
      FocusControl = CaptionEdit
    end
    object Label2: TLabel
      Left = 5
      Top = 53
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'I&mage Index:'
      FocusControl = Image
    end
    object Label3: TLabel
      Left = 5
      Top = 82
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&State Index:'
      FocusControl = StateImage
    end
    object Label4: TLabel
      Left = 5
      Top = 108
      Width = 115
      Height = 13
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Group:'
    end
    object CaptionEdit: TEdit
      Left = 122
      Top = 21
      Width = 111
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnChange = ValueChange
      OnExit = CaptionEditExit
    end
    object Image: TEdit
      Left = 122
      Top = 49
      Width = 45
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnChange = ValueChange
      OnExit = ImageExit
    end
    object StateImage: TEdit
      Left = 122
      Top = 78
      Width = 45
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnChange = ValueChange
      OnExit = StateImageExit
    end
    object cbGroupID: TComboBox
      Left = 122
      Top = 105
      Width = 111
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 13
      TabOrder = 3
      OnChange = cbGroupIDChange
    end
  end
  object OkButton: TButton
    Left = 249
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 199
  end
  object Cancel: TButton
    Left = 331
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 281
  end
  object Apply: TButton
    Left = 413
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Apply'
    TabOrder = 4
    OnClick = ApplyClick
    ExplicitLeft = 363
  end
  object Button7: TButton
    Left = 495
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 5
    OnClick = Button7Click
    ExplicitLeft = 445
  end
end

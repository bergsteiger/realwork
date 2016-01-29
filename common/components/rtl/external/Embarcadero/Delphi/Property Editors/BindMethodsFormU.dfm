object BindMethodsForm: TBindMethodsForm
  Left = 209
  Top = 219
  HelpContext = 16206
  BorderIcons = [biSystemMenu]
  Caption = 'Methods'
  ClientHeight = 466
  ClientWidth = 472
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 254
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    472
    466)
  PixelsPerInch = 96
  TextHeight = 13
  object HelpBtn: TButton
    Left = 389
    Top = 436
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Help'
    TabOrder = 4
    OnClick = HelpBtnClick
  end
  object OKBtn: TButton
    Left = 227
    Top = 436
    Width = 75
    Height = 25
    Action = AcceptAction
    Anchors = [akRight, akBottom]
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 308
    Top = 436
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 456
    Height = 422
    Anchors = [akLeft, akTop, akRight, akBottom]
    Checkboxes = True
    Columns = <
      item
        Caption = 'Method Name'
        Width = 200
      end
      item
        Caption = 'Unit Name'
        Width = 100
      end
      item
        Caption = 'Framework'
        Width = 100
      end>
    ColumnClick = False
    ParentShowHint = False
    ShowHint = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = ListView1Change
    OnClick = ListView1Click
    OnInfoTip = ListView1InfoTip
  end
  object CheckBoxSelectAll: TCheckBox
    Left = 8
    Top = 440
    Width = 213
    Height = 17
    Action = ActionSelectAll
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 148
    Top = 84
    object AcceptAction: TAction
      Caption = 'OK'
      Enabled = False
      ShortCut = 0
      OnUpdate = AcceptActionUpdate
    end
    object ActionSelectAll: TAction
      Caption = '&Select/Unselect All'
      ShortCut = 0
      OnExecute = actSelectAllExecute
      OnUpdate = actnSelectAllUpdate
    end
  end
end

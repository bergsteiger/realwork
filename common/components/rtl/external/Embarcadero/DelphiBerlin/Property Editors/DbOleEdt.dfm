object DataBindForm: TDataBindForm
  Left = 591
  Top = 177
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'ActiveX Control Data Bindings Editor'
  ClientHeight = 264
  ClientWidth = 369
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 225
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 232
      Top = 10
      Width = 76
      Height = 13
      Caption = '&Property Name:'
      FocusControl = PropNameLB
    end
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 56
      Height = 13
      Caption = '&Field Name:'
      FocusControl = FieldNameLB
    end
    object Label3: TLabel
      Left = 7
      Top = 113
      Width = 129
      Height = 13
      Caption = 'Bo&und Properties to Fields:'
      FocusControl = BoundLB
    end
    object PropNameLB: TListBox
      Left = 232
      Top = 28
      Width = 129
      Height = 77
      ItemHeight = 13
      TabOrder = 0
      OnClick = FieldNameLBClick
      OnDblClick = PropNameLBDblClick
    end
    object FieldNameLB: TListBox
      Left = 8
      Top = 28
      Width = 129
      Height = 77
      ItemHeight = 13
      TabOrder = 1
      OnClick = FieldNameLBClick
      OnDblClick = PropNameLBDblClick
    end
    object BindBtn: TButton
      Left = 140
      Top = 53
      Width = 90
      Height = 25
      Caption = '<- &Bind ->'
      TabOrder = 2
      OnClick = BindBtnClick
    end
    object BoundLB: TListBox
      Left = 8
      Top = 131
      Width = 265
      Height = 79
      ItemHeight = 13
      TabOrder = 3
    end
    object DeleteBtn: TButton
      Left = 286
      Top = 131
      Width = 75
      Height = 25
      Caption = '&Delete'
      TabOrder = 4
      OnClick = DeleteBtnClick
    end
    object ClearBtn: TButton
      Left = 286
      Top = 162
      Width = 75
      Height = 25
      Caption = 'C&lear'
      TabOrder = 5
      OnClick = ClearBtnClick
    end
  end
  object OkBtn: TButton
    Left = 117
    Top = 232
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 202
    Top = 232
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object HelpBtn: TButton
    Left = 287
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 3
    OnClick = HelpBtnClick
  end
end

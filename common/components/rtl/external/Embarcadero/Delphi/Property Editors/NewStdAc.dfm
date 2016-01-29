object NewStdActionDlg: TNewStdActionDlg
  Left = 209
  Top = 219
  HelpContext = 26171
  BorderIcons = [biSystemMenu]
  Caption = 'Standard Action Classes'
  ClientHeight = 352
  ClientWidth = 243
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 259
  ParentFont = True
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 237
    Height = 13
    Align = alTop
    Caption = '&Available Action Classes:'
    ExplicitWidth = 119
  end
  object Panel1: TPanel
    Left = 0
    Top = 321
    Width = 243
    Height = 31
    Margins.Top = 0
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object HelpBtn: TButton
      AlignWithMargins = True
      Left = 165
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Caption = 'Help'
      TabOrder = 2
      OnClick = HelpBtnClick
    end
    object OKBtn: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 25
      Action = AcceptAction
      Align = alRight
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 180
    Top = 12
    object AcceptAction: TAction
      Caption = 'OK'
      Enabled = False
      OnUpdate = AcceptActionUpdate
    end
  end
end

object FilterEditor: TFilterEditor
  Left = 248
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Filter Editor'
  ClientHeight = 221
  ClientWidth = 367
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 9
    Width = 351
    Height = 172
  end
  object OKButton: TButton
    Left = 124
    Top = 190
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 204
    Top = 190
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object HelpButton: TButton
    Left = 284
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 2
    OnClick = HelpBtnClick
  end
end

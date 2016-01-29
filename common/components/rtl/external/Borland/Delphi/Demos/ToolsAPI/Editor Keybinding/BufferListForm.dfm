object BufferListFrm: TBufferListFrm
  Left = 311
  Top = 285
  Width = 628
  Height = 530
  Caption = 'Buffer List'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    612
    494)
  PixelsPerInch = 96
  TextHeight = 13
  object BufferListBox: TListBox
    Left = 8
    Top = 8
    Width = 516
    Height = 477
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = BufferListBoxDblClick
  end
  object OKButton: TButton
    Left = 531
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 531
    Top = 40
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end

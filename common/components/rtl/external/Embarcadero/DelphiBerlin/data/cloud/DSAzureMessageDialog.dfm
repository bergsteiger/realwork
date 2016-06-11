object AzureMsgDialog: TAzureMsgDialog
  Left = 227
  Top = 108
  BorderIcons = [biSystemMenu]
  Caption = 'Azure Queue Message'
  ClientHeight = 218
  ClientWidth = 484
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 350
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    484
    218)
  PixelsPerInch = 96
  TextHeight = 13
  object ValueList: TValueListEditor
    Left = 8
    Top = 8
    Width = 468
    Height = 174
    Anchors = [akLeft, akTop, akRight, akBottom]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    TitleCaptions.Strings = (
      'Field'
      'Value')
    ColWidths = (
      150
      312)
  end
  object closeButton: TButton
    Left = 401
    Top = 188
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = closeButtonClick
  end
end

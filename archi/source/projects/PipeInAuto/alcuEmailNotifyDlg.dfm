object EmailNotifyDialog: TEmailNotifyDialog
  Left = 2071
  Top = 243
  ActiveControl = editAddress
  BorderStyle = bsDialog
  Caption = #1040#1076#1088#1077#1089' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
  ClientHeight = 326
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 281
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 79
    Top = 296
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object CancelBtn: TButton
    Left = 159
    Top = 296
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
  object editAddress: TLabeledEdit
    Left = 16
    Top = 28
    Width = 281
    Height = 23
    EditLabel.Width = 36
    EditLabel.Height = 15
    EditLabel.Caption = 'E-mail'
    TabOrder = 0
  end
  object editComment: TLabeledEdit
    Left = 16
    Top = 68
    Width = 281
    Height = 23
    EditLabel.Width = 57
    EditLabel.Height = 15
    EditLabel.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    TabOrder = 1
  end
  object EventsList: TvtStringLister
    Left = 16
    Top = 96
    Width = 281
    Height = 161
    Sorted = False
    AlienSource = False
    AutoRowHeight = False
    IntegralHeight = False
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    PickedList = True
    Font.Height = -12
    ParentColor = False
    TabOrder = 2
    TabStop = True
  end
  object cbOnlyErrors: TCheckBox
    Left = 16
    Top = 264
    Width = 105
    Height = 17
    Caption = #1058#1086#1083#1100#1082#1086' '#1086#1096#1080#1073#1082#1080
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end

inherited ddTuneTOCDlg: TddTuneTOCDlg
  Left = 248
  Top = 130
  Width = 707
  Height = 366
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
  Constraints.MinHeight = 300
  Constraints.MinWidth = 600
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited FormPanel: TPanel
    Width = 699
    Height = 339
    TabOrder = 1
    inherited pnButtons: TPanel
      Top = 296
      Width = 697
      inherited btOk: TBitBtn
        Left = 494
        Anchors = [akTop, akRight]
      end
      inherited btCancel: TBitBtn
        Left = 593
        Anchors = [akTop, akRight]
        Caption = #1054#1090#1084#1077#1085#1072
      end
    end
    inherited pnMain: TPanel
      Width = 697
      Height = 295
      object Label1: TLabel
        Left = 5
        Top = 219
        Width = 141
        Height = 16
        Hint = #1044#1086#1073#1072#1074#1083#1103#1077#1090' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1082' '#1101#1083#1077#1084#1077#1085#1090#1091' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        Anchors = [akLeft, akBottom]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1102
      end
      object cbAddBefore: TCheckBox
        Left = 389
        Top = 219
        Width = 169
        Height = 19
        Hint = #1044#1086#1073#1072#1074#1083#1103#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1074' '#1085#1072#1095#1072#1083#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        Anchors = [akLeft, akBottom]
        Caption = #1055#1077#1088#1077#1076' '#1090#1077#1082#1089#1090#1086#1084
        TabOrder = 0
      end
      object comboAddSpec: TComboBox
        Left = 171
        Top = 214
        Width = 210
        Height = 24
        Hint = #1044#1086#1073#1072#1074#1083#1103#1077#1090' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1082' '#1101#1083#1077#1084#1077#1085#1090#1091' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        Style = csDropDownList
        Anchors = [akLeft, akBottom]
        ItemHeight = 16
        TabOrder = 1
        Items.Strings = (
          #1085#1080#1095#1077#1075#1086' '#1085#1077' '#1076#1086#1073#1072#1074#1083#1103#1090#1100
          '('#1089#1090'.'#1089#1090'. NN - NN)'
          '('#1089#1090'.'#1089#1090'. NNN - NNN)'
          '('#1087'.'#1087'. NN- NN)'
          '('#1087'.'#1087'. NNN - NNN)'
          #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' N.'
          #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' NN.'
          #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' NNN.')
      end
      object cbFindNearest: TCheckBox
        Left = 9
        Top = 245
        Width = 251
        Height = 20
        Hint = #1055#1086#1080#1089#1082' '#1073#1083#1080#1078#1072#1081#1096#1077#1081' '#1084#1077#1090#1082#1080' '#1082' '#1085#1072#1095#1072#1083#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Anchors = [akLeft, akBottom]
        Caption = #1048#1089#1082#1072#1090#1100' '#1073#1083#1080#1078#1072#1081#1096#1091#1102' '#1084#1077#1090#1082#1091
        TabOrder = 2
      end
      object cbInsertSubTOC: TCheckBox
        Left = 9
        Top = 267
        Width = 351
        Height = 20
        Hint = 
          #1042#1089#1090#1072#1074#1083#1103#1090#1100' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103' '#1074#1090#1086#1088#1086#1075#1086' '#1091#1088#1086#1074#1085#1103' '#1087#1086#1076' '#1079#1072#1075#1086#1083#1086#1074#1082#1086#1084' '#1087#1077#1088#1074#1086#1075#1086' '#1091#1088#1086#1074#1085 +
          #1103
        Anchors = [akLeft, akBottom]
        Caption = #1042#1089#1090#1072#1074#1083#1103#1090#1100' '#1087#1086#1076#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        TabOrder = 3
      end
      object PromoteButton: TButton
        Left = 558
        Top = 8
        Width = 132
        Height = 33
        Hint = #1055#1086#1074#1099#1089#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        Anchors = [akTop, akRight]
        Caption = #1055#1086#1074#1099#1089#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100
        TabOrder = 4
        OnClick = PromoteButtonClick
      end
      object DemoteButton: TButton
        Left = 558
        Top = 49
        Width = 132
        Height = 33
        Hint = #1055#1086#1085#1080#1079#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
        Anchors = [akTop, akRight]
        Caption = #1055#1086#1085#1080#1079#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100
        TabOrder = 5
        OnClick = DemoteButtonClick
      end
      object DeleteButton: TButton
        Left = 558
        Top = 90
        Width = 132
        Height = 32
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
        Anchors = [akTop, akRight]
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 6
        OnClick = DeleteButtonClick
      end
      object EditButton: TButton
        Left = 558
        Top = 130
        Width = 132
        Height = 33
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
        Anchors = [akTop, akRight]
        Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
        TabOrder = 7
        OnClick = EditButtonClick
      end
    end
  end
  object TOCListBox: TvtStringLister
    Left = 5
    Top = 9
    Width = 544
    Height = 196
    Sorted = False
    AlienSource = False
    AutoRowHeight = False
    Header.Left = 0
    Header.Top = 0
    Header.Width = 540
    Header.Height = 0
    Header.Sections = <>
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    ReadOnly = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    TabStop = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnKeyDown = TOCLIstBoxKeyDown
    OnActionElement = TOCListBoxActionElement
  end
end

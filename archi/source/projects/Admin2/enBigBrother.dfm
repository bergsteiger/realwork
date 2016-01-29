object enBigBrotherForm: TenBigBrotherForm
  Left = 368
  Top = 258
  Width = 535
  Height = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  OnCreate = vcmEntityFormCreate
  UserTypes = <
    item
      Name = 'ugBigBrother'
      Caption = #1041#1086#1083#1100#1096#1086#1081' '#1041#1088#1072#1090
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  PixelsPerInch = 96
  TextHeight = 16
  object BigBrotherTree: TvtOutliner
    Left = 0
    Top = 159
    Width = 519
    Height = 184
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Height = -16
    ParentColor = False
    TabOrder = 0
    TabStop = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 159
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      519
      159)
    object lblTarget: TLabel
      Left = 10
      Top = 9
      Width = 77
      Height = 23
      Caption = 'lblTarget'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 39
      Width = 161
      Height = 18
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1082#1086#1085#1090#1088#1086#1083#1103
      FocusControl = deStart
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 197
      Top = 39
      Width = 185
      Height = 18
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1082#1086#1085#1090#1088#1086#1083#1103
      FocusControl = deFinish
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 98
      Width = 69
      Height = 18
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090
      FocusControl = edDocNum
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object deStart: TvtDateEdit
      Left = 10
      Top = 59
      Width = 168
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -16
      Style = csDropDown
      TabOrder = 0
    end
    object deFinish: TvtDateEdit
      Left = 197
      Top = 59
      Width = 169
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -16
      Style = csDropDown
      TabOrder = 1
    end
    object btnRefresh: TButton
      Left = 401
      Top = 116
      Width = 109
      Height = 30
      Anchors = [akTop, akRight]
      Caption = #1059#1079#1085#1072#1090#1100' '#1074#1089#1077
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnRefreshClick
    end
    object edDocNum: TEdit
      Left = 10
      Top = 118
      Width = 129
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 16
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edDocNumKeyPress
    end
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enFile'
        Operations = <
          item
            Name = 'opSave'
            OnTest = enFileopSaveTest
            OnExecute = enFileopSaveExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInMainMenu]
          end>
        Category = 'enFile'
      end>
    Left = 10
    Top = 154
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 'Rich Text Format|*.rtf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 424
    Top = 8
  end
end

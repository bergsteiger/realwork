object MainForm: TMainForm
  Left = 190
  Top = 123
  Width = 712
  Height = 498
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter: TSplitter
    Left = 356
    Top = 0
    Width = 4
    Height = 425
    Cursor = crHSplit
    Align = alRight
  end
  object Memo: TevMemo
    Left = 0
    Top = 0
    Width = 356
    Height = 425
    Canvas.DrawSpecial = False
    Align = alClient
    Controller = OvcController1
    ParentColor = False
    TabOrder = 1
    TabStop = True
  end
  object pnFooter: TPanel
    Left = 0
    Top = 425
    Width = 704
    Height = 41
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      704
      41)
    object btDoIt: TButton
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Do It'
      TabOrder = 0
      OnClick = btDoItClick
    end
    object btOpen: TButton
      Left = 464
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Open'
      TabOrder = 1
      OnClick = btOpenClick
    end
    object btCheck: TButton
      Left = 544
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Check It!'
      TabOrder = 2
      OnClick = btCheckClick
    end
  end
  object outMemo: TevMemo
    Left = 360
    Top = 0
    Width = 344
    Height = 425
    Canvas.DrawSpecial = False
    Align = alRight
    Controller = OvcController1
    ParentColor = False
    TabOrder = 2
    TabStop = True
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Left = 128
    Top = 200
  end
  object OpenDialog: TOpenDialog
    FileName = 'j:\b8i.evd'
    Filter = #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1088#1077#1076#1072#1082#1090#1086#1088#1072' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)|*.evd|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 168
    Top = 200
  end
end

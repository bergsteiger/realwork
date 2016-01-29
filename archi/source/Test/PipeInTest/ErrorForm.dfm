object PipeErrorForm: TPipeErrorForm
  Left = 205
  Top = 143
  Width = 696
  Height = 480
  Caption = #1057#1087#1080#1089#1086#1082' '#1086#1096#1080#1073#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 397
    Align = alClient
    TabOrder = 0
    object ListBox1: TListBox
      Left = 1
      Top = 1
      Width = 686
      Height = 395
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 397
    Width = 688
    Height = 49
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 584
      Top = 8
      Width = 99
      Height = 33
      Caption = #1054#1082
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 456
      Top = 8
      Width = 115
      Height = 33
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.log'
    FileName = 'Import Errors.log'
    Filter = 'Import Error Log file|*.log'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 176
    Top = 392
  end
end

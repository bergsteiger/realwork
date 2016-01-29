object MainForm: TMainForm
  Left = 217
  Top = 220
  Width = 692
  Height = 100
  Caption = 'EverestHelper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object pnFileName: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object pnProgress: TPanel
    Left = 0
    Top = 33
    Width = 684
    Height = 35
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object Meter: TvtW95Meter
      Left = 8
      Top = 8
      Width = 665
      OnSetStr = MeterSetStr
    end
  end
  object DirNavigator: TvtDirNavigator
    IncludeFileFilter = '*.PAS;*.INC'
    DirectoryFilter = '*.*'
    SrchFileAttr = [foNormalFiles, foArchiveFiles]
    ExploreDirAttr = [foSubDir]
    Left = 8
    Top = 8
  end
  object OvcController: TOvcController
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
    Left = 72
    Top = 8
  end
end

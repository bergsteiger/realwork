inherited InsertTextDictForm: TInsertTextDictForm
  Left = 489
  Top = 233
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = 'InsertTextDictForm'
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited DictOutliner: TvtOutliner
    MultiStrokeItem = True
    SelfDrawNodes = True
    ViewOptions = [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowRoot, voShowLines, voShowOpenChip]
  end
  inherited menuDictions: TMainMenu
    inherited miDictions: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
    end
  end
end

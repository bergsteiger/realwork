object Searcher: TSearcher
  OldCreateOrder = False
  Left = 196
  Top = 123
  Height = 150
  Width = 215
  object FindDialog: TFindDialog
    Options = [frDown, frHideWholeWord, frHideUpDown]
    OnFind = FindDialogFind
    Left = 8
    Top = 8
  end
  object TextSearcher: TevBMTextSearcher
    Left = 112
    Top = 8
  end
end

object StringListViewerFrame: TStringListViewerFrame
  Left = 0
  Top = 0
  Width = 547
  Height = 249
  TabOrder = 0
  object StringListView: TListView
    Left = 0
    Top = 0
    Width = 547
    Height = 249
    Align = alClient
    Columns = <
      item
        Caption = 'Index'
      end
      item
        AutoSize = True
        Caption = 'Value'
      end>
    OwnerData = True
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
    OnData = StringListViewData
  end
end

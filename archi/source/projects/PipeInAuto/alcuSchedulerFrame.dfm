object SchedulerFrame: TSchedulerFrame
  Left = 0
  Top = 0
  Width = 544
  Height = 386
  Align = alClient
  TabOrder = 0
  OnResize = FrameResize
  object Label1: TLabel
    Left = 8
    Top = 256
    Width = 88
    Height = 13
    Caption = #1054#1095#1077#1088#1077#1076#1100' '#1079#1072#1076#1072#1085#1080#1081
  end
  object TaskList: TListView
    Left = 204
    Top = 4
    Width = 253
    Height = 165
    Columns = <
      item
        AutoSize = True
        Caption = #1047#1072#1076#1072#1085#1080#1077
      end>
    IconOptions.WrapText = False
    ReadOnly = True
    ShowWorkAreas = True
    StateImages = TaskImages
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = EditTaskButtonClick
    OnSelectItem = TaskListSelectItem
  end
  object AddTaskButton: TBitBtn
    Left = 208
    Top = 176
    Width = 83
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = AddTaskButtonClick
  end
  object EditTaskButton: TBitBtn
    Left = 296
    Top = 176
    Width = 90
    Height = 25
    Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = EditTaskButtonClick
  end
  object ChangeDateButton: TButton
    Left = 296
    Top = 208
    Width = 90
    Height = 25
    Caption = #1057#1076#1074#1080#1085#1091#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = ChangeDateButtonClick
  end
  object DelTaskButton: TBitBtn
    Left = 208
    Top = 208
    Width = 83
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = DelTaskButtonClick
  end
  object cbShowEveryday: TCheckBox
    Left = 4
    Top = 240
    Width = 453
    Height = 17
    Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1077#1078#1077#1076#1085#1077#1074#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
    TabOrder = 5
    OnClick = cbShowEverydayClick
  end
  object SchedulerCalendar: TSchedulerCalendar
    Left = 4
    Top = 4
    Width = 197
    Height = 230
    Date = 2.000000000000000000
    OnChange = SchedulerCalendarChange
    OnDblClick = AddTaskButtonClick
    OnMonthChanged = SchedulerCalendarMonthChanged
    TabOrder = 6
  end
  object listQuery: TListBox
    Left = 8
    Top = 272
    Width = 449
    Height = 73
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
  end
  object TaskImages: TImageList
    Left = 276
    Top = 65
  end
end

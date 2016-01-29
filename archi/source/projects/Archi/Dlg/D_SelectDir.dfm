inherited arDirSelectDlg: TarDirSelectDlg
  Left = 401
  Top = 307
  Width = 561
  Height = 425
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
  Font.Height = -11
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object vtSplitter1: TvtSplitter [0]
    Left = 297
    Top = 0
    Width = 3
    Height = 344
    Cursor = crHSplit
  end
  inherited ButtonPanel: TPanel
    Top = 344
    Width = 545
    TabOrder = 2
    inherited OK: TBitBtn
      Left = 264
    end
    inherited Cancel: TBitBtn
      Left = 355
    end
    inherited Help: TBitBtn
      Left = 445
    end
  end
  object DirTree: TShellTreeView
    Left = 0
    Top = 0
    Width = 297
    Height = 344
    AutoContextMenus = False
    ObjectTypes = [otFolders]
    Root = 'rfMyComputer'
    ShellListView = FileList
    UseShellImages = True
    Align = alLeft
    AutoRefresh = False
    Indent = 19
    ParentColor = False
    RightClickSelect = True
    ShowRoot = False
    TabOrder = 0
  end
  object FileList: TShellListView
    Left = 300
    Top = 0
    Width = 245
    Height = 344
    AutoContextMenus = False
    ObjectTypes = [otFolders, otNonFolders]
    Root = 'rfMyComputer'
    ShellTreeView = DirTree
    Sorted = True
    Align = alClient
    ReadOnly = False
    HideSelection = False
    TabOrder = 1
    ViewStyle = vsList
  end
end

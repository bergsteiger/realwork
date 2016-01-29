object StandardActions: TStandardActions
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ActionList: TActionList
    Left = 24
    Top = 8
    object ViewAction1: TViewAction
      Category = 'View'
      Text = 'ViewAction1'
    end
    object VirtualKeyboard1: TVirtualKeyboard
      Category = 'Edit'
      Text = 'On-Screen Keyboard'
    end
    object FileExit1: TFileExit
      Category = 'File'
      Hint = 'Quit|Quits the application'
      ImageIndex = 43
    end
    object FileHideApp1: TFileHideApp
      Category = 'File'
      Hint = 'Hide|Hide current application'
    end
    object WindowClose1: TWindowClose
      Category = 'Window'
      Hint = 'Close Window|Close active form'
    end
    object FileHideAppOthers1: TFileHideAppOthers
      Category = 'File'
      Hint = 'Hide Others|Hide all other applications'
    end
  end
end

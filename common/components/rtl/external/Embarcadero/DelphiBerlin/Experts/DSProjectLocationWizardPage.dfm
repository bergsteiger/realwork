object DSProjectLocationWizardFrame: TDSProjectLocationWizardFrame
  Left = 0
  Top = 0
  Width = 515
  Height = 55
  TabOrder = 0
  DesignSize = (
    515
    55)
  object Label1: TLabel
    Left = 0
    Top = 2
    Width = 78
    Height = 13
    Caption = 'Project &location:'
    FocusControl = LocationEdit
  end
  object LocationEdit: TEdit
    Left = 0
    Top = 20
    Width = 484
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'LocationEdit'
  end
  object BrowseBtn: TButton
    Left = 490
    Top = 22
    Width = 22
    Height = 22
    Action = BrowseForFolder1
    Anchors = [akTop, akRight]
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 32
    Top = 10
    object BrowseForFolder1: TBrowseForFolder
      Category = 'File'
      Caption = '...'
      DialogCaption = 'Select project location:'
      BrowseOptions = [bifEditBox, bifNewDialogStyle, bifUseNewUI]
      BeforeExecute = BrowseForFolder1BeforeExecute
      OnAccept = BrowseForFolder1Accept
    end
  end
end

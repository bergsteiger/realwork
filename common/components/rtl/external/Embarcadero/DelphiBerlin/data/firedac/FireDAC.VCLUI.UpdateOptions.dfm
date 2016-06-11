object frmFDGUIxFormsUpdateOptions: TfrmFDGUIxFormsUpdateOptions
  Left = 0
  Top = 0
  Width = 538
  Height = 378
  Hint = 'Update Options'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object uo_Panel6: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 123
    Caption = ' General Updating'
    TabOrder = 2
    object uo_SpeedButton1: TSpeedButton
      Left = 11
      Top = 91
      Width = 75
      Height = 22
      Caption = 'Shortcuts ...'
      Flat = True
      PopupMenu = uo_PopupMenu1
      OnClick = uo_SpeedButton1Click
    end
    object uo_cbEnableInsert: TCheckBox
      Left = 11
      Top = 12
      Width = 94
      Height = 17
      Caption = 'Enable &insert'
      TabOrder = 0
      OnClick = uo_Change
    end
    object uo_cbEnableUpdate: TCheckBox
      Left = 11
      Top = 37
      Width = 90
      Height = 17
      Caption = 'Enable u&pdate'
      TabOrder = 1
      OnClick = uo_Change
    end
    object uo_cbEnableDelete: TCheckBox
      Left = 11
      Top = 62
      Width = 94
      Height = 17
      Caption = 'Enable &delete'
      TabOrder = 2
      OnClick = uo_Change
    end
  end
  object uo_GroupBox2: TPanel
    Left = 261
    Top = 128
    Width = 244
    Height = 93
    Caption = ' Locking '
    TabOrder = 0
    object uo_Label1: TLabel
      Left = 11
      Top = 11
      Width = 54
      Height = 13
      Caption = '&Lock mode:'
      FocusControl = uo_cbxLockMode
    end
    object uo_Label2: TLabel
      Left = 12
      Top = 38
      Width = 52
      Height = 13
      Caption = 'Lock &point:'
      FocusControl = uo_cbxLockPoint
    end
    object uo_cbxLockMode: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnClick = uo_Change
      Items.Strings = (
        'lmNone'
        'lmPessimistic'
        'lmOptimistic')
    end
    object uo_cbxLockPoint: TComboBox
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnClick = uo_Change
      Items.Strings = (
        'lpImmediate'
        'lpDeferred')
    end
    object uo_cbLockWait: TCheckBox
      Left = 11
      Top = 66
      Width = 97
      Height = 16
      Caption = '&Wait for lock'
      TabOrder = 2
      OnClick = uo_Change
    end
  end
  object uo_GroupBox4: TPanel
    Left = 261
    Top = 246
    Width = 241
    Height = 34
    Caption = ' Refreshing  '
    TabOrder = 1
    object Label1: TLabel
      Left = 11
      Top = 11
      Width = 71
      Height = 13
      Caption = '&Refresh mode:'
      FocusControl = uo_cbRefreshMode
    end
    object uo_cbRefreshMode: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnClick = uo_Change
      Items.Strings = (
        'rmManual'
        'rmOnDemand'
        'rmAll')
    end
  end
  object uo_GroupBox5: TPanel
    Left = 261
    Top = 286
    Width = 244
    Height = 93
    Caption = ' Automatic incrementing '
    TabOrder = 4
    object uo_Label7: TLabel
      Left = 11
      Top = 4
      Width = 87
      Height = 26
      Caption = 'Fetch next gener.'#13#10'value point:'
      FocusControl = uo_cbxFetchGeneratorsPoint
    end
    object uo_Label8: TLabel
      Left = 11
      Top = 37
      Width = 53
      Height = 13
      Caption = '&Generator:'
      FocusControl = uo_edtGeneratorName
    end
    object uo_Label9: TLabel
      Left = 11
      Top = 64
      Width = 68
      Height = 13
      Caption = '&Autoinc fields:'
      FocusControl = uo_edtAutoIncFields
    end
    object uo_cbxFetchGeneratorsPoint: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnClick = uo_Change
      Items.Strings = (
        'gpNone'
        'gpImmediate'
        'gpDeferred')
    end
    object uo_edtGeneratorName: TEdit
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = uo_Change
    end
    object uo_edtAutoIncFields: TEdit
      Left = 107
      Top = 61
      Width = 125
      Height = 21
      TabOrder = 2
      OnChange = uo_Change
    end
  end
  object uo_GroupBox3: TPanel
    Left = 11
    Top = 129
    Width = 244
    Height = 207
    Caption = ' Posting Changes'
    TabOrder = 3
    object uo_Label4: TLabel
      Left = 11
      Top = 10
      Width = 68
      Height = 13
      Caption = 'Update &mode:'
      FocusControl = uo_cbxUpdateMode
    end
    object uo_Label6: TLabel
      Left = 11
      Top = 37
      Width = 50
      Height = 13
      Caption = '&Key fields:'
      FocusControl = uo_edtKeyFields
    end
    object uo_Label5: TLabel
      Left = 11
      Top = 65
      Width = 66
      Height = 13
      Caption = 'Update &table:'
      FocusControl = uo_edtUpdateTableName
    end
    object uo_edtKeyFields: TEdit
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = uo_Change
    end
    object uo_edtUpdateTableName: TEdit
      Left = 107
      Top = 62
      Width = 125
      Height = 21
      TabOrder = 2
      OnChange = uo_Change
    end
    object uo_cbxUpdateMode: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 0
      OnClick = uo_Change
      Items.Strings = (
        'upWhereAll'
        'upWhereChanged'
        'upWhereKeyOnly')
    end
    object uo_cbUpdateChangedFields: TCheckBox
      Left = 11
      Top = 90
      Width = 163
      Height = 17
      Caption = '&Update changed fields'
      TabOrder = 3
      OnClick = uo_Change
    end
    object uo_cbCountUpdatedRecords: TCheckBox
      Left = 11
      Top = 136
      Width = 163
      Height = 17
      Caption = '&Check updated records count'
      TabOrder = 5
      OnClick = uo_Change
    end
    object uo_cbCheckRequired: TCheckBox
      Left = 11
      Top = 159
      Width = 163
      Height = 17
      Caption = 'Check "re&quired" fields flag'
      TabOrder = 6
      OnClick = uo_Change
    end
    object uo_cbCheckReadOnly: TCheckBox
      Left = 11
      Top = 182
      Width = 163
      Height = 17
      Caption = 'Check "rea&donly" fields flag'
      TabOrder = 7
      OnClick = uo_Change
    end
    object uo_cbUpdateNonBaseFields: TCheckBox
      Left = 11
      Top = 113
      Width = 163
      Height = 17
      Caption = 'U&pdate non-base fields'
      TabOrder = 4
      OnClick = uo_Change
    end
  end
  object uo_PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 152
    Top = 24
    object uo_ReadOnly1: TMenuItem
      Caption = 'Read only'
      OnClick = uo_ReadOnly1Click
    end
    object uo_ReadWrite1: TMenuItem
      Caption = 'Read, write'
      OnClick = uo_ReadWrite1Click
    end
    object uo_N1: TMenuItem
      Caption = '-'
    end
    object uo_Fastupdates1: TMenuItem
      Caption = 'Fast updates'
      OnClick = uo_Fastupdates1Click
    end
    object uo_Standardupdates1: TMenuItem
      Caption = 'Standard updates'
      OnClick = uo_Standardupdates1Click
    end
  end
end

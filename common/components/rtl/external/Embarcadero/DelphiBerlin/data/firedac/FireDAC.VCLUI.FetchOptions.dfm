object frmFDGUIxFormsFetchOptions: TfrmFDGUIxFormsFetchOptions
  Left = 0
  Top = 0
  Width = 405
  Height = 374
  Hint = 'Fetch Options'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object fo_GroupBox1: TPanel
    Left = 3
    Top = 3
    Width = 284
    Height = 219
    Caption = ' General Fetching'
    TabOrder = 0
    object fo_Label1: TLabel
      Left = 5
      Top = 10
      Width = 60
      Height = 13
      Caption = '&Fetch mode:'
      FocusControl = fo_cbxMode
    end
    object fo_Label3: TLabel
      Left = 5
      Top = 83
      Width = 61
      Height = 13
      Caption = '&Rowset size:'
      FocusControl = fo_edtRowSetSize
    end
    object fo_Label2: TLabel
      Left = 5
      Top = 104
      Width = 86
      Height = 26
      Caption = 'Maximum records &to fetch:'
      FocusControl = fo_edtRecsMax
      WordWrap = True
    end
    object fo_Label4: TLabel
      Left = 4
      Top = 185
      Width = 60
      Height = 26
      Caption = '&Record '#13#10'count mode:'
      FocusControl = fo_cbxRecordCountMode
    end
    object Label1: TLabel
      Left = 5
      Top = 37
      Width = 58
      Height = 13
      Caption = '&Cursor kind:'
      FocusControl = fo_cbxCursor
    end
    object fo_Label5: TLabel
      Left = 4
      Top = 159
      Width = 88
      Height = 26
      Caption = 'Enable All &Records'#13#10'fetching:'
      FocusControl = fo_cbxFetchAll
    end
    object fo_edtRecsMax: TEdit
      Left = 101
      Top = 107
      Width = 125
      Height = 21
      TabOrder = 4
      OnChange = fo_Change
    end
    object fo_edtRowSetSize: TEdit
      Left = 101
      Top = 80
      Width = 125
      Height = 21
      TabOrder = 3
      OnChange = fo_Change
    end
    object fo_cbxMode: TComboBox
      Left = 101
      Top = 7
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = fo_Change
      Items.Strings = (
        'fmManual'
        'fmOnDemand'
        'fmAll'
        'fmExactRecsMax')
    end
    object fo_cbAutoClose: TCheckBox
      Left = 5
      Top = 137
      Width = 222
      Height = 15
      Caption = 'C&lose command after all data is fetched'
      TabOrder = 5
      OnClick = fo_Change
    end
    object fo_cbxRecordCountMode: TComboBox
      Left = 100
      Top = 190
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 7
      OnChange = fo_Change
      Items.Strings = (
        'cmVisible'
        'cmFetched'
        'cmTotal')
    end
    object fo_cbUnidirectional: TCheckBox
      Left = 5
      Top = 61
      Width = 222
      Height = 15
      Caption = '&Unidirectional dataset'
      TabOrder = 2
      OnClick = fo_Change
    end
    object fo_cbxCursor: TComboBox
      Left = 101
      Top = 34
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnChange = fo_Change
      Items.Strings = (
        'ckAutomatic'
        'ckDefault'
        'ckDynamic'
        'ckStatic'
        'ckForwardOnly')
    end
    object fo_cbxFetchAll: TComboBox
      Left = 100
      Top = 162
      Width = 125
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      OnChange = fo_Change
      Items.Strings = (
        'cmVisible'
        'cmFetched'
        'cmTotal')
    end
  end
  object fo_gbItems: TPanel
    Left = 5
    Top = 228
    Width = 137
    Height = 84
    Caption = ' Items To Fetch'
    TabOrder = 1
    object fo_cbIBlobs: TCheckBox
      Left = 11
      Top = 7
      Width = 116
      Height = 17
      Caption = '&Blobs'
      TabOrder = 0
      OnClick = fo_Change
    end
    object fo_cbIDetails: TCheckBox
      Left = 11
      Top = 32
      Width = 116
      Height = 17
      Caption = 'De&tails'
      TabOrder = 1
      OnClick = fo_Change
    end
    object fo_cbIMeta: TCheckBox
      Left = 11
      Top = 57
      Width = 116
      Height = 17
      Caption = 'Meta&data'
      TabOrder = 2
      OnClick = fo_Change
    end
  end
  object fo_gbCache: TPanel
    Left = 148
    Top = 228
    Width = 139
    Height = 84
    Caption = ' Items To Cache'
    TabOrder = 2
    object fo_cbCBlobs: TCheckBox
      Left = 11
      Top = 7
      Width = 115
      Height = 17
      Caption = '&Blobs'
      TabOrder = 0
      OnClick = fo_Change
    end
    object fo_cbCDetails: TCheckBox
      Left = 11
      Top = 32
      Width = 115
      Height = 17
      Caption = '&Details'
      TabOrder = 1
      OnClick = fo_Change
    end
    object fo_cbCMeta: TCheckBox
      Left = 11
      Top = 57
      Width = 115
      Height = 17
      Caption = '&Metadata'
      TabOrder = 2
      OnClick = fo_Change
    end
  end
  object fo_gbMasterDetail: TPanel
    Left = 72
    Top = 250
    Width = 284
    Height = 84
    Caption = ' Master-Detail'
    TabOrder = 3
    object Label2: TLabel
      Left = 5
      Top = 10
      Width = 84
      Height = 13
      Caption = '&Detail delay (ms):'
      FocusControl = fo_edtDetailDelay
    end
    object fo_edtDetailDelay: TEdit
      Left = 102
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = fo_Change
    end
    object fo_cbDetailOptimize: TCheckBox
      Left = 5
      Top = 36
      Width = 222
      Height = 15
      Caption = 'Detail &optimization'
      TabOrder = 0
      OnClick = fo_Change
    end
    object fo_cbDetailCascade: TCheckBox
      Left = 6
      Top = 60
      Width = 222
      Height = 15
      Caption = 'Detail &cascading updates'
      TabOrder = 2
      OnClick = fo_Change
    end
  end
  object fo_gbLiveDataWindow: TPanel
    Left = 189
    Top = 172
    Width = 164
    Height = 56
    Caption = 'Live Data Window'
    TabOrder = 4
    object fo_cbLiveWindowParanoic: TCheckBox
      Left = 11
      Top = 7
      Width = 116
      Height = 17
      Caption = '&Paranoic checking'
      TabOrder = 0
      OnClick = fo_Change
    end
    object fo_cbLiveWindowFastFirst: TCheckBox
      Left = 11
      Top = 32
      Width = 142
      Height = 17
      Caption = 'Optimize for first record'
      TabOrder = 1
      OnClick = fo_Change
    end
  end
end

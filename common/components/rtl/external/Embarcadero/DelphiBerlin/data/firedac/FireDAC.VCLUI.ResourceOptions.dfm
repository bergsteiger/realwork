object frmFDGUIxFormsResourceOptions: TfrmFDGUIxFormsResourceOptions
  Left = 0
  Top = 0
  Width = 539
  Height = 420
  Hint = 'Resource Options'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object ro_gbCmdTextProcess: TPanel
    Left = 3
    Top = 83
    Width = 281
    Height = 179
    Caption = 'Command Text Processing '
    TabOrder = 1
    object ro_Label4: TLabel
      Left = 11
      Top = 131
      Width = 96
      Height = 13
      Caption = 'Default ParamT&ype:'
    end
    object ro_cbCreateParams: TCheckBox
      Left = 11
      Top = 7
      Width = 107
      Height = 17
      Caption = 'Create &params'
      TabOrder = 0
      OnClick = ro_Change
    end
    object ro_cbCreateMacros: TCheckBox
      Left = 11
      Top = 32
      Width = 107
      Height = 17
      Caption = 'Create &macros'
      TabOrder = 1
      OnClick = ro_Change
    end
    object ro_cbExpandParams: TCheckBox
      Left = 11
      Top = 57
      Width = 107
      Height = 17
      Caption = 'Expand &params'
      TabOrder = 2
      OnClick = ro_Change
    end
    object ro_cbExpandMacros: TCheckBox
      Left = 11
      Top = 82
      Width = 107
      Height = 17
      Caption = 'Expand &macros'
      TabOrder = 3
      OnClick = ro_Change
    end
    object ro_cbExpandEscapes: TCheckBox
      Left = 11
      Top = 107
      Width = 107
      Height = 17
      Caption = 'Expand &escapes'
      TabOrder = 4
      OnClick = ro_Change
    end
    object ro_cbxDefaultParamType: TComboBox
      Left = 107
      Top = 127
      Width = 125
      Height = 21
      Style = csDropDownList
      TabOrder = 5
      OnChange = ro_Change
      Items.Strings = (
        'ptUnknown'
        'ptInput'
        'ptOutput'
        'ptInputOutput'
        'ptResult')
    end
    object ro_cbUnifyParams: TCheckBox
      Left = 11
      Top = 152
      Width = 107
      Height = 17
      Caption = '&Unify params'
      TabOrder = 6
      OnClick = ro_Change
    end
  end
  object ro_gbPersistance: TPanel
    Left = 29
    Top = 187
    Width = 436
    Height = 194
    Caption = 'Persistance Mode  '
    TabOrder = 3
    object ro_Label6: TLabel
      Left = 11
      Top = 76
      Width = 75
      Height = 26
      Caption = 'Default storage'#13#10'files folder:'
    end
    object ro_Label7: TLabel
      Left = 11
      Top = 130
      Width = 54
      Height = 26
      Caption = 'Backup '#13#10'files folder:'
    end
    object ro_Label8: TLabel
      Left = 11
      Top = 103
      Width = 78
      Height = 26
      Caption = 'Default storage '#13#10'file extention:'
    end
    object ro_Label9: TLabel
      Left = 11
      Top = 157
      Width = 67
      Height = 26
      Caption = 'Backup '#13#10'file extention:'
    end
    object ro_btnFld1: TSpeedButton
      Left = 403
      Top = 80
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60031B5DE0021ADD600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D6009CDEEF0084EFFF004AC6E70021ADD60018A5C60018A5C60018A5C600FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60052BDE7009CFFFF0094FFFF0073DEF70073DEF70073DEF70073DEF7004AC6
        E70021ADD60018A5C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60052BDE700ADFFFF008CF7FF008CEFFF008CEFFF008CEFFF0073DEF70073DE
        F70073DEF7004AC6EF0021ADD600FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60029ADD600ADDEEF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEF
        FF0073DEF70073DEF7004AC6EF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60073DEF70029ADD6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEF
        FF008CEFFF0073DEF70073DEF70018A5C600FF00FF00FF00FF00FF00FF0029AD
        D60094F7FF0029ADD600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEF
        FF008CEFFF0073DEF7000073080018A5C600FF00FF00FF00FF00FF00FF0029AD
        D6009CFFFF0073DEF70029ADD60018A5C60018A5C60018A5C600ADDEEF008CF7
        FF0084EFFF00007308005AE78C000073080018A5C600FF00FF00FF00FF0029AD
        D6009CFFFF0094F7FF0073DEF70073DEF70073DEF7006BDEF70029ADD600ADDE
        EF000073080052D67B0042D66B0031C64A0000730800FF00FF00FF00FF0029AD
        D6009CFFFF0094F7FF0094F7FF0094F7FF0094F7FF0073DEF70073DEF70029AD
        D60018A5C600108C210031C64A00109C210018A5C600FF00FF00FF00FF0029AD
        D600C6FFFF0094FFFF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF0073DE
        F70073DEF7000884100018AD290008841000FF00FF00FF00FF00FF00FF0021AD
        D6009CDEEF00C6FFFF00C6FFFF009CDEEF0018ADD60018A5C60018A5C60018A5
        C60018A5C600088C100008A51800FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0031B5DE0029ADD60018A5C60018A5C600FF00FF00FF00FF00FF00FF00FF00
        FF00088C100008A5180008841000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000730800087B0800088C
        1000088C1000087B0800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = ro_btnFld1Click
    end
    object ro_btnFld2: TSpeedButton
      Left = 403
      Top = 136
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60031B5DE0021ADD600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D6009CDEEF0084EFFF004AC6E70021ADD60018A5C60018A5C60018A5C600FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60052BDE7009CFFFF0094FFFF0073DEF70073DEF70073DEF70073DEF7004AC6
        E70021ADD60018A5C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60052BDE700ADFFFF008CF7FF008CEFFF008CEFFF008CEFFF0073DEF70073DE
        F70073DEF7004AC6EF0021ADD600FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60029ADD600ADDEEF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEF
        FF0073DEF70073DEF7004AC6EF00FF00FF00FF00FF00FF00FF00FF00FF0029AD
        D60073DEF70029ADD6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEF
        FF008CEFFF0073DEF70073DEF70018A5C600FF00FF00FF00FF00FF00FF0029AD
        D60094F7FF0029ADD600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEF
        FF008CEFFF0073DEF7000073080018A5C600FF00FF00FF00FF00FF00FF0029AD
        D6009CFFFF0073DEF70029ADD60018A5C60018A5C60018A5C600ADDEEF008CF7
        FF0084EFFF00007308005AE78C000073080018A5C600FF00FF00FF00FF0029AD
        D6009CFFFF0094F7FF0073DEF70073DEF70073DEF7006BDEF70029ADD600ADDE
        EF000073080052D67B0042D66B0031C64A0000730800FF00FF00FF00FF0029AD
        D6009CFFFF0094F7FF0094F7FF0094F7FF0094F7FF0073DEF70073DEF70029AD
        D60018A5C600108C210031C64A00109C210018A5C600FF00FF00FF00FF0029AD
        D600C6FFFF0094FFFF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF0073DE
        F70073DEF7000884100018AD290008841000FF00FF00FF00FF00FF00FF0021AD
        D6009CDEEF00C6FFFF00C6FFFF009CDEEF0018ADD60018A5C60018A5C60018A5
        C60018A5C600088C100008A51800FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0031B5DE0029ADD60018A5C60018A5C600FF00FF00FF00FF00FF00FF00FF00
        FF00088C100008A5180008841000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000730800087B0800088C
        1000088C1000087B0800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = ro_btnFld2Click
    end
    object ro_Label11: TLabel
      Left = 11
      Top = 49
      Width = 75
      Height = 26
      Caption = 'Default storage'#13#10'format:'
    end
    object ro_cbPersistent: TCheckBox
      Left = 11
      Top = 7
      Width = 157
      Height = 17
      Caption = 'Enable &persistance'
      TabOrder = 0
      OnClick = ro_Change
    end
    object ro_cbBackup: TCheckBox
      Left = 11
      Top = 31
      Width = 157
      Height = 17
      Caption = '&Back storage file'
      TabOrder = 1
      OnClick = ro_Change
    end
    object ro_edtDefaultStorageFolder: TEdit
      Left = 107
      Top = 81
      Width = 296
      Height = 21
      TabOrder = 3
      OnChange = ro_Change
    end
    object ro_edtDefaultBackupFolder: TEdit
      Left = 107
      Top = 135
      Width = 296
      Height = 21
      TabOrder = 5
      OnChange = ro_Change
    end
    object ro_edtDefaultStorageExt: TEdit
      Left = 107
      Top = 108
      Width = 296
      Height = 21
      TabOrder = 4
      OnChange = ro_Change
    end
    object ro_edtDefaultBackupExt: TEdit
      Left = 107
      Top = 162
      Width = 296
      Height = 21
      TabOrder = 6
      OnChange = ro_Change
    end
    object ro_cbDefaultStoreFormat: TComboBox
      Left = 107
      Top = 54
      Width = 125
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = ro_Change
      Items.Strings = (
        'sfAuto'
        'sfXML'
        'sfBinary')
    end
  end
  object ro_gbCmdExecute: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 111
    Caption = 'Command Execution'
    TabOrder = 2
    object ro_Label2: TLabel
      Left = 11
      Top = 10
      Width = 30
      Height = 13
      Caption = '&Mode:'
    end
    object ro_Label3: TLabel
      Left = 11
      Top = 37
      Width = 42
      Height = 13
      Caption = '&Timeout:'
    end
    object ro_Label10: TLabel
      Left = 11
      Top = 56
      Width = 76
      Height = 26
      Caption = '&Array DML max '#13#10'slice size:'
    end
    object ro_cbxCmdExecMode: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = ro_Change
      Items.Strings = (
        'amBlocking'
        'amNonBlocking'
        'amCancelDialog'
        'amAsync')
    end
    object ro_edtCmdExecTimeout: TEdit
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      TabOrder = 1
      Text = '-1'
      OnChange = ro_Change
    end
    object ro_edtArrayDMLSize: TEdit
      Left = 107
      Top = 61
      Width = 125
      Height = 21
      TabOrder = 2
      Text = '-1'
      OnChange = ro_Change
    end
    object ro_cbShowWaitCursor: TCheckBox
      Left = 11
      Top = 89
      Width = 157
      Height = 17
      Caption = 'Show &Wait cursor'
      TabOrder = 3
      OnClick = ro_Change
    end
  end
  object ro_rbConnection: TPanel
    Left = 247
    Top = 11
    Width = 274
    Height = 171
    Caption = 'Connection Resources'
    TabOrder = 0
    object ro_Label1: TLabel
      Left = 11
      Top = 85
      Width = 89
      Height = 13
      Caption = 'Max open &cursors:'
    end
    object ro_Label5: TLabel
      Left = 11
      Top = 132
      Width = 70
      Height = 26
      Caption = 'Server output '#13#10'&buffer size:'
    end
    object ro_cbAutoReconnect: TCheckBox
      Left = 11
      Top = 58
      Width = 230
      Height = 17
      Caption = 'Auto detect and recover broken connection'
      TabOrder = 0
      OnClick = ro_Change
    end
    object ro_edtMaxCursors: TEdit
      Left = 108
      Top = 82
      Width = 125
      Height = 21
      TabOrder = 1
      Text = '-1'
      OnChange = ro_Change
    end
    object ro_cbServerOutput: TCheckBox
      Left = 11
      Top = 109
      Width = 157
      Height = 17
      Caption = 'Enable server &output'
      TabOrder = 2
      OnClick = ro_Change
    end
    object ro_edtServerOutputSize: TEdit
      Left = 108
      Top = 137
      Width = 125
      Height = 21
      TabOrder = 3
      Text = '20000'
      OnChange = ro_Change
    end
    object ro_cbAutoConnect: TCheckBox
      Left = 11
      Top = 7
      Width = 246
      Height = 17
      Caption = 'Automatically &open connection, when required'
      TabOrder = 4
      OnClick = ro_Change
    end
    object ro_cbKeepConnection: TCheckBox
      Left = 11
      Top = 32
      Width = 230
      Height = 17
      Caption = '&Keep connection active'
      TabOrder = 5
      OnClick = ro_Change
    end
  end
end

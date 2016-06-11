inherited frmFDGUIxFormsUSEdit: TfrmFDGUIxFormsUSEdit
  Left = 357
  Top = 163
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'FireDAC UpdateSQL Editor'
  ClientHeight = 432
  ClientWidth = 580
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 596
  ExplicitHeight = 470
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 580
    TabOrder = 2
    ExplicitWidth = 580
    inherited Bevel2: TBevel
      Width = 569
      ExplicitWidth = 569
    end
    inherited lblPrompt: TLabel
      Width = 247
      Caption = 'Select table, describe it and generate Update SQL'#39's'
      ExplicitWidth = 247
    end
  end
  inherited pnlButtons: TPanel
    Top = 394
    Width = 580
    ExplicitTop = 394
    ExplicitWidth = 580
    inherited Bevel3: TBevel
      Top = 2
      Width = 569
      ExplicitTop = 2
      ExplicitWidth = 569
    end
    inherited btnOk: TButton
      Left = 418
      ExplicitLeft = 418
    end
    inherited btnCancel: TButton
      Left = 499
      ExplicitLeft = 499
    end
  end
  object pcMain: TPageControl
    Left = 5
    Top = 41
    Width = 571
    Height = 348
    ActivePage = tsGenerate
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsGenerate: TTabSheet
      Caption = 'Generate'
      ImageIndex = 1
      ExplicitWidth = 559
      ExplicitHeight = 316
      DesignSize = (
        563
        320)
      object Label1: TLabel
        Left = 5
        Top = 5
        Width = 56
        Height = 13
        Caption = '&Table Name'
        FocusControl = cbxTableName
      end
      object GroupBox2: TLabel
        Left = 5
        Top = 52
        Width = 48
        Height = 13
        Caption = 'Key Fields'
      end
      object GroupBox3: TLabel
        Left = 185
        Top = 52
        Width = 73
        Height = 13
        Caption = 'Updating Fields'
      end
      object GroupBox4: TLabel
        Left = 377
        Top = 52
        Width = 82
        Height = 13
        Caption = 'Refreshing Fields'
      end
      object Bevel4: TBevel
        Left = 465
        Top = 52
        Width = 91
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsBottomLine
        ExplicitWidth = 87
      end
      object Bevel1: TBevel
        Left = 59
        Top = 52
        Width = 119
        Height = 9
        Shape = bsBottomLine
      end
      object Bevel5: TBevel
        Left = 264
        Top = 52
        Width = 106
        Height = 9
        Shape = bsBottomLine
      end
      object cbxTableName: TComboBox
        Left = 5
        Top = 24
        Width = 129
        Height = 21
        TabOrder = 0
        OnChange = cbxTableNameChange
        OnClick = cbxTableNameClick
        OnDropDown = cbxTableNameDropDown
      end
      object btnDSDefaults: TButton
        Left = 275
        Top = 23
        Width = 129
        Height = 23
        Caption = '&Revert To Defaults'
        TabOrder = 2
        OnClick = btnDSDefaultsClick
      end
      object btnGenSQL: TButton
        Left = 410
        Top = 23
        Width = 129
        Height = 23
        Caption = '&Generate SQL'
        TabOrder = 3
        OnClick = btnGenSQLClick
      end
      object btnServerInfo: TButton
        Left = 140
        Top = 23
        Width = 129
        Height = 23
        Caption = '&Describe From DB'
        TabOrder = 1
        OnClick = btnServerInfoClick
      end
      object lbKeyFields: TListBox
        Left = 5
        Top = 71
        Width = 173
        Height = 242
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 4
        ExplicitHeight = 238
      end
      object lbUpdateFields: TListBox
        Left = 185
        Top = 71
        Width = 185
        Height = 242
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 5
        ExplicitHeight = 238
      end
      object lbRefetchFields: TListBox
        Left = 377
        Top = 71
        Width = 179
        Height = 242
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 6
        ExplicitWidth = 175
        ExplicitHeight = 238
      end
    end
    object tsOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      ExplicitWidth = 559
      ExplicitHeight = 316
      DesignSize = (
        563
        320)
      object ptreeOptions: TFDGUIxFormsPanelTree
        Left = 5
        Top = 5
        Width = 552
        Height = 309
        HorzScrollBar.Smooth = True
        HorzScrollBar.Style = ssFlat
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Style = ssFlat
        VertScrollBar.Tracking = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitWidth = 548
        ExplicitHeight = 305
        object GroupBox5: TPanel
          Left = 3
          Top = 241
          Width = 190
          Height = 63
          Caption = 'SQL generation'
          TabOrder = 0
          object cbQuoteTabName: TCheckBox
            Left = 11
            Top = 34
            Width = 121
            Height = 17
            Caption = 'Quote Table Name'
            TabOrder = 0
          end
          object cbQuoteColName: TCheckBox
            Left = 11
            Top = 11
            Width = 129
            Height = 17
            Caption = 'Quote Column Names'
            TabOrder = 1
          end
        end
        object frmUpdateOptions: TfrmFDGUIxFormsUpdateOptions
          Left = 5
          Top = 5
          Width = 544
          Height = 328
          Hint = 'Update Options'
          Color = clWindow
          Ctl3D = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object tsSQL: TTabSheet
      Caption = 'SQL Commands'
      ImageIndex = 1
      ExplicitWidth = 559
      ExplicitHeight = 316
      DesignSize = (
        563
        320)
      object pcSQL: TPageControl
        Left = 5
        Top = 5
        Width = 553
        Height = 310
        ActivePage = tsInsert
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        ExplicitWidth = 549
        ExplicitHeight = 306
        object tsInsert: TTabSheet
          Caption = 'Insert'
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
        object tsModify: TTabSheet
          Caption = 'Modify'
          ImageIndex = 1
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
        object tsDelete: TTabSheet
          Caption = 'Delete'
          ImageIndex = 2
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
        object tsLock: TTabSheet
          Caption = 'Lock'
          ImageIndex = 3
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
        object tsUnlock: TTabSheet
          Caption = 'Unlock'
          ImageIndex = 4
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
        object tsFetchRow: TTabSheet
          Caption = 'FetchRow'
          ImageIndex = 5
          ExplicitWidth = 541
          ExplicitHeight = 278
        end
      end
    end
  end
end

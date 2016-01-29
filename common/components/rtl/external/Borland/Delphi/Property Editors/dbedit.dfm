object DBEditForm: TDBEditForm
  Left = 196
  Top = 114
  ActiveControl = DatabaseName
  BorderStyle = bsDialog
  ClientHeight = 293
  ClientWidth = 473
  ParentFont = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 457
    Height = 177
    Caption = ' Database '
    TabOrder = 0
    object Label1: TLabel
      Left = 159
      Top = 19
      Width = 54
      Height = 13
      Caption = '&Alias name:'
      FocusControl = AliasName
    end
    object Label2: TLabel
      Left = 310
      Top = 19
      Width = 60
      Height = 13
      Caption = '&Driver name:'
      FocusControl = DriverName
    end
    object Label3: TLabel
      Left = 8
      Top = 63
      Width = 97
      Height = 13
      Caption = '&Parameter overrides:'
      FocusControl = DatabaseParams
    end
    object Label4: TLabel
      Left = 8
      Top = 19
      Width = 31
      Height = 13
      Caption = '&Name:'
      FocusControl = DatabaseName
    end
    object AliasName: TComboBox
      Left = 159
      Top = 36
      Width = 137
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnChange = AliasNameChange
      OnClick = ClearButtonClick
      OnDropDown = AliasNameDropDown
    end
    object DriverName: TComboBox
      Left = 310
      Top = 36
      Width = 137
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
      OnChange = DriverNameChange
      OnClick = ClearButtonClick
      OnDropDown = DriverNameDropDown
    end
    object DatabaseParams: TMemo
      Left = 8
      Top = 80
      Width = 353
      Height = 89
      ScrollBars = ssVertical
      TabOrder = 3
      WordWrap = False
    end
    object DefaultsButton: TButton
      Left = 370
      Top = 80
      Width = 77
      Height = 27
      Caption = 'D&efaults'
      TabOrder = 4
      OnClick = DefaultsButtonClick
    end
    object ClearButton: TButton
      Left = 370
      Top = 112
      Width = 77
      Height = 27
      Caption = '&Clear'
      TabOrder = 5
      OnClick = ClearButtonClick
    end
    object DatabaseName: TEdit
      Left = 8
      Top = 36
      Width = 137
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 184
    Width = 457
    Height = 61
    Caption = ' Options '
    TabOrder = 1
    object LoginPrompt: TCheckBox
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = '&Login prompt'
      TabOrder = 0
    end
    object KeepConnection: TCheckBox
      Left = 8
      Top = 36
      Width = 169
      Height = 17
      Caption = '&Keep inactive connection'
      TabOrder = 1
    end
  end
  object OkButton: TButton
    Left = 214
    Top = 257
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 302
    Top = 257
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object HelpButton: TButton
    Left = 390
    Top = 257
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 4
    OnClick = HelpButtonClick
  end
end

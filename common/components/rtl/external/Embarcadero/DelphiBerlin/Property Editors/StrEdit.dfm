object StrEditDlg: TStrEditDlg
  Left = 226
  Top = 123
  BorderIcons = [biSystemMenu]
  Caption = 'String List Editor'
  ClientHeight = 279
  ClientWidth = 429
  Color = clBtnFace
  Constraints.MinHeight = 306
  Constraints.MinWidth = 437
  ParentFont = True
  OldCreateOrder = True
  PopupMenu = StringEditorMenu
  PopupMode = pmAuto
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    429
    279)
  PixelsPerInch = 96
  TextHeight = 13
  object CodeWndBtn: TButton
    Left = 7
    Top = 247
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Code Editor...'
    ModalResult = 6
    TabOrder = 0
    OnClick = CodeWndBtnClick
  end
  object OKButton: TButton
    Left = 187
    Top = 247
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 267
    Top = 247
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object HelpButton: TButton
    Left = 347
    Top = 247
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Help'
    TabOrder = 3
    OnClick = HelpButtonClick
  end
  object OpenDialog: TOpenDialog
    HelpContext = 27040
    DefaultExt = 'TXT'
    Filter = 
      'Text files (*.TXT)|*.TXT|Config files (*.SYS;*.INI)|*.SYS;*.INI|' +
      'Batch files (*.BAT)|*.BAT|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load string list'
    Left = 376
  end
  object SaveDialog: TSaveDialog
    HelpContext = 27050
    DefaultExt = 'TXT'
    Filter = 
      'Text files (*.TXT)|*.TXT|Config files (*.SYS;*.INI)|*.SYS;*.INI|' +
      'Batch files (*.BAT)|*.BAT|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist, ofEnableSizing]
    Title = 'Save string list'
    Left = 404
  end
  object StringEditorMenu: TPopupActionBar
    Left = 344
    object LoadItem: TMenuItem
      Caption = '&Load...'
      OnClick = FileOpen
    end
    object SaveItem: TMenuItem
      Caption = '&Save...'
      OnClick = FileSave
    end
    object CodeEditorItem: TMenuItem
      Caption = '&Code Editor...'
      Visible = False
      OnClick = CodeWndBtnClick
    end
  end
end

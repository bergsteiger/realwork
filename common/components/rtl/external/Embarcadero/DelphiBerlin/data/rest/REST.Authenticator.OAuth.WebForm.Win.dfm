object frm_OAuthWebForm: Tfrm_OAuthWebForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'OAuth Web-Login'
  ClientHeight = 563
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    635
    563)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 522
    Width = 619
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    ExplicitTop = 295
  end
  object Label1: TLabel
    Left = 8
    Top = 535
    Width = 477
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'This windows will close automatically when a token could be dete' +
      'cted and extracted.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btn_Close: TButton
    Left = 552
    Top = 530
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 8
    TabOrder = 0
  end
  object Browser: TWebBrowser
    Left = 8
    Top = 8
    Width = 619
    Height = 508
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    OnTitleChange = BrowserTitleChange
    OnBeforeNavigate2 = BrowserBeforeNavigate2
    OnNavigateComplete2 = BrowserNavigateComplete2
    ExplicitHeight = 281
    ControlData = {
      4C000000FA3F0000813400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end

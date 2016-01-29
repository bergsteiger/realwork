object AboutBox: TAboutBox
  Left = 8
  Top = 8
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'About Web App Debugger'
  ClientHeight = 175
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    324
    175)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 131
    Width = 307
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsBottomLine
  end
  object OKButton: TButton
    Left = 251
    Top = 145
    Width = 66
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object DetailsPanel: TPanel
    Left = 10
    Top = 6
    Width = 304
    Height = 104
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      304
      104)
    object Copyright: TLabel
      Left = 7
      Top = 29
      Width = 162
      Height = 13
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Copyright '#169' 1983, 2008'
    end
    object Version: TLabel
      Left = 7
      Top = 16
      Width = 54
      Height = 13
      Caption = 'Version 4.0'
    end
    object SKUName: TLabel
      Left = 7
      Top = 2
      Width = 127
      Height = 13
      Caption = 'Web Application Debugger'
    end
    object CompanyName: TLabel
      Left = 7
      Top = 44
      Width = 154
      Height = 13
      Caption = 'Embarcadero Technologies, Inc.'
    end
  end
end

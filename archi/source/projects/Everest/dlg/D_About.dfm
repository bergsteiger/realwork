object AboutBox: TAboutBox
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 229
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 9
    Top = 9
    Width = 303
    Height = 173
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 9
      Top = 9
      Width = 61
      Height = 61
      Picture.Data = {
        07544269746D617076020000424D760200000000000076000000280000002000
        0000200000000100040000000000000200000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00888888888888888888888888888888888888888888888888888888888888
        8888888888888888888888888888888888888888888000000000000000000888
        088888888880FFFFFFFFFFFFFFFF0880908888888000FFFFFFFFFFFFFFFF0809
        9908888880F0FF000000F00000FF00999088888000F0FFFFFFFFFFFFFFFF0B09
        08888880F0F0FF000F0000F000F0BBB088888880F0F0FFFFFFFFFFFFFF0BBB08
        88888880F0F0FF00F0000F0000BBB08888888880F0F0FFFFFFFFFFFF0BBB0888
        88888880F0F0FF000F0000F0BBB0088888888880F0F0FFFFFFFFFF0BBB0F0888
        88888880F0F0FF00F00000BBB0FF088888888880F0F0FFFFFFFF0BBB0FFF0888
        88888880F0F0FF000F00BBB000FF088888888880F0F0FFFFFF0BBB0FFFFF0888
        88888880F0F0FF00F0BBB00000FF088888888880F0F0FFFFF80B0FFFFFFF0888
        88888880F0F0FF0F8880F00F00FF088888888880F0F0FFFF88FFFFFFFFFF0888
        88888880F0F0FFF8FF00F00000FF088888888880F0F0FFFFFFFFFFFFFFFF0888
        88888880F0F0FFFFFFFFFFFFFFFF088888888880F0F000000000000000000888
        88888880F0FFFFFFFFFFFFFFFF08888888888880F00000000000000000088888
        88888880FFFFFFFFFFFFFFFF0888888888888880000000000000000008888888
        8888888888888888888888888888888888888888888888888888888888888888
        8888}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 95
      Top = 18
      Width = 123
      Height = 14
      Caption = 'Everest WYSIWYG Editor'
      IsControl = True
    end
    object Version: TLabel
      Left = 95
      Top = 43
      Width = 38
      Height = 14
      Caption = 'Version'
      IsControl = True
    end
    object Copyright: TLabel
      Left = 9
      Top = 86
      Width = 137
      Height = 14
      Caption = 'Copyright (C) 1996-2009 by '
      IsControl = True
    end
    object Comments: TLabel
      Left = 9
      Top = 112
      Width = 3
      Height = 14
      WordWrap = True
      IsControl = True
    end
    object lbArchi: TLabel
      Left = 151
      Top = 86
      Width = 70
      Height = 16
      Cursor = crHandPoint
      Hint = 'everesteditor@chat.ru'
      Caption = 'Archi Team.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbArchiClick
    end
    object lbWebPage: TLabel
      Left = 9
      Top = 112
      Width = 151
      Height = 16
      Cursor = crHandPoint
      Caption = 'http://everesteditor.chat.ru'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbWebPageClick
    end
    object lbDownloadVersion: TLabel
      Left = 95
      Top = 63
      Width = 106
      Height = 14
      Caption = 'Version for download'
    end
  end
  object OKButton: TButton
    Left = 120
    Top = 194
    Width = 80
    Height = 27
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end

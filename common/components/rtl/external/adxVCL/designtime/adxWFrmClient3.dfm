inherited frmClient3: TfrmClient3
  Left = 361
  Top = 242
  Caption = 'frmClient3'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblComment: TLabel
    Top = 25
    Height = 66
  end
  inherited lblTitle: TLabel
    Width = 37
    Height = 15
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -12
    Font.Name = 'Arial'
  end
  object panRTD: TPanel
    Left = 15
    Top = 95
    Width = 460
    Height = 95
    BevelOuter = bvNone
    TabOrder = 0
    object Label4: TLabel
      Left = 0
      Top = 0
      Width = 69
      Height = 13
      Caption = '&CoClass Name'
      FocusControl = edRTDCoClass
    end
    object Label5: TLabel
      Left = 0
      Top = 30
      Width = 85
      Height = 13
      Caption = 'COM Server Type'
      FocusControl = edRTDCoClass
    end
    object edRTDCoClass: TEdit
      Left = 110
      Top = 0
      Width = 225
      Height = 21
      TabOrder = 0
    end
    object rbDLL: TRadioButton
      Left = 110
      Top = 30
      Width = 50
      Height = 17
      Caption = '&DLL'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbStandalone: TRadioButton
      Left = 110
      Top = 55
      Width = 50
      Height = 17
      Caption = '&EXE'
      TabOrder = 2
    end
  end
end

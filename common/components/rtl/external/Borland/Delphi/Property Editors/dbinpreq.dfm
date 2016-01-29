object InputReqDialog: TInputReqDialog
  Left = 267
  Top = 160
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Input Requested'
  ClientHeight = 268
  ClientWidth = 193
  ParentFont = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 24
    Top = 239
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelButton: TButton
    Left = 107
    Top = 239
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object InputOptions: TPanel
    Left = 7
    Top = 67
    Width = 178
    Height = 84
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    OnClick = InputOptionsClick
  end
  object NoPromptAgain: TCheckBox
    Left = 15
    Top = 214
    Width = 163
    Height = 17
    Caption = 'Don'#39't Prompt Again'
    TabOrder = 1
  end
  object ErrorGroupBox: TPanel
    Left = 7
    Top = 7
    Width = 178
    Height = 55
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object ErrorGoupBoxSpacer: TPanel
      Left = 2
      Top = 2
      Width = 174
      Height = 51
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 4
      TabOrder = 0
      object InputMessage: TLabel
        Left = 4
        Top = 4
        Width = 166
        Height = 43
        Align = alClient
        AutoSize = False
        WordWrap = True
      end
    end
  end
  object DescriptionGroupBox: TPanel
    Left = 7
    Top = 158
    Width = 178
    Height = 50
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 5
    object DescriptionGroupBoxSpacer: TPanel
      Left = 2
      Top = 2
      Width = 174
      Height = 46
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 4
      TabOrder = 0
      object ErrorHelp: TLabel
        Left = 4
        Top = 4
        Width = 166
        Height = 38
        Align = alClient
        WordWrap = True
      end
    end
  end
end

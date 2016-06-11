inherited frmFDGUIxFormsAsyncExecute: TfrmFDGUIxFormsAsyncExecute
  Top = 249
  Caption = 'FireDAC Working'
  ClientHeight = 69
  ClientWidth = 241
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 241
    inherited Bevel2: TBevel
      Width = 231
    end
    inherited lblPrompt: TLabel
      Width = 163
      Caption = 'Please wait, application is busy ...'
    end
  end
  inherited pnlButtons: TPanel
    Top = 31
    Width = 241
    inherited Bevel3: TBevel
      Width = 231
    end
    object btnCancel2: TSpeedButton [1]
      Left = 161
      Top = 10
      Width = 75
      Height = 23
      Caption = 'Cancel'
      OnClick = btnCancelClick
    end
    inherited btnOk: TButton
      Left = 75
      Visible = False
    end
    inherited btnCancel: TButton
      Left = 77
      Top = -3
      Visible = False
    end
  end
  object tmrDelay: TTimer
    OnTimer = tmrDelayTimer
    Left = 40
    Top = 40
  end
end

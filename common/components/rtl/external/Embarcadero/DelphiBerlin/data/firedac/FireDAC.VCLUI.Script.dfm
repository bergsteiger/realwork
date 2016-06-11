inherited frmFDGUIxFormsfScript: TfrmFDGUIxFormsfScript
  Left = 501
  Top = 361
  Caption = 'FireDAC Processing'
  ClientHeight = 490
  ClientWidth = 395
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 395
    TabOrder = 2
    inherited Bevel2: TBevel
      Width = 384
    end
    inherited lblPrompt: TLabel
      Width = 227
      Caption = 'Please wait, application is processing SQL script'
    end
  end
  inherited pnlButtons: TPanel
    Top = 452
    Width = 395
    TabOrder = 3
    inherited Bevel3: TBevel
      Width = 384
    end
    inherited btnOk: TButton
      Left = 233
      Visible = False
    end
    inherited btnCancel: TButton
      Left = 314
      OnClick = btnCancelClick
    end
  end
  object pnlPrcLocation: TPanel
    Left = 0
    Top = 39
    Width = 395
    Height = 94
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object tvPrcLocation: TTreeView
      Left = 5
      Top = 3
      Width = 386
      Height = 88
      Anchors = [akLeft, akTop, akRight, akBottom]
      Indent = 19
      ReadOnly = True
      ShowButtons = False
      ShowRoot = False
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 133
    Width = 395
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 26
      Width = 78
      Height = 13
      Caption = 'Total script size:'
    end
    object lblTotalSize: TLabel
      Left = 91
      Top = 26
      Width = 33
      Height = 13
      Caption = '940 Kb'
    end
    object Label3: TLabel
      Left = 5
      Top = 44
      Width = 80
      Height = 13
      Caption = 'Total processed:'
    end
    object lblTotalDone: TLabel
      Left = 91
      Top = 44
      Width = 33
      Height = 13
      Caption = '257 Kb'
    end
    object Label5: TLabel
      Left = 185
      Top = 26
      Width = 69
      Height = 13
      Caption = 'Total % done:'
    end
    object lblTotalPctDone: TLabel
      Left = 260
      Top = 26
      Width = 23
      Height = 13
      Caption = '27%'
    end
    object Label2: TLabel
      Left = 185
      Top = 44
      Width = 60
      Height = 13
      Caption = 'Total errors:'
    end
    object lblTotalErrors: TLabel
      Left = 260
      Top = 44
      Width = 12
      Height = 13
      Caption = '23'
    end
    object pbPrcMain: TProgressBar
      Left = 5
      Top = 3
      Width = 384
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Max = 1000
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
  object pnlPrcOutput: TPanel
    Left = 0
    Top = 190
    Width = 395
    Height = 262
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 4
    object lbPrcOutput: TListBox
      Left = 5
      Top = 6
      Width = 384
      Height = 251
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '0')
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 320
    Top = 230
  end
end

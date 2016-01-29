object LogDetail: TLogDetail
  Left = 358
  Top = 116
  HelpContext = 4314
  ActiveControl = Button1
  BorderIcons = [biSystemMenu]
  Caption = 'LogDetail'
  ClientHeight = 428
  ClientWidth = 350
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  DesignSize = (
    350
    428)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 105
    Top = 401
    Width = 75
    Height = 25
    Action = PrevAction
    Anchors = [akRight, akBottom]
    TabOrder = 1
  end
  object Button2: TButton
    Left = 188
    Top = 401
    Width = 75
    Height = 25
    Action = NextAction
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object Button3: TButton
    Left = 271
    Top = 401
    Width = 75
    Height = 25
    Action = CloseAction
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 3
  end
  inline LogDetailFrame: TLogDetailFrame
    Left = 7
    Top = 8
    Width = 337
    Height = 385
    HorzScrollBar.Range = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 7
    ExplicitTop = 8
    ExplicitWidth = 337
    ExplicitHeight = 385
    inherited Memo1: TMemo
      Left = 0
      Width = 337
      Height = 359
      ExplicitLeft = 0
      ExplicitWidth = 337
      ExplicitHeight = 359
    end
    inherited cbTranslateText: TCheckBox
      Top = 367
      Caption = '&Translate Post'
      ExplicitTop = 367
    end
    inherited cbWrapText: TCheckBox
      Top = 365
      ExplicitTop = 365
    end
  end
  object ActionList1: TActionList
    Left = 240
    Top = 288
    object PrevAction: TAction
      Caption = '&Previous'
      OnExecute = PrevActionExecute
      OnUpdate = PrevActionUpdate
    end
    object NextAction: TAction
      Caption = '&Next'
      OnExecute = NextActionExecute
      OnUpdate = NextActionUpdate
    end
    object CloseAction: TAction
      Caption = '&Close'
      OnExecute = CloseActionExecute
    end
  end
end

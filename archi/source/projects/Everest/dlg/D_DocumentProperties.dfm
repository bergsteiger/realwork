inherited DocumentPropertiesDlg: TDocumentPropertiesDlg
  Left = 421
  Width = 446
  Height = 393
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited FormPanel: TPanel
    Width = 430
    Height = 357
    inherited pnButtons: TPanel
      Top = 314
      Width = 428
      inherited btOk: TBitBtn
        OnClick = OKBtnClick
      end
    end
    inherited pnMain: TPanel
      Width = 428
      Height = 313
      object lbShortName: TLabel
        Left = 8
        Top = 8
        Width = 193
        Height = 16
        AutoSize = False
        Caption = #1050#1086#1088#1086#1090#1082#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077':'
      end
      object lbName: TLabel
        Left = 8
        Top = 58
        Width = 169
        Height = 16
        AutoSize = False
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077': '
      end
      object lbComment: TLabel
        Left = 8
        Top = 169
        Width = 145
        Height = 16
        AutoSize = False
        Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
      end
      object lbNumber: TLabel
        Left = 4
        Top = 279
        Width = 59
        Height = 16
        AutoSize = False
        Caption = #1053#1086#1084#1077#1088':'
      end
      object edShortName: TevEdit
        Left = 4
        Top = 28
        Width = 426
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        LMargin = 1
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        TabStop = True
        BorderStyle = bsSingle
      end
      object memName: TevMemo
        Left = 4
        Top = 77
        Width = 426
        Height = 84
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        TabStop = True
        BorderStyle = bsSingle
      end
      object memComment: TevMemo
        Left = 5
        Top = 186
        Width = 426
        Height = 84
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        TabStop = True
        BorderStyle = bsSingle
      end
      object edExternalNumber: TvtSpinEdit
        Left = 58
        Top = 275
        Width = 136
        Height = 25
        TabOrder = 3
      end
    end
  end
end

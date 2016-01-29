object frmMain: TfrmMain
  Left = 481
  Top = 117
  Width = 750
  Height = 750
  Caption = #1040#1074#1090#1086#1086#1090#1074#1077#1090#1095#1080#1082' '#1089#1077#1088#1074#1077#1088#1072' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 0
    Top = 609
    Width = 734
    Height = 13
    Align = alBottom
    Caption = #1054#1096#1080#1073#1082#1080':'
  end
  object mErrors: TMemo
    Left = 0
    Top = 622
    Width = 734
    Height = 73
    Align = alBottom
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 734
    Height = 609
    ActivePage = tsReceiveQuery
    Align = alClient
    TabOrder = 1
    object tsReceiveQuery: TTabSheet
      Caption = #1055#1086#1083#1091#1095#1077#1085#1080#1077' '#1089' '#1089#1077#1088#1074#1077#1088#1072' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081
      object spl1: TSplitter
        Left = 0
        Top = 377
        Width = 726
        Height = 4
        Cursor = crVSplit
        Align = alBottom
      end
      object pnlAnswer: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 98
        Align = alTop
        TabOrder = 0
        DesignSize = (
          726
          98)
        object Label1: TLabel
          Left = 10
          Top = 6
          Width = 112
          Height = 13
          Caption = #1064#1072#1073#1083#1086#1085' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103':'
        end
        object Label2: TLabel
          Left = 10
          Top = 44
          Width = 79
          Height = 13
          Caption = #1064#1072#1073#1083#1086#1085' '#1086#1090#1074#1077#1090#1072':'
        end
        object edNotification: TEdit
          Left = 9
          Top = 22
          Width = 538
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object btnOpenNotTemplate: TBitBtn
          Left = 561
          Top = 20
          Width = 22
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 1
          OnClick = btnOpenNotTemplateClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            55555555FFFFFFFFFF55555000000000055555577777777775F55500B8B8B8B8
            B05555775F555555575F550F0B8B8B8B8B05557F75F555555575550BF0B8B8B8
            B8B0557F575FFFFFFFF7550FBF0000000000557F557777777777500BFBFBFBFB
            0555577F555555557F550B0FBFBFBFBF05557F7F555555FF75550F0BFBFBF000
            55557F75F555577755550BF0BFBF0B0555557F575FFF757F55550FB700007F05
            55557F557777557F55550BFBFBFBFB0555557F555555557F55550FBFBFBFBF05
            55557FFFFFFFFF7555550000000000555555777777777755555550FBFB055555
            5555575FFF755555555557000075555555555577775555555555}
          NumGlyphs = 2
        end
        object edAnswer: TEdit
          Left = 9
          Top = 59
          Width = 538
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object btnOpenAnswerTemplate: TBitBtn
          Left = 561
          Top = 58
          Width = 22
          Height = 20
          Anchors = [akTop, akRight]
          TabOrder = 3
          OnClick = btnOpenAnswerTemplateClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            55555555FFFFFFFFFF55555000000000055555577777777775F55500B8B8B8B8
            B05555775F555555575F550F0B8B8B8B8B05557F75F555555575550BF0B8B8B8
            B8B0557F575FFFFFFFF7550FBF0000000000557F557777777777500BFBFBFBFB
            0555577F555555557F550B0FBFBFBFBF05557F7F555555FF75550F0BFBFBF000
            55557F75F555577755550BF0BFBF0B0555557F575FFF757F55550FB700007F05
            55557F557777557F55550BFBFBFBFB0555557F555555557F55550FBFBFBFBF05
            55557FFFFFFFFF7555550000000000555555777777777755555550FBFB055555
            5555575FFF755555555557000075555555555577775555555555}
          NumGlyphs = 2
        end
      end
      object pnlAuto: TPanel
        Left = 0
        Top = 381
        Width = 726
        Height = 200
        Align = alBottom
        TabOrder = 1
        object lblAutoAnswer: TLabel
          Left = 1
          Top = 1
          Width = 724
          Height = 13
          Align = alTop
          Caption = #1056#1072#1073#1086#1090#1072' '#1074' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1084' '#1088#1077#1078#1080#1084#1077':'
        end
        object pnlAutoSettings: TPanel
          Left = 537
          Top = 14
          Width = 188
          Height = 185
          Align = alRight
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object cbAutoAnswer: TCheckBox
            Left = 7
            Top = 10
            Width = 169
            Height = 14
            Caption = #1054#1090#1074#1077#1095#1072#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
            TabOrder = 0
            OnClick = cbAutoAnswerClick
          end
          object cbOnlyAnswer: TCheckBox
            Left = 7
            Top = 37
            Width = 124
            Height = 14
            Caption = #1058#1086#1083#1100#1082#1086' '#1086#1090#1074#1077#1095#1072#1090#1100
            TabOrder = 1
          end
          object edAskServerEach: TLabeledEdit
            Left = 8
            Top = 78
            Width = 84
            Height = 21
            EditLabel.Width = 151
            EditLabel.Height = 13
            EditLabel.Caption = #1063#1072#1089#1090#1086#1090#1072' '#1086#1087#1088#1086#1089#1072' '#1089#1077#1088#1074#1077#1088#1072' (ms):'
            TabOrder = 2
            Text = '100'
            OnChange = edAskServerEachChange
            OnKeyDown = edAskServerEachKeyDown
          end
          object btnAskServerEachApply: TButton
            Left = 101
            Top = 79
            Width = 72
            Height = 21
            Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
            TabOrder = 3
            OnClick = btnAskServerEachApplyClick
          end
          object edSendDelay: TLabeledEdit
            Left = 8
            Top = 131
            Width = 83
            Height = 21
            EditLabel.Width = 165
            EditLabel.Height = 13
            EditLabel.Caption = #1047#1072#1076#1077#1088#1078#1082#1072' '#1087#1077#1088#1077#1076' '#1086#1090#1087#1088#1072#1074#1082#1086#1081' (ms):'
            TabOrder = 4
            Text = '1000'
            OnChange = edSendDelayChange
            OnKeyDown = edSendDelayKeyDown
          end
          object btnSendDelayApply: TButton
            Left = 101
            Top = 132
            Width = 72
            Height = 21
            Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
            TabOrder = 5
            OnClick = btnSendDelayApplyClick
          end
        end
        object mLog: TMemo
          Left = 1
          Top = 14
          Width = 536
          Height = 185
          Align = alClient
          Color = clBtnFace
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 1
          OnChange = mLogChange
        end
      end
      object pcReceiveQuery: TPageControl
        Left = 0
        Top = 98
        Width = 726
        Height = 279
        ActivePage = tsSentQueries
        Align = alClient
        TabOrder = 2
        object tsNewQuery: TTabSheet
          Caption = #1055#1086#1083#1091#1095#1077#1085#1080#1103'/'#1086#1073#1088#1072#1073#1086#1090#1082#1072' '#1079#1072#1087#1088#1086#1089#1072
          object pnlReceiveButtons: TPanel
            Left = 530
            Top = 0
            Width = 188
            Height = 251
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              188
              251)
            object btnNextMark: TButton
              Left = 20
              Top = 37
              Width = 156
              Height = 22
              Action = acNextMark
              Anchors = [akTop, akRight]
              TabOrder = 1
              WordWrap = True
            end
            object btnNextQuery: TButton
              Left = 20
              Top = 11
              Width = 156
              Height = 22
              Action = acNextQuery
              Anchors = [akTop, akRight]
              TabOrder = 0
              WordWrap = True
            end
            object btnNotification: TButton
              Left = 20
              Top = 63
              Width = 156
              Height = 22
              Action = acSendNotification
              Anchors = [akTop, akRight]
              TabOrder = 2
              WordWrap = True
            end
            object btnAnswer: TButton
              Left = 20
              Top = 88
              Width = 156
              Height = 23
              Action = acSendAnswer
              Anchors = [akTop, akRight]
              TabOrder = 3
              WordWrap = True
            end
            object Button2: TButton
              Left = 20
              Top = 120
              Width = 156
              Height = 23
              Anchors = [akTop, akRight]
              Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1086#1090#1074#1077#1090' '#1080' '#1086#1090#1087#1088#1072#1074#1080#1090#1100
              TabOrder = 4
              WordWrap = True
              OnClick = Button2Click
            end
          end
        end
        object tsSentQueries: TTabSheet
          Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1087#1088#1086#1089#1086#1074
          ImageIndex = 1
          object Panel1: TPanel
            Left = 530
            Top = 0
            Width = 188
            Height = 251
            Align = alRight
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              188
              251)
            object btnUntimelyAnswer: TButton
              Left = 20
              Top = 11
              Width = 156
              Height = 22
              Action = acJSendAnswer
              Anchors = [akTop, akRight]
              TabOrder = 0
              WordWrap = True
            end
            object btnClearSendNotifications: TButton
              Left = 20
              Top = 73
              Width = 156
              Height = 22
              Action = acClearSentNotifications
              Anchors = [akTop, akRight]
              TabOrder = 1
              WordWrap = True
            end
            object btnJSendNotification: TButton
              Left = 20
              Top = 43
              Width = 156
              Height = 23
              Action = acJSendNotification
              Anchors = [akTop, akRight]
              TabOrder = 2
              WordWrap = True
            end
            object btnShowQueryStatus: TButton
              Left = 20
              Top = 106
              Width = 156
              Height = 23
              Action = acPrintQueryStatus
              Anchors = [akTop, akRight]
              TabOrder = 3
              WordWrap = True
            end
            object btnDelete: TButton
              Left = 20
              Top = 138
              Width = 156
              Height = 23
              Action = acDeleteQuery
              Anchors = [akTop, akRight]
              TabOrder = 4
              WordWrap = True
            end
          end
        end
      end
    end
    object tsMakeQuery: TTabSheet
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1079#1072#1087#1088#1086#1089#1072' '#1074#1088#1091#1095#1085#1091#1102
      ImageIndex = 1
      object pnlManualInfo: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 170
        Align = alTop
        TabOrder = 0
        object Label6: TLabel
          Left = 20
          Top = 7
          Width = 40
          Height = 13
          Caption = 'aCardId:'
        end
        object Label5: TLabel
          Left = 20
          Top = 48
          Width = 55
          Height = 13
          Caption = 'aProductId:'
        end
        object Label4: TLabel
          Left = 20
          Top = 89
          Width = 37
          Height = 13
          Caption = 'aQuery:'
        end
        object edCardId: TEdit
          Left = 20
          Top = 27
          Width = 338
          Height = 21
          TabOrder = 0
          Text = '77-00007-000024'
        end
        object edProductId: TEdit
          Left = 20
          Top = 68
          Width = 338
          Height = 21
          TabOrder = 1
          Text = '99332'
        end
        object edUserQuery: TEdit
          Left = 20
          Top = 111
          Width = 338
          Height = 21
          TabOrder = 2
          Text = 'Something question from user'
        end
        object btnProcessManualXML: TButton
          Left = 267
          Top = 141
          Width = 93
          Height = 20
          Caption = #1055#1086#1083#1091#1095#1080#1090#1100' XML'
          TabOrder = 3
          OnClick = btnProcessManualXMLClick
        end
      end
    end
    object tsOfflineConsultation: TTabSheet
      Caption = #1055#1086#1076#1087#1080#1089#1072#1090#1100' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1102
      ImageIndex = 2
      DesignSize = (
        726
        581)
      object lblSourceXMLForImport: TLabeledEdit
        Left = 24
        Top = 24
        Width = 610
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 83
        EditLabel.Height = 13
        EditLabel.Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083':'
        TabOrder = 0
      end
      object lblDestXMLForImport: TLabeledEdit
        Left = 24
        Top = 64
        Width = 647
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 118
        EditLabel.Height = 13
        EditLabel.Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1083#1077#1085#1085#1099#1081' '#1092#1072#1081#1083':'
        TabOrder = 1
      end
      object btnSelectImportXML: TBitBtn
        Left = 644
        Top = 21
        Width = 22
        Height = 21
        Anchors = [akTop, akRight]
        TabOrder = 2
        OnClick = btnSelectImportXMLClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          55555555FFFFFFFFFF55555000000000055555577777777775F55500B8B8B8B8
          B05555775F555555575F550F0B8B8B8B8B05557F75F555555575550BF0B8B8B8
          B8B0557F575FFFFFFFF7550FBF0000000000557F557777777777500BFBFBFBFB
          0555577F555555557F550B0FBFBFBFBF05557F7F555555FF75550F0BFBFBF000
          55557F75F555577755550BF0BFBF0B0555557F575FFF757F55550FB700007F05
          55557F557777557F55550BFBFBFBFB0555557F555555557F55550FBFBFBFBF05
          55557FFFFFFFFF7555550000000000555555777777777755555550FBFB055555
          5555575FFF755555555557000075555555555577775555555555}
        NumGlyphs = 2
      end
      object btnSignConsultation: TButton
        Left = 595
        Top = 96
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1055#1086#1076#1087#1080#1089#1072#1090#1100
        TabOrder = 3
        OnClick = btnSignConsultationClick
      end
    end
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 695
    Width = 734
    Height = 19
    Panels = <
      item
        Text = #1059#1074': 0'
        Width = 65
      end
      item
        Text = #1054#1090': 0'
        Width = 65
      end
      item
        Text = #1054#1096': 0'
        Width = 65
      end
      item
        Text = #1054#1078#1080#1076#1072#1102#1090' '#1086#1090#1087#1088#1072#1074#1082#1080': 000'
        Width = 135
      end
      item
        Width = 50
      end>
  end
  object odXmlFile: TOpenDialog
    DefaultExt = '*.xml'
    Filter = #1060#1072#1081#1083#1099' xml|*.xml'
    Left = 104
    Top = 144
  end
  object tAskServerEach: TTimer
    Enabled = False
    OnTimer = tAskServerEachTimer
    Left = 180
    Top = 144
  end
  object aeHC: TApplicationEvents
    OnException = aeHCException
    Left = 32
    Top = 144
  end
  object alMain: TActionList
    Left = 180
    Top = 208
    object acJSendAnswer: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1074#1077#1090
      OnExecute = acJSendAnswerExecute
      OnUpdate = acJSendAnswerUpdate
    end
    object acClearSentNotifications: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = acClearSentNotificationsExecute
      OnUpdate = acClearSentNotificationsUpdate
    end
    object acNextQuery: TAction
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
      OnExecute = acNextQueryExecute
      OnUpdate = acNextQueryUpdate
    end
    object acNextMark: TAction
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      OnExecute = acNextMarkExecute
      OnUpdate = acNextMarkUpdate
    end
    object acSendNotification: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
      OnExecute = acSendNotificationExecute
      OnUpdate = acSendNotificationUpdate
    end
    object acSendAnswer: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1074#1077#1090
      OnExecute = acSendAnswerExecute
      OnUpdate = acSendAnswerUpdate
    end
    object acJSendNotification: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
      OnExecute = acJSendNotificationExecute
      OnUpdate = acJSendNotificationUpdate
    end
    object acPrintQueryStatus: TAction
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1090#1072#1090#1091#1089
      OnExecute = acPrintQueryStatusExecute
    end
    object acDeleteQuery: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acDeleteQueryExecute
    end
  end
  object pmUntimelyAnswers: TPopupMenu
    Left = 272
    Top = 144
    object N1: TMenuItem
      Action = acJSendAnswer
    end
    object N2: TMenuItem
      Action = acClearSentNotifications
    end
  end
  object xmlConsultation: TXMLDocument
    Left = 32
    Top = 208
    DOMVendorDesc = 'MSXML'
  end
  object xmlWork: TXMLDocument
    Left = 104
    Top = 208
    DOMVendorDesc = 'MSXML'
  end
  object tSendDelay: TTimer
    Enabled = False
    OnTimer = tSendDelayTimer
    Left = 272
    Top = 208
  end
end

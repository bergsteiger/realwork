object DlgProperties: TDlgProperties
  Left = 8
  Top = 8
  ActiveControl = cbPort
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 371
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    568
    371)
  PixelsPerInch = 96
  TextHeight = 13
  object OkButton: TButton
    Left = 403
    Top = 338
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 485
    Top = 338
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 9
    Top = 8
    Width = 551
    Height = 323
    ActivePage = TabConnection
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabConnection: TTabSheet
      Caption = '&Connection'
      DesignSize = (
        543
        295)
      object GroupBox1: TGroupBox
        Left = 8
        Top = 3
        Width = 526
        Height = 281
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        DesignSize = (
          526
          281)
        object Label1: TLabel
          Left = 8
          Top = 17
          Width = 24
          Height = 13
          Caption = '&Port:'
          FocusControl = cbPort
        end
        object Label2: TLabel
          Left = 8
          Top = 78
          Width = 62
          Height = 13
          Caption = '&Search Path:'
          FocusControl = edPath
        end
        object Label3: TLabel
          Left = 8
          Top = 48
          Width = 61
          Height = 13
          Caption = '&Default URL:'
          FocusControl = edDefault
        end
        object Label6: TLabel
          Left = 8
          Top = 109
          Width = 47
          Height = 13
          Caption = '&UDP Port:'
          FocusControl = cbUDPPort
        end
        object Label7: TLabel
          Left = 8
          Top = 140
          Width = 43
          Height = 13
          Caption = '&Browser:'
          FocusControl = cbUDPPort
        end
        object cbPort: TEdit
          Left = 88
          Top = 13
          Width = 65
          Height = 21
          TabOrder = 1
          Text = 'cbPort'
          OnKeyPress = NumericKeyPress
        end
        object cbActiveAtStartup: TCheckBox
          Left = 185
          Top = 16
          Width = 144
          Height = 17
          Caption = '&Activate at Startup'
          TabOrder = 2
        end
        object edDefault: TEdit
          Left = 88
          Top = 45
          Width = 424
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          Text = 'edDefault'
        end
        object edPath: TEdit
          Left = 88
          Top = 75
          Width = 424
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          Text = 'edPath'
        end
        object cbUDPPort: TEdit
          Left = 88
          Top = 105
          Width = 65
          Height = 21
          TabOrder = 0
          Text = 'cbPort'
          OnKeyPress = NumericKeyPress
        end
        object edBrowser: TEdit
          Left = 88
          Top = 136
          Width = 217
          Height = 21
          TabOrder = 5
          Text = 'mozilla'
        end
      end
    end
    object TabLog: TTabSheet
      Caption = '&Log'
      ImageIndex = 1
      DesignSize = (
        543
        295)
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 527
        Height = 196
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = '&Show in Log'
        TabOrder = 0
        DesignSize = (
          527
          196)
        inline LogColSettingsFrame: TLogColSettingsFrame
          Left = 9
          Top = 24
          Width = 508
          Height = 156
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          TabStop = True
          ExplicitLeft = 9
          ExplicitTop = 24
          ExplicitWidth = 508
          ExplicitHeight = 156
          inherited lvColumns: TListView
            Width = 508
            Height = 156
            ExplicitWidth = 508
            ExplicitHeight = 156
          end
        end
      end
      object GroupBox6: TGroupBox
        Left = 8
        Top = 212
        Width = 527
        Height = 73
        Anchors = [akLeft, akRight, akBottom]
        Caption = ' Log S&ize '
        TabOrder = 1
        DesignSize = (
          527
          73)
        object Label4: TLabel
          Left = 10
          Top = 21
          Width = 60
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Ma&x Events:'
          FocusControl = edLogMax
        end
        object Label5: TLabel
          Left = 11
          Top = 45
          Width = 137
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = '&Delete when max exceeded:'
          FocusControl = edLogDelete
        end
        object edLogMax: TEdit
          Left = 85
          Top = 17
          Width = 41
          Height = 21
          Anchors = [akLeft, akBottom]
          TabOrder = 0
          OnKeyPress = NumericKeyPress
        end
        object edLogDelete: TEdit
          Left = 173
          Top = 41
          Width = 41
          Height = 21
          Anchors = [akLeft, akBottom]
          TabOrder = 1
          OnKeyPress = NumericKeyPress
        end
      end
    end
  end
end

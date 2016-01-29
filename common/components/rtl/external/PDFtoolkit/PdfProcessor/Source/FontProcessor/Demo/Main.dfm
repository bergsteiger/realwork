object Form1: TForm1
  Left = 98
  Top = 303
  Caption = 'FontProcessor Demo'
  ClientHeight = 363
  ClientWidth = 871
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 871
    Height = 363
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'FontDetails'
      object Label1: TLabel
        Left = 184
        Top = 24
        Width = 42
        Height = 13
        Caption = 'Filename'
      end
      object Label10: TLabel
        Left = 184
        Top = 64
        Width = 49
        Height = 13
        Caption = 'FontName'
      end
      object Label11: TLabel
        Left = 624
        Top = 48
        Width = 19
        Height = 13
        Caption = 'Size'
      end
      object Label12: TLabel
        Left = 624
        Top = 83
        Width = 40
        Height = 13
        Caption = 'HorzRes'
      end
      object Label13: TLabel
        Left = 624
        Top = 115
        Width = 38
        Height = 13
        Caption = 'VertRes'
      end
      object Edit1: TEdit
        Left = 257
        Top = 21
        Width = 545
        Height = 21
        TabOrder = 0
      end
      object ListBox1: TListBox
        Left = 0
        Top = 134
        Width = 863
        Height = 201
        Align = alBottom
        BevelInner = bvLowered
        BevelKind = bkFlat
        BorderStyle = bsNone
        ItemHeight = 13
        TabOrder = 1
      end
      object BitBtn1: TBitBtn
        Left = 816
        Top = 20
        Width = 32
        Height = 23
        TabOrder = 2
        OnClick = BitBtn1Click
        Glyph.Data = {
          26060000424D2606000000000000360000002800000019000000140000000100
          180000000000F005000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF009999994D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
          4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
          4D4D4D4D4D4D4D4D4D4D4D999999E3DFE000666666E4E6E6CCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC4D4D4DE3DFE0006666
          66FDFDFDE4E6E6E6E6E6807F7E807F7E807F7E807F7E807F7E807F7E807F7E80
          7F7E807F7E807F7E807F7E807F7E807F7EE4E6E6E4E6E6E4E6E6E4E6E6E6E6E6
          CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6C9C9C9807F7E8FBBC5A1EEFE9F
          E6F59FE6F59FE6F59FE6F59FE6F59FE6F59FE6F59FE6F5A0EBFB97C5CF807F7E
          E6E6E6E6E6E6E6E6E6E6E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E680
          7F7EB4BCBC807F7EC6FCFFCAFFFFC6FCFFC6FCFFC6FCFFC6FCFFC6FCFFC6FCFF
          C6FCFFC6FCFFC8FFFFA5CBCC807F7EE6E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DF
          E000666666FDFDFDE4E6E6807F7EAEB8B8D9FFFF807F7EC6FCFFC7FFFFC4FBFF
          C3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC7FFFFA4CACD807F7EE4E6
          E6E4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8B8D5FFFF
          C5FFFF807F7EC6FCFFC8FFFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FA
          FFC4FBFFC7FFFFA4C8CB807F7EE4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFD
          E4E6E6807F7EAEB8B8D4FFFFC1FAFFC8FFFF807F7EC6FCFFCAFFFFC7FFFFC7FF
          FFC7FFFFC7FFFFC7FFFFC7FFFFC7FFFFC7FFFFCBFFFFACD1D3807F7ECCCCCC4D
          4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8B8D5FFFFC1FAFFC3FAFFC8FF
          FF807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E80
          7F7E807F7E807F7ECCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8
          B8D9FFFFC7FFFFC9FFFFCAFFFFCAFEFFBEF4F9B9EEF3BAEFF4BAEFF4BAEFF4BA
          EFF4BBF0F5B3E5EA807F7EE4E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DFE0006666
          66FDFDFDE4E6E6807F7EB3BBBBB9D1D2807F7E807F7E807F7E807F7EBCDADBE1
          FFFFDCFFFFDCFFFFDCFFFFDCFFFFDDFFFFD3F5F5807F7EE4E6E6E4E6E6E4E6E6
          CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6E4E6E6807F7E807F7EACD4D9AB
          D2D6ABD2D6ACD6DA807F7EADAEAD807F7E807F7E807F7E807F7E807F7E807F7E
          AEAEAEE9E9E9E4E6E6E4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E680
          7F7E9BB3B4DCFFFFD9FFFFD8FFFFD8FFFFD9FFFFD7FFFF807F7EE4E6E6E4E6E6
          E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DF
          E000666666FDFDFDE4E6E6E4E6E6807F7E807F7E807F7E807F7E807F7E807F7E
          807F7EB1B5B5E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E5E5E3E5E5E4E6
          E6E7EAEACCCCCC4D4D4DE3DFE000666666FDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDE4E6E64D4D4DE3DFE000666666FF5151
          FF5151FF5454FF5757FF5959FF5959FF5959FF5959FF5959FF5959FF5555FF54
          54FF5454FF5454FF5454FF5454FB5353FB5353A85151FB5353A85151FB53534D
          4D4DE3DFE000666666FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1
          A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1A8
          5151FFA1A1A85151FFA1A14D4D4DE3DFE0009999996666666666666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          6666666666666666666666666666666666666666666666999999E3DFE000E3DF
          E0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3
          DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0
          E3DFE0E3DFE0E3DFE000}
      end
      object Button1: TButton
        Left = 312
        Top = 103
        Width = 97
        Height = 25
        Caption = 'Get Font Details'
        TabOrder = 3
        OnClick = Button1Click
      end
      object RadioGroup2: TRadioGroup
        Left = 3
        Top = 12
        Width = 150
        Height = 77
        Caption = 'RadioGroup2'
        ItemIndex = 0
        Items.Strings = (
          'From FontFilename'
          'From FontName')
        TabOrder = 4
      end
      object Edit8: TEdit
        Left = 257
        Top = 61
        Width = 272
        Height = 21
        TabOrder = 5
      end
      object Edit9: TEdit
        Left = 681
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object Edit10: TEdit
        Left = 681
        Top = 80
        Width = 121
        Height = 21
        TabOrder = 7
      end
      object Edit11: TEdit
        Left = 681
        Top = 107
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object Button3: TButton
        Left = 200
        Top = 103
        Width = 89
        Height = 25
        Caption = 'TextSize'
        TabOrder = 9
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 104
        Top = 103
        Width = 75
        Height = 25
        Caption = 'FontStyle'
        TabOrder = 10
        OnClick = Button4Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'OutlineGlyph'
      ImageIndex = 1
      object Label2: TLabel
        Left = 190
        Top = 48
        Width = 49
        Height = 13
        Caption = 'Enter text'
      end
      object Label4: TLabel
        Left = 190
        Top = 79
        Width = 70
        Height = 13
        Caption = 'Enter text size'
      end
      object Label5: TLabel
        Left = 175
        Top = 111
        Width = 4
        Height = 16
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 190
        Top = 17
        Width = 42
        Height = 13
        Caption = 'Filename'
      end
      object Label6: TLabel
        Left = 339
        Top = 79
        Width = 59
        Height = 13
        Caption = 'CanvasXPos'
      end
      object Label7: TLabel
        Left = 456
        Top = 79
        Width = 59
        Height = 13
        Caption = 'CanvasYPos'
      end
      object Panel1: TPanel
        Left = 0
        Top = 152
        Width = 863
        Height = 183
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelInner = bvLowered
        BevelKind = bkFlat
        BevelOuter = bvLowered
        BorderStyle = bsSingle
        TabOrder = 0
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 851
          Height = 171
          Align = alClient
          Stretch = True
          ExplicitLeft = 3
          ExplicitTop = 0
        end
      end
      object Button2: TButton
        Left = 793
        Top = 123
        Width = 67
        Height = 23
        Caption = 'DrawGlyph'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Edit4: TEdit
        Left = 276
        Top = 77
        Width = 41
        Height = 21
        TabOrder = 2
      end
      object RadioGroup1: TRadioGroup
        Left = 3
        Top = 14
        Width = 150
        Height = 78
        Caption = 'InputFontInfo'
        ItemIndex = 0
        Items.Strings = (
          'LoadFromFontFile'
          'LoadFromTFontObject')
        TabOrder = 3
        OnClick = RadioGroup1Click
      end
      object Edit2: TEdit
        Left = 276
        Top = 14
        Width = 381
        Height = 21
        TabOrder = 4
      end
      object BitBtn2: TBitBtn
        Left = 663
        Top = 11
        Width = 25
        Height = 24
        TabOrder = 5
        OnClick = BitBtn2Click
        Glyph.Data = {
          26060000424D2606000000000000360000002800000019000000140000000100
          180000000000F005000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF009999994D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
          4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D
          4D4D4D4D4D4D4D4D4D4D4D999999E3DFE000666666E4E6E6CCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC4D4D4DE3DFE0006666
          66FDFDFDE4E6E6E6E6E6807F7E807F7E807F7E807F7E807F7E807F7E807F7E80
          7F7E807F7E807F7E807F7E807F7E807F7EE4E6E6E4E6E6E4E6E6E4E6E6E6E6E6
          CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6C9C9C9807F7E8FBBC5A1EEFE9F
          E6F59FE6F59FE6F59FE6F59FE6F59FE6F59FE6F59FE6F5A0EBFB97C5CF807F7E
          E6E6E6E6E6E6E6E6E6E6E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E680
          7F7EB4BCBC807F7EC6FCFFCAFFFFC6FCFFC6FCFFC6FCFFC6FCFFC6FCFFC6FCFF
          C6FCFFC6FCFFC8FFFFA5CBCC807F7EE6E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DF
          E000666666FDFDFDE4E6E6807F7EAEB8B8D9FFFF807F7EC6FCFFC7FFFFC4FBFF
          C3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC7FFFFA4CACD807F7EE4E6
          E6E4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8B8D5FFFF
          C5FFFF807F7EC6FCFFC8FFFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FAFFC3FA
          FFC4FBFFC7FFFFA4C8CB807F7EE4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFD
          E4E6E6807F7EAEB8B8D4FFFFC1FAFFC8FFFF807F7EC6FCFFCAFFFFC7FFFFC7FF
          FFC7FFFFC7FFFFC7FFFFC7FFFFC7FFFFC7FFFFCBFFFFACD1D3807F7ECCCCCC4D
          4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8B8D5FFFFC1FAFFC3FAFFC8FF
          FF807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E807F7E80
          7F7E807F7E807F7ECCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6807F7EAEB8
          B8D9FFFFC7FFFFC9FFFFCAFFFFCAFEFFBEF4F9B9EEF3BAEFF4BAEFF4BAEFF4BA
          EFF4BBF0F5B3E5EA807F7EE4E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DFE0006666
          66FDFDFDE4E6E6807F7EB3BBBBB9D1D2807F7E807F7E807F7E807F7EBCDADBE1
          FFFFDCFFFFDCFFFFDCFFFFDCFFFFDDFFFFD3F5F5807F7EE4E6E6E4E6E6E4E6E6
          CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E6E4E6E6807F7E807F7EACD4D9AB
          D2D6ABD2D6ACD6DA807F7EADAEAD807F7E807F7E807F7E807F7E807F7E807F7E
          AEAEAEE9E9E9E4E6E6E4E6E6CCCCCC4D4D4DE3DFE000666666FDFDFDE4E6E680
          7F7E9BB3B4DCFFFFD9FFFFD8FFFFD8FFFFD9FFFFD7FFFF807F7EE4E6E6E4E6E6
          E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6CCCCCC4D4D4DE3DF
          E000666666FDFDFDE4E6E6E4E6E6807F7E807F7E807F7E807F7E807F7E807F7E
          807F7EB1B5B5E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E6E6E4E5E5E3E5E5E4E6
          E6E7EAEACCCCCC4D4D4DE3DFE000666666FDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDE4E6E64D4D4DE3DFE000666666FF5151
          FF5151FF5454FF5757FF5959FF5959FF5959FF5959FF5959FF5959FF5555FF54
          54FF5454FF5454FF5454FF5454FB5353FB5353A85151FB5353A85151FB53534D
          4D4DE3DFE000666666FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1
          A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1FFA1A1A8
          5151FFA1A1A85151FFA1A14D4D4DE3DFE0009999996666666666666666666666
          6666666666666666666666666666666666666666666666666666666666666666
          6666666666666666666666666666666666666666666666999999E3DFE000E3DF
          E0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3
          DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0E3DFE0
          E3DFE0E3DFE0E3DFE000}
      end
      object Edit5: TEdit
        Left = 404
        Top = 76
        Width = 41
        Height = 21
        TabOrder = 6
      end
      object Edit6: TEdit
        Left = 521
        Top = 75
        Width = 41
        Height = 21
        TabOrder = 7
      end
      object CheckBox1: TCheckBox
        Left = 583
        Top = 75
        Width = 74
        Height = 17
        Caption = 'UseKerning'
        TabOrder = 9
      end
      object GroupBox1: TGroupBox
        Left = 712
        Top = 11
        Width = 145
        Height = 97
        Caption = 'InputResolution'
        TabOrder = 8
        object Label8: TLabel
          Left = 16
          Top = 24
          Width = 40
          Height = 13
          Caption = 'HorzRes'
        end
        object Label9: TLabel
          Left = 16
          Top = 56
          Width = 38
          Height = 13
          Caption = 'VertRes'
        end
        object Edit3: TEdit
          Left = 72
          Top = 24
          Width = 57
          Height = 21
          TabOrder = 0
        end
        object Edit7: TEdit
          Left = 72
          Top = 56
          Width = 57
          Height = 21
          TabOrder = 1
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 576
    Top = 376
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 824
    Top = 320
  end
end

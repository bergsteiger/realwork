object frmBenchmark: TfrmBenchmark
  Left = 468
  Top = 229
  Width = 598
  Height = 493
  Caption = 'VGScene Benchmark'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 582
    Height = 455
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 582.000000000000000000
      Height = 455.000000000000000000
      OnPaint = Root1Paint
      object Text1: TvgText
        Position.Point = '(233,240)'
        Width = 119.000007629394500000
        Height = 41.000000000000000000
        Fill.Color = '#FFD4D4D4'
        Font.ClearType = False
        Font.Size = 15.000000000000000000
        Font.Style = vgFontBold
        Text = 'VGScene'
        object ShadowEffect1: TvgShadowEffect
          Distance = 3.000000000000000000
          Direction = 45.000000000000000000
          Softness = 0.299999982118606600
          Opacity = 0.599999964237213100
          ShadowColor = '#FF000000'
        end
        object FloatAnimation1: TvgFloatAnimation
          AnimationType = vgAnimationInOut
          AutoReverse = True
          Enabled = True
          Duration = 1.000000000000000000
          Interpolation = vgInterpolationBack
          Loop = True
          StopValue = 360.000000000000000000
          PropertyName = 'RotateAngle'
        end
      end
      object CheckBox1: TvgCheckBox
        Position.Point = '(18,13)'
        Width = 219.000000000000000000
        Height = 19.000000000000000000
        TabOrder = 1
        IsChecked = False
        Font.Size = 11.000000953674320000
        TextAlign = vgTextAlignNear
        Text = 'Show Debug Update Rects'
        OnChange = CheckBox1Change
      end
      object Button1: TvgButton
        Position.Point = '(18,72)'
        Width = 80.000000000000000000
        Height = 22.000000000000000000
        TabOrder = 2
        StaysPressed = False
        IsPressed = False
        Font.Size = 11.000000953674320000
        TextAlign = vgTextAlignCenter
        Text = 'Button'
      end
      object Rectangle1: TvgRectangle
        Position.Point = '(223,72)'
        Width = 145.000000000000000000
        Height = 126.000007629394500000
        xRadius = 9.000000000000000000
        yRadius = 9.000000000000000000
        Sides = [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight]
        object FloatAnimation2: TvgFloatAnimation
          AutoReverse = True
          Enabled = True
          Duration = 2.000000000000000000
          Loop = True
          StopValue = 0.500000000000000000
          PropertyName = 'Opacity'
        end
      end
      object StringListBox1: TvgStringListBox
        Position.Point = '(51,255)'
        RotateAngle = -45.000000000000000000
        Width = 100.000000000000000000
        Height = 100.000000000000000000
        Resource = 'listboxstyle'
        TabOrder = 4
        ItemIndex = 0
        ItemHeight = 19.000000000000000000
        Items.strings = (
          'gdsgs'
          'gs'
          'g'
          'sg'
          'sg'
          'sgs'
          'g'
          'sg'
          's'
          'gs'
          'gsdfg')
      end
      object Memo1: TvgMemo
        Position.Point = '(391,250)'
        Width = 153.000000000000000000
        Height = 110.000007629394500000
        TabOrder = 5
        WordWrap = False
        Font.Size = 11.000000953674320000
        Text = 'Memo'
      end
      object Selection1: TvgSelection
        Position.Point = '(18,124)'
        Width = 90.000000000000000000
        Height = 74.000000000000000000
        GripSize = 3.000000000000000000
        HideSelection = False
        Proportional = False
        object Ellipse1: TvgEllipse
          Position.Point = '(32,17)'
          Width = 82.000000000000000000
          Height = 40.000000000000000000
          HitTest = False
          object GlowEffect1: TvgGlowEffect
            Softness = 0.400000005960464500
            Opacity = 0.899999976158142100
            GlowColor = '#FFFFD700'
          end
        end
      end
      object Path1: TvgPath
        Position.Point = '(401,72)'
        Width = 154.000000000000000000
        Height = 126.000007629394500000
        Fill.Style = vgBrushGradient
        Fill.Gradient.Points = <
          item
            Color = '#FF000000'
          end
          item
            Color = '#FFFFFFFF'
            Offset = 1.000000000000000000
          end>
        Fill.Gradient.Style = vgLinearGradient
        Stroke.Color = '#A6F72121'
        StrokeThickness = 2.000000000000000000
        Data.Path = {
          5E0000000000000066262343D7A3DE4101000000E17AE641CD4C254302000000
          D7A384C18F825D4302000000CDCC6E4252F8564302000000CDCCB842F6286743
          020000008F42D04266267343020000008FC23D4200007C430200000014AE6C42
          0000844302000000CDCC8D42B8FE8943020000009A190243CD8C8F4302000000
          9AD90D43858B9543020000007B9419433D8A9B430200000014AEEB4266E6A143
          02000000EC9101431FE5A74302000000CD4C0D43D7E3AD4302000000146E2843
          C335A843020000008F822D43CD0CB6430200000048213143A4F0BF4302000000
          66665E43CD4CBA43020000003D8A74433333B243020000008F2280433333AC43
          020000009A195E43D7C3AC43020000007BD469431FC5A6430200000000808343
          E1DA9743020000007B1491439A59A14302000000EC119643AE67924302000000
          F68898431F058B43020000009A9980431F058743020000009A79864366068143
          020000009A5997430A576E4302000000CDACD1438F826143020000000000B643
          F6282A430100000000C06043D7A3DE410200000052B84F4314AE374102000000
          CD4C3343CDCC34410200000066262343D7A3DE41030000000000000000000000
          00000000E1BA9E43AE67924302000000E1BA9E43A4D0954302000000E1DAB743
          CD0C984302000000E1DAB7439A999143020000006646B443713D874302000000
          33B3A143A4F0874302000000E1BA9E43AE679243030000000000000000000000
          000000003333B6426686A443020000000000CE4285ABA943020000008FC2F242
          B83EA34302000000AEC7FD42A4109C430200000052B8E642AE67944302000000
          666690420A579C43020000003333B6426686A443030000000000000000000000
          000000007B949B43F668994302000000F6E893433D4AA04302000000A4709C43
          1F45A743020000000000A44333D3A243020000005CAFA543711DA14302000000
          7BF4A343B81E9B43020000007B949B43F6689943030000000000000000000000
          00000000000003439A996E43020000000A9706437BD4704302000000D7E33C43
          29DC7B4302000000F6284A435C0F7E43020000008FC24E43AE077F4302000000
          00804B438FE2814302000000F6284543297C83430200000029DC36438F628543
          020000000000E3429A996E4302000000000003439A996E430300000000000000
          000000000000000048A1584348E1154201000000D7E3864366E6B64202000000
          F66889433333C1420200000000608943F628D542020000000AF7874366E6DA42
          010000003D8A754314AEB042010000009A5970433333EF4201000000CD4C5A43
          85EBD7420100000071FD36431F45024301000000CD4C2B43E17AA64201000000
          7B541843B81EE84201000000F6A8F642B81EE842020000001F05DF42B81EE842
          02000000713DDC42B81ECA420200000052B8F142D7A3B44202000000B89E0B43
          D7238C42020000006626214352B84542020000009AD92C4348E1154202000000
          299C38439A99CB41020000009A194D43EC51CE410200000048A1584348E11542
          030000000000000000000000}
        WrapMode = vgPathFit
        object GradientAnimation1: TvgGradientAnimation
          AutoReverse = True
          Enabled = True
          Duration = 0.500000000000000000
          Loop = True
          StartValue.Points = <
            item
              Color = '#FF1983EF'
            end
            item
              Color = '#FFFFFFFF'
              Offset = 1.000000000000000000
            end>
          StartValue.Style = vgLinearGradient
          StopValue.Points = <
            item
              Color = '#FFFFFFFF'
            end
            item
              Color = '#FF38E3F6'
              Offset = 1.000000000000000000
            end>
          StopValue.Style = vgLinearGradient
          PropertyName = 'Fill.Gradient'
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 482
    Top = 12
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 482
    Top = 42
  end
end

object frmLayout: TfrmLayout
  Left = 381
  Top = 172
  AutoScroll = False
  Caption = 'VSScene layout'
  ClientHeight = 603
  ClientWidth = 715
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 715
    Height = 603
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 715.000000000000000000
      Height = 603.000000000000000000
      Margins.Rect = '(6,6,6,6)'
      object TabControl1: TvgTabControl
        Align = vaClient
        Position.Point = '(6,6)'
        Width = 703.000000000000000000
        Height = 591.000000000000000000
        TabOrder = 0
        ItemIndex = 0
        object TabItem1: TvgTabItem
          Width = 91.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 0
          TextAlign = vgTextAlignCenter
          Text = 'Alignments'
          Layout = Layout1
        end
        object TabItem2: TvgTabItem
          Position.Point = '(91,0)'
          Width = 94.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 3
          TextAlign = vgTextAlignCenter
          Text = 'Layouts'
          Layout = Layout2
        end
        object TabItem6: TvgTabItem
          Position.Point = '(185,0)'
          Width = 96.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 5
          TextAlign = vgTextAlignCenter
          Text = 'NonVGLayout'
          Layout = Layout6
        end
        object Layout2: TvgLayout
          Position.Point = '(0,24)'
          Width = 703.000000000000000000
          Height = 567.000000000000000000
          Margins.Rect = '(9,9,9,9)'
          ClipChildren = True
          Visible = False
          DesignHide = True
          object TabControl2: TvgTabControl
            Align = vaClient
            Position.Point = '(9,9)'
            Width = 685.000000000000000000
            Height = 549.000000000000000000
            TabOrder = 0
            ItemIndex = 0
            object TabItem3: TvgTabItem
              Width = 170.000000000000000000
              Height = 24.000000000000000000
              TabOrder = 0
              TextAlign = vgTextAlignCenter
              Text = 'Layout - Std Alignment'
              Layout = Layout3
            end
            object TabItem4: TvgTabItem
              Position.Point = '(170,0)'
              Width = 224.000000000000000000
              Height = 24.000000000000000000
              TabOrder = 1
              TextAlign = vgTextAlignCenter
              Text = 'ScaledLayout - Autoscale Children'
              Layout = Layout4
            end
            object TabItem5: TvgTabItem
              Position.Point = '(394,0)'
              Width = 158.000000000000000000
              Height = 24.000000000000000000
              TabOrder = 5
              TextAlign = vgTextAlignCenter
              Text = 'Grid - Grid Alignment'
              Layout = Layout5
            end
            object Layout5: TvgLayout
              Position.Point = '(0,24)'
              Width = 685.000000000000000000
              Height = 525.000000000000000000
              Margins.Rect = '(9,9,9,9)'
              ClipChildren = True
              Visible = False
              DesignHide = True
              object Grid1: TvgGridLayout
                Align = vaClient
                Position.Point = '(9,9)'
                Width = 667.000000000000000000
                Height = 507.000000000000000000
                ItemHeight = 128.000000000000000000
                ItemWidth = 128.000000000000000000
                Orientation = vgHorizontal
                object Rectangle3: TvgRectangle
                  Align = vaTop
                  Position.Point = '(4,4)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle4: TvgRectangle
                  Align = vaTop
                  Position.Point = '(132,4)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle5: TvgRectangle
                  Align = vaTop
                  Position.Point = '(260,4)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle6: TvgRectangle
                  Align = vaTop
                  Position.Point = '(388,4)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle7: TvgRectangle
                  Align = vaTop
                  Position.Point = '(516,4)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle8: TvgRectangle
                  Align = vaTop
                  Position.Point = '(4,132)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle9: TvgRectangle
                  Align = vaTop
                  Position.Point = '(132,132)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle10: TvgRectangle
                  Align = vaTop
                  Position.Point = '(260,132)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle11: TvgRectangle
                  Align = vaTop
                  Position.Point = '(388,132)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle12: TvgRectangle
                  Align = vaTop
                  Position.Point = '(516,132)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle13: TvgRectangle
                  Align = vaTop
                  Position.Point = '(4,260)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle14: TvgRectangle
                  Align = vaTop
                  Position.Point = '(132,260)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle15: TvgRectangle
                  Align = vaTop
                  Position.Point = '(260,260)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle16: TvgRectangle
                  Align = vaTop
                  Position.Point = '(388,260)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle17: TvgRectangle
                  Align = vaTop
                  Position.Point = '(516,260)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle18: TvgRectangle
                  Align = vaTop
                  Position.Point = '(4,388)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle19: TvgRectangle
                  Align = vaTop
                  Position.Point = '(132,388)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle20: TvgRectangle
                  Align = vaTop
                  Position.Point = '(260,388)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle21: TvgRectangle
                  Align = vaTop
                  Position.Point = '(388,388)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
                object Rectangle22: TvgRectangle
                  Align = vaTop
                  Position.Point = '(516,388)'
                  Width = 120.000000000000000000
                  Height = 120.000000000000000000
                  Padding.Rect = '(4,4,4,4)'
                  Fill.Color = '#FFFBD2F4'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                end
              end
            end
            object Layout4: TvgLayout
              Position.Point = '(0,24)'
              Width = 685.000000000000000000
              Height = 525.000000000000000000
              Margins.Rect = '(9,9,9,9)'
              ClipChildren = True
              Visible = False
              DesignHide = True
              object ScaledLayout1: TvgScaledLayout
                Align = vaClient
                Position.Point = '(9,9)'
                Width = 667.000000000000000000
                Height = 507.000000000000000000
                OriginalWidth = 667.000000000000000000
                OriginalHeight = 507.000000000000000000
                object Rectangle2: TvgRectangle
                  Position.Point = '(136.144,70.514)'
                  Width = 387.855957031250000000
                  Height = 359.485961914062500000
                  Padding.Rect = '(13,13,13,13)'
                  Fill.Color = '#FFB0FDD8'
                  xRadius = 7.000000000000000000
                  yRadius = 7.000000000000000000
                  object TvgEllipse
                    Align = vaScale
                    Position.Point = '(4.894,39.942)'
                    Width = 95.530876159667970000
                    Height = 100.415214538574200000
                    Fill.Style = vgBrushGradient
                    Fill.Gradient.Points = <
                      item
                        Color = '#FF7A7575'
                      end
                      item
                        Color = '#FFFFFFFF'
                        Offset = 1.000000000000000000
                      end>
                    Fill.Gradient.Style = vgLinearGradient
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(28,42)'
                      Width = 39.000000000000000000
                      Height = 16.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'scale'
                    end
                  end
                  object TvgText
                    Align = vaTop
                    Position.Point = '(4,4)'
                    Width = 379.855957031250000000
                    Height = 52.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    Font.Size = 10.000000000000000000
                    VertTextAlign = vgTextAlignNear
                    Text = 'Usage of Align, Padding, Margins, RotateAngle properties'
                  end
                  object TvgEllipse
                    Align = vaFit
                    Position.Point = '(31,20)'
                    Width = 325.000000000000000000
                    Height = 334.000000000000000000
                    Padding.Rect = '(5,20,5,5)'
                    Fill.Color = '#3034C5FB'
                    Stroke.Color = '#FFFF0000'
                    object TvgText
                      Align = vaTop
                      Width = 325.000000000000000000
                      Height = 15.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'fit'
                    end
                    object TvgEllipse
                      Align = vaCenter
                      Position.Point = '(123,127)'
                      Width = 79.000000000000000000
                      Height = 80.000000000000000000
                      Padding.Rect = '(0,-15,0,0)'
                      Fill.Color = '#FFFFFFFF'
                      Stroke.Color = '#FFFF0000'
                      StrokeThickness = 2.000000000000000000
                      object TvgText
                        Align = vaCenter
                        Position.Point = '(19,30)'
                        Width = 41.000000000000000000
                        Height = 19.000000000000000000
                        Font.Size = 11.000000953674320000
                        Text = 'center'
                      end
                    end
                  end
                  object TvgRoundRect
                    Align = vaBottomRight
                    Position.Point = '(287.856,327.486)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(10,3)'
                      Width = 75.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'bottomright'
                    end
                  end
                  object TvgRoundRect
                    Align = vaBottomLeft
                    Position.Point = '(4,327.486)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(9,3)'
                      Width = 77.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'bottomleft'
                    end
                  end
                  object TvgRoundRect
                    Align = vaTopRight
                    Position.Point = '(287.856,20)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(9,3)'
                      Width = 77.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'topright'
                    end
                  end
                end
              end
            end
            object Layout3: TvgLayout
              Position.Point = '(0,24)'
              Width = 685.000000000000000000
              Height = 525.000000000000000000
              Margins.Rect = '(9,9,9,9)'
              ClipChildren = True
              object Rectangle1: TvgRectangle
                Align = vaClient
                Position.Point = '(9,9)'
                Width = 663.000000000000000000
                Height = 503.000000000000000000
                Padding.Rect = '(0,0,4,4)'
                xRadius = 5.000000000000000000
                yRadius = 5.000000000000000000
                object TvgRectangle
                  Align = vaClient
                  Position.Point = '(13,13)'
                  Width = 583.000000000000000000
                  Height = 396.000000000000000000
                  Padding.Rect = '(13,13,13,13)'
                  Fill.Color = '#FFB0FDD8'
                  xRadius = 7.000000000000000000
                  yRadius = 7.000000000000000000
                  object TvgEllipse
                    Align = vaScale
                    Position.Point = '(7.356,43.999)'
                    Width = 143.596023559570300000
                    Height = 110.614555358886700000
                    Fill.Style = vgBrushGradient
                    Fill.Gradient.Points = <
                      item
                        Color = '#FF7A7575'
                      end
                      item
                        Color = '#FFFFFFFF'
                        Offset = 1.000000000000000000
                      end>
                    Fill.Gradient.Style = vgLinearGradient
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(52,47)'
                      Width = 39.000000000000000000
                      Height = 16.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'scale'
                    end
                  end
                  object TvgText
                    Align = vaTop
                    Position.Point = '(4,4)'
                    Width = 575.000000000000000000
                    Height = 52.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    Font.Size = 10.000000000000000000
                    VertTextAlign = vgTextAlignNear
                    Text = 'Usage of Align, Padding, Margins, RotateAngle properties'
                  end
                  object TvgEllipse
                    Align = vaFit
                    Position.Point = '(113,20)'
                    Width = 357.857849121093800000
                    Height = 371.000000000000000000
                    Padding.Rect = '(5,20,5,5)'
                    Fill.Color = '#3034C5FB'
                    Stroke.Color = '#FFFF0000'
                    object TvgText
                      Align = vaTop
                      Width = 357.857849121093800000
                      Height = 15.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'fit'
                    end
                    object TvgEllipse
                      Align = vaCenter
                      Position.Point = '(139,145)'
                      Width = 79.000000000000000000
                      Height = 80.000000000000000000
                      Padding.Rect = '(0,-15,0,0)'
                      Fill.Color = '#FFFFFFFF'
                      Stroke.Color = '#FFFF0000'
                      StrokeThickness = 2.000000000000000000
                      object TvgText
                        Align = vaCenter
                        Position.Point = '(19,30)'
                        Width = 41.000000000000000000
                        Height = 19.000000000000000000
                        Font.Size = 11.000000953674320000
                        Text = 'center'
                      end
                    end
                  end
                  object TvgRoundRect
                    Align = vaBottomRight
                    Position.Point = '(483,364)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(10,3)'
                      Width = 75.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'bottomright'
                    end
                  end
                  object TvgRoundRect
                    Align = vaBottomLeft
                    Position.Point = '(4,364)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(9,3)'
                      Width = 77.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'bottomleft'
                    end
                  end
                  object TvgRoundRect
                    Align = vaTopRight
                    Position.Point = '(483,20)'
                    Width = 96.000030517578130000
                    Height = 27.000000000000000000
                    Padding.Rect = '(4,4,4,4)'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(9,3)'
                      Width = 77.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'topright'
                    end
                  end
                end
                object TvgRectangle
                  Align = vaBottom
                  Position.Point = '(4,422)'
                  Width = 655.000000000000000000
                  Height = 77.000000000000000000
                  Padding.Rect = '(4,0,4,4)'
                  Fill.Color = '#FF8B8B8B'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                  object TvgText
                    Position.Point = '(3,25)'
                    Width = 52.000000000000000000
                    Height = 28.000000000000000000
                    Font.Size = 11.000000953674320000
                    Text = 'bottom'
                  end
                  object TvgRoundRect
                    Align = vaHorzCenter
                    Position.Point = '(269,5)'
                    Width = 116.999992370605500000
                    Height = 67.000000000000000000
                    Padding.Rect = '(5,5,5,5)'
                    Fill.Color = '#FFEE7878'
                    object TvgText
                      Align = vaCenter
                      Position.Point = '(29,23)'
                      Width = 58.000000000000000000
                      Height = 21.000000000000000000
                      Font.Size = 11.000000953674320000
                      Text = 'horzcenter'
                    end
                  end
                end
                object TvgRectangle
                  Align = vaRight
                  Position.Point = '(609,4)'
                  Width = 50.000000000000000000
                  Height = 414.000000000000000000
                  Padding.Rect = '(0,4,4,4)'
                  Fill.Color = '#FF929292'
                  xRadius = 5.000000000000000000
                  yRadius = 5.000000000000000000
                  object TvgText
                    Align = vaCenter
                    Position.Point = '(0,197)'
                    RotateAngle = -90.000000000000000000
                    Width = 49.000000000000000000
                    Height = 20.000000000000000000
                    Font.Size = 11.000000953674320000
                    Text = 'right'
                  end
                end
              end
            end
          end
        end
        object Layout6: TvgLayout
          Position.Point = '(0,24)'
          Width = 703.000000000000000000
          Height = 567.000000000000000000
          ClipChildren = True
          Visible = False
          DesignHide = True
          object Rectangle23: TvgRectangle
            Align = vaClient
            Position.Point = '(33,79)'
            Width = 637.000000000000000000
            Height = 455.000000000000000000
            Padding.Rect = '(33,33,33,33)'
            xRadius = 12.000000000000000000
            yRadius = 12.000000000000000000
            object NonVGLayout1: TvgNonVGLayout
              Align = vaClient
              Position.Point = '(9,9)'
              Width = 619.000000000000000000
              Height = 437.000000000000000000
              Padding.Rect = '(9,9,9,9)'
              NonVGControl = Panel1
            end
          end
          object Label1: TvgLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 693.000000000000000000
            Height = 36.000000000000000000
            Padding.Rect = '(5,5,5,5)'
            TabOrder = 1
            TextAlign = vgTextAlignCenter
            Text = 
              'TvgNonVGLayout - this control allow easy align VCL controls. Jus' +
              't place this object and set NonVGControl property. TvgNonVGLayou' +
              't control auto-align VCL control and also check visibility of ob' +
              'ject. TPanel placed on top of TvgScene.'
          end
        end
        object Layout1: TvgLayout
          Position.Point = '(0,24)'
          Width = 703.000000000000000000
          Height = 567.000000000000000000
          ClipChildren = True
          object TvgRectangle
            Align = vaTop
            Position.Point = '(46,4)'
            Width = 653.000000000000000000
            Height = 37.000000000000000000
            Padding.Rect = '(4,4,4,4)'
            Fill.Color = '#FFFBD2F4'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaCenter
              Position.Point = '(297,8)'
              Width = 58.000000000000000000
              Height = 21.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'top'
            end
          end
          object TvgRectangle
            Align = vaMostLeft
            Position.Point = '(4,4)'
            Width = 38.000000000000000000
            Height = 559.000000000000000000
            Padding.Rect = '(4,4,0,4)'
            Fill.Color = '#FFF9D3B8'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaCenter
              Position.Point = '(-7,270)'
              RotateAngle = 90.000000000000000000
              Width = 52.000000000000000000
              Height = 19.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'mostleft'
            end
          end
          object TvgRectangle
            Align = vaLeft
            Position.Point = '(46,45)'
            Width = 33.000000000000000000
            Height = 481.000000000000000000
            Padding.Rect = '(4,0,0,4)'
            Fill.Color = '#FFBCF691'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaCenter
              Position.Point = '(-6,230)'
              RotateAngle = 90.000000000000000000
              Width = 46.000000000000000000
              Height = 21.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'left'
            end
          end
          object TvgRectangle
            Align = vaRight
            Position.Point = '(660,45)'
            Width = 39.000000000000000000
            Height = 481.000000000000000000
            Padding.Rect = '(0,0,4,4)'
            Fill.Color = '#FFA2C9F9'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaCenter
              Position.Point = '(0,231)'
              RotateAngle = -90.000000000000000000
              Width = 40.000000000000000000
              Height = 19.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'right'
            end
          end
          object TvgRectangle
            Align = vaBottom
            Position.Point = '(46,530)'
            Width = 653.000000000000000000
            Height = 33.000000000000000000
            Padding.Rect = '(4,0,4,4)'
            Fill.Color = '#FFEFF47A'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaCenter
              Position.Point = '(301,8)'
              Width = 51.000000000000000000
              Height = 17.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'bottom'
            end
          end
          object TvgRectangle
            Align = vaLeft
            Position.Point = '(83,45)'
            Width = 127.000000000000000000
            Height = 481.000000000000000000
            Padding.Rect = '(4,0,4,4)'
            Fill.Color = '#FFF9BBBB'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgText
              Align = vaBottom
              Position.Point = '(0,463)'
              Width = 127.000000000000000000
              Height = 18.000000000000000000
              Font.Size = 11.000000953674320000
              Text = 'client'
            end
            object TvgRoundRect
              Align = vaVertCenter
              Position.Point = '(4,204)'
              Width = 119.000000000000000000
              Height = 55.000000000000000000
              Padding.Rect = '(4,4,4,4)'
              Fill.Color = '#FFCDBDFB'
              object TvgText
                Align = vaCenter
                Position.Point = '(0,17)'
                Width = 119.000000000000000000
                Height = 21.000000000000000000
                Font.Size = 11.000000953674320000
                Text = 'vertcenter'
              end
            end
          end
          object TvgRectangle
            Align = vaClient
            Position.Point = '(214,45)'
            Width = 442.000000000000000000
            Height = 481.000000000000000000
            Padding.Rect = '(0,0,4,4)'
            xRadius = 5.000000000000000000
            yRadius = 5.000000000000000000
            object TvgRectangle
              Align = vaClient
              Position.Point = '(13,13)'
              Width = 362.000000000000000000
              Height = 374.000000000000000000
              Padding.Rect = '(13,13,13,13)'
              Fill.Color = '#FFB0FDD8'
              xRadius = 7.000000000000000000
              yRadius = 7.000000000000000000
              object TvgEllipse
                Align = vaScale
                Position.Point = '(4.568,41.555)'
                Width = 89.162551879882810000
                Height = 104.469268798828100000
                Fill.Style = vgBrushGradient
                Fill.Gradient.Points = <
                  item
                    Color = '#FF7A7575'
                  end
                  item
                    Color = '#FFFFFFFF'
                    Offset = 1.000000000000000000
                  end>
                Fill.Gradient.Style = vgLinearGradient
                object TvgText
                  Align = vaCenter
                  Position.Point = '(25,44)'
                  Width = 39.000000000000000000
                  Height = 16.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'scale'
                end
              end
              object TvgText
                Align = vaTop
                Position.Point = '(4,4)'
                Width = 354.000000000000000000
                Height = 52.000000000000000000
                Padding.Rect = '(4,4,4,4)'
                Font.Size = 10.000000000000000000
                VertTextAlign = vgTextAlignNear
                Text = 'Usage of Align, Padding, Margins, RotateAngle properties'
              end
              object TvgEllipse
                Align = vaFit
                Position.Point = '(12,20)'
                Width = 337.860229492187500000
                Height = 349.000000000000000000
                Padding.Rect = '(5,20,5,5)'
                Fill.Color = '#3034C5FB'
                Stroke.Color = '#FFFF0000'
                object TvgText
                  Align = vaTop
                  Width = 337.860229492187500000
                  Height = 15.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'fit'
                end
                object TvgEllipse
                  Align = vaCenter
                  Position.Point = '(94,101)'
                  Width = 149.000000000000000000
                  Height = 146.000000000000000000
                  Padding.Rect = '(0,-15,0,0)'
                  Fill.Color = '#FFFFFFFF'
                  Stroke.Color = '#FFFF0000'
                  StrokeThickness = 2.000000000000000000
                  object TvgText
                    Align = vaCenter
                    Position.Point = '(54,63)'
                    Width = 41.000000000000000000
                    Height = 19.000000000000000000
                    Font.Size = 11.000000953674320000
                    Text = 'center'
                  end
                end
              end
              object TvgRoundRect
                Align = vaBottomRight
                Position.Point = '(262,342)'
                Width = 96.000030517578130000
                Height = 27.000000000000000000
                Padding.Rect = '(4,4,4,4)'
                object TvgText
                  Align = vaCenter
                  Position.Point = '(10,3)'
                  Width = 75.000000000000000000
                  Height = 21.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'bottomright'
                end
              end
              object TvgRoundRect
                Align = vaBottomLeft
                Position.Point = '(4,342)'
                Width = 96.000030517578130000
                Height = 27.000000000000000000
                Padding.Rect = '(4,4,4,4)'
                object TvgText
                  Align = vaCenter
                  Position.Point = '(9,3)'
                  Width = 77.000000000000000000
                  Height = 21.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'bottomleft'
                end
              end
              object TvgRoundRect
                Align = vaTopRight
                Position.Point = '(262,20)'
                Width = 96.000030517578130000
                Height = 27.000000000000000000
                Padding.Rect = '(4,4,4,4)'
                object TvgText
                  Align = vaCenter
                  Position.Point = '(9,3)'
                  Width = 77.000000000000000000
                  Height = 21.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'topright'
                end
              end
            end
            object TvgRectangle
              Align = vaBottom
              Position.Point = '(4,400)'
              Width = 434.000000000000000000
              Height = 77.000000000000000000
              Padding.Rect = '(4,0,4,4)'
              Fill.Color = '#FF8B8B8B'
              xRadius = 5.000000000000000000
              yRadius = 5.000000000000000000
              object TvgText
                Position.Point = '(3,25)'
                Width = 52.000000000000000000
                Height = 28.000000000000000000
                Font.Size = 11.000000953674320000
                Text = 'bottom'
              end
              object TvgRoundRect
                Align = vaHorzCenter
                Position.Point = '(158,5)'
                Width = 116.999992370605500000
                Height = 67.000000000000000000
                Padding.Rect = '(5,5,5,5)'
                Fill.Color = '#FFEE7878'
                object TvgText
                  Align = vaCenter
                  Position.Point = '(29,23)'
                  Width = 58.000000000000000000
                  Height = 21.000000000000000000
                  Font.Size = 11.000000953674320000
                  Text = 'horzcenter'
                end
              end
            end
            object TvgRectangle
              Align = vaRight
              Position.Point = '(388,4)'
              Width = 50.000000000000000000
              Height = 392.000000000000000000
              Padding.Rect = '(0,4,4,4)'
              Fill.Color = '#FF929292'
              xRadius = 5.000000000000000000
              yRadius = 5.000000000000000000
              object TvgText
                Align = vaCenter
                Position.Point = '(0,186)'
                RotateAngle = -90.000000000000000000
                Width = 49.000000000000000000
                Height = 20.000000000000000000
                Font.Size = 11.000000953674320000
                Text = 'right'
              end
            end
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 48
    Top = 118
    Width = 619
    Height = 437
    Caption = 'Panel1'
    TabOrder = 1
  end
end

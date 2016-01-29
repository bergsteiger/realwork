object Form14: TForm14
  Left = 547
  Top = 208
  Width = 493
  Height = 485
  Caption = 'VGScene Graph'
  Color = clBtnFace
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
    Width = 477
    Height = 447
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 477.000000000000000000
      Height = 447.000000000000000000
      object TrackBar1: TvgTrackBar
        Position.Point = '(66,9)'
        Width = 111.000000000000000000
        Height = 15.000000000000000000
        TabOrder = 0
        Min = 5.000000000000000000
        Max = 100.000000000000000000
        Orientation = vgHorizontal
        Value = 20.000000000000000000
        Tracking = True
        OnChange = TrackBar1Change
      end
      object Label1: TvgLabel
        Position.Point = '(7,9)'
        Width = 66.000000000000000000
        Height = 15.000000000000000000
        TabOrder = 1
        Font.Size = 11.000000953674320000
        TextAlign = vgTextAlignCenter
        VertTextAlign = vgTextAlignCenter
        Text = 'Scale:'
      end
      object Rectangle1: TvgRectangle
        Align = vaClient
        Position.Point = '(5,35)'
        Width = 467.000000000000000000
        Height = 407.000000000000000000
        Padding.Rect = '(5,35,5,5)'
        Fill.Color = '#FF313131'
        Stroke.Color = '#FF353535'
        xRadius = 5.000000000000000000
        yRadius = 5.000000000000000000
        Sides = [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight]
        object PlotGrid1: TvgPlotGrid
          Align = vaClient
          Position.Point = '(2,2)'
          Width = 463.000000000000000000
          Height = 403.000000000000000000
          Padding.Rect = '(2,2,2,2)'
          OnMouseWheel = PlotGrid1MouseWheel
          OnPaint = PlotGrid1Paint
          LineFill.Color = '#FF616161'
          Marks = 4.000000000000000000
          Frequency = 10.000000000000000000
        end
      end
    end
  end
end

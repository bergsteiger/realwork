object frmChild: TfrmChild
  Left = 495
  Top = 233
  Width = 627
  Height = 538
  Caption = 'frmChild'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frameScene1: TvgScene
    Left = 0
    Top = 0
    Width = 611
    Height = 500
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 611.000000000000000000
      Height = 500.000000000000000000
      Margins.Rect = '(5,5,5,5)'
      Fill.Color = '#00E0E0E0'
      Fill.Style = vgBrushSolid
      object Rectangle1: TvgRectangle
        Align = vaClient
        Position.Point = '(5,48)'
        Width = 601.000000000000000000
        Height = 447.000000000000000000
        Fill.Color = '#A95375F2'
        StrokeThickness = 3.000000000000000000
        xRadius = 9.000000000000000000
        yRadius = 9.000000000000000000
        Sides = [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight]
        object HudTrackBar1: TvgHudTrackBar
          Align = vaCenter
          Position.Point = '(243,216)'
          Width = 114.000000000000000000
          Height = 15.000000000000000000
          TabOrder = 0
          Max = 1.000000000000000000
          Frequency = 0.009999999776482582
          Orientation = vgHorizontal
          Tracking = True
        end
        object Label2: TvgLabel
          Align = vaCenter
          Position.Point = '(148,236)'
          Width = 304.000000000000000000
          Height = 55.000000000000000000
          Padding.Rect = '(0,80,0,0)'
          TabOrder = 1
          BindingSource = HudTrackBar1
          Font.Size = 18.000000000000000000
          TextAlign = vgTextAlignCenter
          Text = '0'
        end
      end
      object Label1: TvgLabel
        Align = vaTop
        Position.Point = '(5,5)'
        Width = 601.000000000000000000
        Height = 43.000000000000000000
        TabOrder = 1
        TextAlign = vgTextAlignCenter
        Text = 
          'This is TvgScene in TvgScene using TvgFrame. To allow transparen' +
          'cy, set second TvgScene.Root.Fill.Color to #0'
      end
    end
  end
end

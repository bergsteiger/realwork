object Form15: TForm15
  Left = 484
  Top = 239
  Width = 573
  Height = 520
  Caption = 'VGScene Path'
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
    Width = 557
    Height = 482
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 557.000000000000000000
      Height = 482.000000000000000000
      object PaintRect: TvgRectangle
        Position.Point = '(13,72)'
        Width = 534.000000000000000000
        Height = 395.000000000000000000
        OnMouseDown = PaintRectMouseDown
        OnMouseMove = PaintRectMouseMove
        OnMouseUp = PaintRectMouseUp
        OnPaint = PaintRectPaint
        xRadius = 5.000000000000000000
        yRadius = 5.000000000000000000
      end
      object CompoundTrackBar1: TvgCompoundTrackBar
        Position.Point = '(15,19)'
        Width = 200.000000000000000000
        Height = 20.000000000000000000
        TabOrder = 1
        TextLabel.Align = vaLeft
        TextLabel.Locked = True
        TextLabel.Width = 70.000000000000000000
        TextLabel.Height = 20.000000000000000000
        TextLabel.Padding.Rect = '(0,0,5,0)'
        TextLabel.TabOrder = 0
        TextLabel.TextAlign = vgTextAlignFar
        TextLabel.Text = 'Stroke Width:'
        TextLabel.WordWrap = False
        TrackBar.Align = vaVertCenter
        TrackBar.Position.Point = '(0,2)'
        TrackBar.Locked = True
        TrackBar.Width = 75.000000000000000000
        TrackBar.Height = 15.000000000000000000
        TrackBar.TabOrder = 0
        TrackBar.Min = 1.000000000000000000
        TrackBar.Max = 20.000000000000000000
        TrackBar.Orientation = vgHorizontal
        TrackBar.Value = 7.000000000000000000
        TrackBar.Tracking = True
        ValueLabel.Align = vaVertCenter
        ValueLabel.Position.Point = '(5,2)'
        ValueLabel.Locked = True
        ValueLabel.Width = 45.000000000000000000
        ValueLabel.Height = 15.000000000000000000
        ValueLabel.Padding.Rect = '(5,0,0,0)'
        ValueLabel.TabOrder = 0
        ValueLabel.TextAlign = vgTextAlignCenter
        ValueLabel.Text = '7.00 '
      end
      object Label1: TvgLabel
        Position.Point = '(238,21)'
        Width = 307.000000000000000000
        Height = 15.000000000000000000
        TabOrder = 2
        TextAlign = vgTextAlignNear
        Text = 'How to Interpolate using Bezier curve'
      end
    end
  end
end

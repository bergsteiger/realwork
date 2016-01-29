object Form1: TForm1
  Left = 573
  Top = 201
  Width = 588
  Height = 563
  ActiveControl = vgScene1
  Caption = 'VGScene Stress Test - 10000 Objects'
  Color = 5263440
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 572
    Height = 525
    Align = alClient
    ActiveControl = ScrollBox1
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Align = vaClient
      Width = 572.000000000000000000
      Height = 525.000000000000000000
      HitTest = False
      object ScrollBox1: TvgScrollBox
        Align = vaClient
        Width = 572.000000000000000000
        Height = 525.000000000000000000
        ClipChildren = True
        TabOrder = 0
        ShowSizeGrip = True
      end
      object SizeGrip1: TvgSizeGrip
        Position.Point = '(737,583)'
        Width = 19.000000000000000000
        Height = 17.000000000000000000
        TabOrder = 1
      end
      object Selection1: TvgSelection
        Position.Point = '(112,109)'
        Width = 198.000000000000000000
        Height = 147.000000000000000000
        GripSize = 3.000000000000000000
        HideSelection = False
        Proportional = False
        object Rectangle1: TvgRectangle
          Align = vaContents
          Width = 198.000000000000000000
          Height = 147.000000000000000000
          HitTest = False
          Fill.Color = '#8A116EA8'
          Stroke.Style = vgBrushNone
          xRadius = 4.000000000000000000
          yRadius = 4.000000000000000000
          CornerType = vgCornerInnerRound
          Sides = [vgSideTop, vgSideLeft, vgSideBottom, vgSideRight]
        end
      end
    end
  end
end

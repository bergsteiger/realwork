object frmHUDDemo: TfrmHUDDemo
  Left = 483
  Top = 231
  BorderStyle = bsNone
  Caption = 'VGSCene HUD Controls'
  ClientHeight = 243
  ClientWidth = 489
  Color = clBtnFace
  Constraints.MinHeight = 265
  Constraints.MinWidth = 467
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
    Width = 489
    Height = 243
    Align = alClient
    Transparency = True
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 489.000000000000000000
      Height = 243.000000000000000000
      HitTest = False
      object HudWindow: TvgHudWindow
        Align = vaClient
        Width = 489.000000000000000000
        Height = 243.000000000000000000
        HitTest = False
        TabOrder = 0
        Font.ClearType = False
        Font.Style = vgFontBold
        TextAlign = vgTextAlignCenter
        Text = 'VGScene HUD Controls'
        ButtonAlign = vgButtonAlignRight
        Fill.Color = '#E0085CA8'
        object Layout1: TvgLayout
          Align = vaClient
          Position.Point = '(20,40)'
          Width = 449.000000000000000000
          Height = 168.000000000000000000
          Padding.Rect = '(20,40,20,35)'
          ClipChildren = True
          object HudGroupBox1: TvgHudGroupBox
            Position.Point = '(5,5)'
            Width = 207.000000000000000000
            Height = 105.000000000000000000
            TabOrder = 0
            Font.ClearType = False
            TextAlign = vgTextAlignCenter
            Text = 'Properties :'
            object checkShowCaption: TvgHudCheckBox
              Position.Point = '(17,20)'
              Width = 154.000000000000000000
              Height = 19.000000000000000000
              TabOrder = 0
              IsChecked = True
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Show Caption'
              OnChange = checkShowCaptionChange
            end
            object checkShowClose: TvgHudCheckBox
              Position.Point = '(17,38)'
              Width = 154.000000000000000000
              Height = 19.000000000000000000
              TabOrder = 1
              IsChecked = True
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Show Close button'
              OnChange = checkShowCloseChange
            end
            object checkShowGrip: TvgHudCheckBox
              Position.Point = '(17,55)'
              Width = 120.000000000000000000
              Height = 19.000000000000000000
              TabOrder = 2
              IsChecked = True
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Show Size grip'
              OnChange = checkShowGripChange
            end
            object radioButtonLeft: TvgHudRadioButton
              Position.Point = '(69,76)'
              Width = 56.000000000000000000
              Height = 19.000000000000000000
              TabOrder = 3
              IsChecked = False
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'left'
              OnChange = radioButtonLeftChange
            end
            object HudLabel2: TvgHudLabel
              Position.Point = '(17,78)'
              Width = 50.000000000000000000
              Height = 15.000000000000000000
              TabOrder = 4
              Font.ClearType = False
              TextAlign = vgTextAlignCenter
              Text = 'Button :'
            end
            object radioButtonRight: TvgHudRadioButton
              Position.Point = '(125,76)'
              Width = 70.000000000000000000
              Height = 19.000000000000000000
              TabOrder = 5
              IsChecked = True
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'right'
              OnChange = radioButtonLeftChange
            end
          end
          object HudGroupBox2: TvgHudGroupBox
            Position.Point = '(214,5)'
            Width = 205.000000000000000000
            Height = 105.000000000000000000
            TabOrder = 1
            Font.ClearType = False
            TextAlign = vgTextAlignCenter
            Text = 'Fill & Stroke:'
            object buttonFill: TvgHudButton
              Position.Point = '(13,21)'
              Width = 73.000000000000000000
              Height = 26.000000000000000000
              OnClick = buttonFillClick
              TabOrder = 0
              StaysPressed = False
              IsPressed = False
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Fill...'
              object fillColor: TvgRoundRect
                Align = vaRight
                Position.Point = '(41,5)'
                Width = 27.000000000000000000
                Height = 16.000000000000000000
                Padding.Rect = '(5,5,5,5)'
                HitTest = False
                Fill.Color = '#E0085CA8'
                Stroke.Color = '#87FFFFFF'
              end
            end
            object btnStroke: TvgHudButton
              Position.Point = '(104,21)'
              Width = 85.000000000000000000
              Height = 26.000000000000000000
              OnClick = btnStrokeClick
              TabOrder = 1
              StaysPressed = False
              IsPressed = False
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Stroke...'
              object strokeColor: TvgRoundRect
                Align = vaRight
                Position.Point = '(53,5)'
                Width = 27.000000000000000000
                Height = 16.000000000000000000
                Padding.Rect = '(5,5,5,5)'
                HitTest = False
                Fill.Color = '#5B000000'
                Stroke.Color = '#80FFFFFF'
              end
            end
            object HudLabel3: TvgHudLabel
              Position.Point = '(13,58)'
              Width = 107.000000000000000000
              Height = 15.000000000000000000
              TabOrder = 2
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Stroke Thickness:'
            end
            object trackStrokeThickness: TvgHudTrackBar
              Position.Point = '(109,58)'
              Width = 85.000000000000000000
              Height = 15.000000000000000000
              TabOrder = 3
              Min = 1.000000000000000000
              Max = 4.000000000000000000
              Orientation = vgHorizontal
              Value = 1.000000000000000000
              Tracking = True
              OnChange = trackStrokeThicknessChange
            end
            object HudLabel4: TvgHudLabel
              Position.Point = '(13,78)'
              Width = 81.000000000000000000
              Height = 15.000000000000000000
              TabOrder = 4
              Font.ClearType = False
              TextAlign = vgTextAlignNear
              Text = 'Stroke Dash:'
            end
            object popupStrokeDash: TvgHudPopupBox
              Position.Point = '(92,76)'
              Width = 102.000000000000000000
              Height = 21.000000000000000000
              TabOrder = 5
              StaysPressed = False
              IsPressed = False
              Font.ClearType = False
              TextAlign = vgTextAlignCenter
              Items.strings = (
                'Solid'
                'Dash'
                'Dot'
                'DashDot'
                'DashDotDot')
              ItemIndex = 0
              OnChange = popupStrokeDashChange
            end
          end
          object HudButton1: TvgHudButton
            Align = vaBottomRight
            Position.Point = '(352,144)'
            Width = 96.000000000000000000
            Height = 22.000000000000000000
            OnClick = HudButton1Click
            TabOrder = 2
            StaysPressed = False
            IsPressed = False
            Font.ClearType = False
            TextAlign = vgTextAlignCenter
            Text = 'Close'
          end
        end
        object HudLabel1: TvgHudLabel
          Align = vaBottomLeft
          Position.Point = '(20,211)'
          Width = 61.000000000000000000
          Height = 15.000000000000000000
          TabOrder = 1
          Font.ClearType = False
          TextAlign = vgTextAlignNear
          Text = 'Opacity:'
        end
        object OpacityTrack: TvgHudTrackBar
          Align = vaBottomLeft
          Position.Point = '(69,211)'
          Width = 100.000000000000000000
          Height = 15.000000000000000000
          TabOrder = 2
          Min = 0.100000001490116100
          Max = 1.000000000000000000
          Orientation = vgHorizontal
          Value = 1.000000000000000000
          Tracking = True
          OnChange = OpacityTrackChange
        end
      end
    end
  end
  object vgBrushDialog1: TvgBrushDialog
    ShowStyles = [vgBrushNone, vgBrushSolid, vgBrushGradient]
    ShowMakeResource = False
    Title = 'Brush'
    Left = 240
    Top = 8
  end
end

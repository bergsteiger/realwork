object frmPopup: TfrmPopup
  Left = 462
  Top = 253
  Width = 687
  Height = 394
  Caption = 'VGScene Popup'
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
    Width = 671
    Height = 356
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 671.000000000000000000
      Height = 356.000000000000000000
      Popup = ContextPopup
      HelpType = htKeyword
      object RoundRect1: TvgRoundRect
        Align = vaBottomLeft
        Position.Point = '(5,261)'
        Width = 230.000000000000000000
        Height = 89.000000000000000000
        OnMouseUp = RoundRect1MouseUp
        object Text1: TvgText
          Align = vaCenter
          Position.Point = '(47,19)'
          Width = 136.000000000000000000
          Height = 50.000000000000000000
          HitTest = False
          Text = 
            'Click to show|hide Popup with TvgPath and bitmap effect. Placeme' +
            'nt = Bottom'
        end
      end
      object RoundRect2: TvgRoundRect
        Position.Point = '(5,4)'
        Width = 230.000000000000000000
        Height = 89.000000000000000000
        OnMouseUp = RoundRect2MouseUp
        object TvgText
          Align = vaCenter
          Position.Point = '(47,19)'
          Width = 136.000000000000000000
          Height = 50.000000000000000000
          HitTest = False
          Text = 'Click to display Popup with animation. Placement = Left'
        end
      end
      object Text3: TvgText
        Position.Point = '(292,259)'
        Width = 270.000000000000000000
        Height = 77.000000000000000000
        HitTest = False
        Font.ClearType = False
        Text = 
          'TvgPopup can be easy hidden in design-time. Just set DesignHide=' +
          'true, or select "Hide in Design-Time" in object context menu.'
        object ShadowEffect1: TvgShadowEffect
          Distance = 3.000000000000000000
          Direction = 45.000000000000000000
          Softness = 0.300000011920929000
          Opacity = 0.600000023841857900
          ShadowColor = '#FF000000'
        end
      end
      object Text5: TvgText
        Position.Point = '(307,14)'
        Width = 243.000000000000000000
        Height = 64.000000000000000000
        HitTest = False
        Font.ClearType = False
        Text = 
          'When StayOpen=false, TvgPopup window closed when popup focus cha' +
          'nged.'
        object TvgShadowEffect
          Distance = 3.000000000000000000
          Direction = 45.000000000000000000
          Softness = 0.300000011920929000
          Opacity = 0.600000023841857900
          ShadowColor = '#FF000000'
        end
      end
      object Popup1: TvgPopup
        Position.Point = '(39,247)'
        Width = 179.000000000000000000
        Height = 174.000000000000000000
        HelpType = htKeyword
        TabOrder = 4
        IsOpen = False
        PlacementTarget = RoundRect1
        StaysOpen = True
        DragWithParent = True
        object Path1: TvgCalloutPanel
          Align = vaClient
          Position.Point = '(9,1)'
          Width = 161.000000000000000000
          Height = 164.000000000000000000
          Padding.Rect = '(9,1,9,9)'
          Opacity = 0.899999976158142100
          HelpType = htKeyword
          TabOrder = 0
          CalloutWidth = 23.000000000000000000
          CalloutLength = 22.000000000000000000
          object Text2: TvgText
            Align = vaCenter
            Position.Point = '(7,40)'
            Width = 146.000000000000000000
            Height = 83.000000000000000000
            Fill.Color = '#FFEAEAEA'
            Text = 'DragWithParent = true StaysOpen=true'
          end
          object ShadowEffect2: TvgShadowEffect
            Distance = 3.000000000000000000
            Direction = 45.000000000000000000
            Softness = 0.300000011920929000
            Opacity = 0.600000023841857900
            ShadowColor = '#FF000000'
          end
        end
      end
      object Popup3: TvgPopup
        Position.Point = '(-28,0)'
        Width = 265.000000000000000000
        Height = 232.000000000000000000
        HitTest = False
        HelpType = htKeyword
        TabOrder = 5
        IsOpen = False
        Placement = vgPlacementLeftCenter
        PlacementTarget = RoundRect2
        object ShowAnimation: TvgFloatAnimation
          Duration = 0.500000000000000000
          HideOnFinish = False
          Trigger = 'IsOpen=true'
          StopValue = 1.000000000000000000
          PropertyName = 'Opacity'
        end
        object HideAnimation: TvgFloatAnimation
          Duration = 0.500000000000000000
          HideOnFinish = False
          Trigger = 'IsOpen=false'
          StartValue = 1.000000000000000000
          StopValue = 0.001000000047497451
          PropertyName = 'Opacity'
        end
        object CalloutRect1: TvgCalloutPanel
          Align = vaClient
          Position.Point = '(12,12)'
          Width = 235.000000000000000000
          Height = 202.000000000000000000
          Padding.Rect = '(12,12,18,18)'
          HitTest = False
          HelpType = htKeyword
          TabOrder = 0
          CalloutWidth = 23.000000000000000000
          CalloutLength = 11.000000000000000000
          CalloutPosition = vgCalloutRight
          object HudStringListBox1: TvgHudStringListBox
            Align = vaLeft
            Position.Point = '(2,2)'
            Width = 127.000000000000000000
            Height = 198.000000000000000000
            Padding.Rect = '(2,2,2,2)'
            HelpType = htKeyword
            Resource = 'hudlistboxstyle'
            TabOrder = 0
            ItemIndex = 0
            ItemHeight = 19.000000000000000000
            Font.ClearType = False
            Items.strings = (
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item'
              'list box item')
          end
          object Text4: TvgText
            Position.Point = '(129,62)'
            Width = 102.000000000000000000
            Height = 74.000000000000000000
            Font.ClearType = False
            Text = 'StaysOpen=false'
          end
          object ShadowEffect4: TvgShadowEffect
            Distance = 3.000000000000000000
            Direction = 45.000000000000000000
            Softness = 0.300000011920929000
            Opacity = 0.600000023841857900
            ShadowColor = '#FF000000'
          end
        end
      end
      object Text6: TvgText
        Position.Point = '(313,129)'
        Width = 243.000000000000000000
        Height = 64.000000000000000000
        HitTest = False
        Popup = Popup1
        Fill.Color = '#FFE7E7E7'
        Text = 
          'Right click on the client area to show Context Popup. Context Po' +
          'pup can be set using Popup property of control.'
      end
      object ContextPopup: TvgPopup
        Position.Point = '(393,117)'
        Width = 233.000000000000000000
        Height = 140.000000000000000000
        HelpType = htKeyword
        TabOrder = 7
        IsOpen = False
        Placement = vgPlacementMouseCenter
        PlacementTarget = RoundRect1
        StaysOpen = True
        DragWithParent = True
        object CalloutRect2: TvgCalloutPanel
          Align = vaClient
          Position.Point = '(9,1)'
          Width = 215.000000000000000000
          Height = 130.000000000000000000
          Padding.Rect = '(9,1,9,9)'
          Opacity = 0.949999988079071000
          HelpType = htKeyword
          TabOrder = 0
          CalloutWidth = 23.000000000000000000
          CalloutLength = 11.000000000000000000
          object TvgText
            Align = vaCenter
            Position.Point = '(34,23)'
            Width = 146.000000000000000000
            Height = 83.000000000000000000
            Fill.Color = '#FFECECEC'
            Text = 
              'This is context popup. You can place all controls to this popup.' +
              ' To use with callout just set Placement to vgPlacmentMouseCenter'
          end
          object ShadowEffect6: TvgShadowEffect
            Distance = 3.000000000000000000
            Direction = 45.000000000000000000
            Softness = 0.300000011920929000
            Opacity = 0.600000023841857900
            ShadowColor = '#FF000000'
          end
        end
      end
    end
  end
end

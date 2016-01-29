object frmMain: TfrmMain
  Left = 469
  Top = 237
  Width = 719
  Height = 535
  ActiveControl = vgScene1
  Caption = 'VGScene Frame'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 703
    Height = 497
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 703.000000000000000000
      Height = 497.000000000000000000
      Margins.Rect = '(9,9,9,9)'
      object Label1: TvgLabel
        Align = vaTop
        Position.Point = '(9,9)'
        Width = 685.000000000000000000
        Height = 50.000000000000000000
        TabOrder = 1
        TextAlign = vgTextAlignCenter
        Text = 
          'This demo show - how to use  another VGScene object  (in another' +
          ' form) as child. VGscene can'#39't use self deigner in TFrame. To al' +
          'low  designer use TForm for  second VGScene container. To see se' +
          'cond VGscene object in TvgFrame.SceneObject, please add second u' +
          'nit to main form uses section.'
      end
      object Panel1: TvgPanel
        Align = vaClient
        Position.Point = '(323,59)'
        Width = 371.000000000000000000
        Height = 429.000000000000000000
        Margins.Rect = '(8,8,8,8)'
        TabOrder = 0
        object Frame1: TvgFrame
          Align = vaClient
          Position.Point = '(8,8)'
          Width = 355.000000000000000000
          Height = 413.000000000000000000
          SceneObject = frmChild.frameScene1
        end
      end
      object Panel2: TvgPanel
        Align = vaLeft
        Position.Point = '(9,59)'
        Width = 309.000000000000000000
        Height = 429.000000000000000000
        TabOrder = 2
        object Frame2: TvgFrame
          Align = vaClient
          Position.Point = '(5,5)'
          Width = 299.000000000000000000
          Height = 419.000000000000000000
          Padding.Rect = '(5,5,5,5)'
          SceneObject = frmChild.frameScene1
        end
      end
      object Splitter1: TvgSplitter
        Align = vaLeft
        Cursor = crHSplit
        Position.Point = '(318,59)'
        Width = 5.000000000000000000
        Height = 429.000000000000000000
        TabOrder = 3
        MinSize = 160.000000000000000000
      end
    end
  end
end

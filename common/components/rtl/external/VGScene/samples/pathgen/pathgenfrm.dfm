object Form16: TForm16
  Left = 374
  Top = 218
  Width = 878
  Height = 566
  Caption = 'Char to Path'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 862
    Height = 528
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 862.000000000000000000
      Height = 528.000000000000000000
      object samplePath: TvgPath
        Align = vaClient
        Position.Point = '(400,49)'
        Width = 443.000000000000000000
        Height = 460.000000000000000000
        Padding.Rect = '(19,49,19,19)'
        HitTest = False
        Data.Path = {
          210000000000000021A0B6430E7DA04301000000EEFC8A43F853BA4301000000
          D93EA543F40DE24301000000022B7F43F883E443010000001DCA8E437D5F0944
          01000000C7AB3143086CFC4301000000CB81014300A00C4401000000A2058542
          7DEF004401000000AE47E1BDFC610E44010000000CC284C27DEF004401000000
          E30501C300A00C4401000000213031C3086CFC4301000000298C8EC37D5F0944
          010000005CAF7EC3F883E44301000000E500A5C3F40DE243010000001BBF8AC3
          F853BA43010000004E62B6C30E7DA043010000001BBF8AC30A87874301000000
          A0BAA5C319C44243010000005CAF7EC3E7BB3B4301000000298C8EC310D8BD42
          01000000213031C3EC910B4301000000E30501C33188A442010000000CC284C2
          08AC004301000000A4701D3FCF77964201000000A205854208AC004301000000
          CB8101433188A44201000000C7AB3143EC910B43010000001DCA8E4310D8BD42
          01000000022B7F43E7BB3B430100000073F8A54319C4424301000000EEFC8A43
          0A878743030000000000000000000000}
        Fill.Color = '#FF6E6E6E'
        Stroke.Color = '#FFCFCFCF'
        StrokeThickness = 4.000000000000000000
        WrapMode = vgPathFit
      end
      object HudButton1: TvgHudButton
        Position.Point = '(9,5)'
        Width = 141.000000000000000000
        Height = 28.000000000000000000
        OnClick = HudButton1Click
        TabOrder = 1
        StaysPressed = False
        IsPressed = False
        Font.Size = 11.000000953674320000
        TextAlign = vgTextAlignCenter
        Text = 'Change Font...'
      end
      object charMap: TvgHudListBox
        Align = vaLeft
        Position.Point = '(9,40)'
        Width = 372.000000000000000000
        Height = 479.000000000000000000
        Padding.Rect = '(9,40,0,9)'
        TabOrder = 2
        Columns = 6
        HideSelectionUnfocused = False
        ItemIndex = 0
        ItemWidth = 54.000000000000000000
        ItemHeight = 54.000000000000000000
        OnChange = charMapChange
      end
      object PathData: TvgHudMemo
        Align = vaClient
        Position.Point = '(390,40)'
        Width = 463.000000000000000000
        Height = 479.000000000000000000
        Padding.Rect = '(9,40,9,9)'
        Opacity = 0.500000000000000000
        TabOrder = 3
        WordWrap = True
        Font.Size = 11.000000953674320000
      end
      object labelSample: TvgLabel
        Position.Point = '(160,5)'
        Width = 217.000000000000000000
        Height = 28.000000000000000000
        TabOrder = 4
        Font.Size = 12.000000000000000000
        TextAlign = vgTextAlignCenter
        Text = 'Webdings'
      end
      object HudButton2: TvgHudButton
        Position.Point = '(390,5)'
        Width = 124.000000000000000000
        Height = 28.000000000000000000
        OnClick = HudButton2Click
        TabOrder = 5
        StaysPressed = False
        IsPressed = False
        TextAlign = vgTextAlignCenter
        Text = 'Copy to Clipboard'
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 584
    Top = 14
  end
end

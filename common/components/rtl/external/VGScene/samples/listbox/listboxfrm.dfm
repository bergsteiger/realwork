object frmListBoxDemo: TfrmListBoxDemo
  Left = 387
  Top = 174
  Width = 715
  Height = 545
  ActiveControl = vgScene1
  Caption = 'VGScene ListBox'
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
    Width = 699
    Height = 507
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 699.000000000000000000
      Height = 507.000000000000000000
      object TabControl1: TvgTabControl
        Align = vaClient
        Position.Point = '(19,19)'
        Width = 661.000000000000000000
        Height = 469.000000000000000000
        Padding.Rect = '(19,19,19,19)'
        ClipChildren = True
        TabOrder = 0
        ItemIndex = 0
        object TabItem1: TvgTabItem
          Index = 0
          Width = 81.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 0
          Font.Size = 11.000000953674320000
          TextAlign = vgTextAlignCenter
          Text = 'Columns'
          Layout = Layout1
        end
        object TabItem2: TvgTabItem
          Index = 1
          Position.Point = '(81,0)'
          Width = 158.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 1
          Font.Size = 11.000000953674320000
          TextAlign = vgTextAlignCenter
          Text = 'ItemWidth, ItemHeight'
          Layout = Layout2
        end
        object TabItem3: TvgTabItem
          Index = 2
          Position.Point = '(239,0)'
          Width = 85.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 2
          Font.Size = 11.000000953674320000
          TextAlign = vgTextAlignCenter
          Text = 'Image List'
          Layout = Layout5
        end
        object TabItem4: TvgTabItem
          Index = 3
          Position.Point = '(324,0)'
          Width = 120.000000000000000000
          Height = 24.000000000000000000
          TabOrder = 7
          TextAlign = vgTextAlignCenter
          Text = 'Alternating Row'
          Layout = Layout6
        end
        object Layout6: TvgLayout
          Position.Point = '(0,24)'
          Width = 661.000000000000000000
          Height = 445.000000000000000000
          ClipChildren = True
          Visible = False
          DesignHide = True
          object StringListBox2: TvgStringListBox
            DragDisableHighlight = True
            Position.Point = '(203,26)'
            Width = 230.000000000000000000
            Height = 358.000000000000000000
            Resource = 'listboxstyle'
            TabOrder = 0
            DisableFocusEffect = True
            AlternatingRowBackground = True
            ItemIndex = 0
            ItemHeight = 31.000000000000000000
            Items.strings = (
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item'
              'Listbox Item')
          end
        end
        object Layout5: TvgLayout
          Position.Point = '(0,24)'
          Width = 661.000000000000000000
          Height = 445.000000000000000000
          ClipChildren = True
          Visible = False
          DesignHide = True
          object ImageListBox1: TvgImageListBox
            Align = vaClient
            Position.Point = '(9,40)'
            Width = 643.000000000000000000
            Height = 396.000000000000000000
            Padding.Rect = '(9,40,9,9)'
            Resource = 'listboxstyle'
            TabOrder = 0
            DisableFocusEffect = True
            Columns = 3
            ItemIndex = 0
            ItemWidth = 199.000015258789100000
            ItemHeight = 199.000015258789100000
            ShowFileName = True
          end
          object Button1: TvgButton
            Position.Point = '(9,10)'
            Width = 262.000000000000000000
            Height = 26.000000000000000000
            OnClick = Button1Click
            TabOrder = 1
            StaysPressed = False
            IsPressed = False
            Font.Size = 11.000000953674320000
            TextAlign = vgTextAlignCenter
            Text = 'Select Image Folder by openning file...'
          end
          object TrackBar4: TvgTrackBar
            Position.Point = '(444,16)'
            Width = 141.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 2
            Min = 64.000000000000000000
            Max = 200.000000000000000000
            Orientation = vgHorizontal
            Value = 199.000015258789100000
            Tracking = True
            OnChange = TrackBar4Change
          end
        end
        object Layout2: TvgLayout
          Position.Point = '(0,24)'
          Width = 661.000000000000000000
          Height = 445.000000000000000000
          ClipChildren = True
          Visible = False
          DesignHide = True
          object Label2: TvgLabel
            Align = vaTop
            Width = 661.000000000000000000
            Height = 36.000000000000000000
            TabOrder = 0
            Font.Size = 11.000000953674320000
            TextAlign = vgTextAlignCenter
            Text = 'TvgListBox.ItemWidth and TvgListBox.ItemHeight property'
          end
          object TrackBar2: TvgTrackBar
            Position.Point = '(133,36)'
            Width = 100.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 1
            Min = 20.000000000000000000
            Max = 100.000000000000000000
            Orientation = vgHorizontal
            Value = 48.000000000000000000
            Tracking = True
            OnChange = TrackBar2Change
          end
          object TrackBar3: TvgTrackBar
            Position.Point = '(363,36)'
            Width = 100.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 2
            Min = 20.000000000000000000
            Max = 100.000000000000000000
            Orientation = vgHorizontal
            Value = 48.000000000000000000
            Tracking = True
            OnChange = TrackBar3Change
          end
          object Label3: TvgLabel
            Position.Point = '(40,36)'
            Width = 87.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 3
            Font.Size = 11.000000953674320000
            TextAlign = vgTextAlignCenter
            Text = 'ItemWidth:'
          end
          object Label4: TvgLabel
            Position.Point = '(272,36)'
            Width = 87.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 4
            Font.Size = 11.000000953674320000
            TextAlign = vgTextAlignCenter
            Text = 'ItemHeight:'
          end
          object Layout4: TvgLayout
            Align = vaClient
            Position.Point = '(9,66)'
            Width = 643.000000000000000000
            Height = 370.000000000000000000
            Padding.Rect = '(9,30,9,9)'
            object ListBox1: TvgListBox
              Align = vaLeft
              Width = 252.000015258789100000
              Height = 370.000000000000000000
              TabOrder = 0
              DisableFocusEffect = True
              Columns = 5
              ItemIndex = 0
              ItemWidth = 48.000000000000000000
              ItemHeight = 48.000000000000000000
            end
            object HorzListBox2: TvgHorzListBox
              Align = vaClient
              Position.Point = '(258,0)'
              Width = 385.000000000000000000
              Height = 370.000000000000000000
              Resource = 'listboxstyle'
              TabOrder = 1
              DisableFocusEffect = True
              Columns = 7
              ItemIndex = -1
              ItemWidth = 48.000000000000000000
              ItemHeight = 48.000000000000000000
            end
            object Splitter2: TvgSplitter
              Align = vaLeft
              Cursor = crHSplit
              Position.Point = '(252.000,0)'
              Width = 6.000000000000000000
              Height = 370.000000000000000000
              TabOrder = 2
              MinSize = 30.000000000000000000
            end
          end
        end
        object Layout1: TvgLayout
          Position.Point = '(0,24)'
          Width = 661.000000000000000000
          Height = 445.000000000000000000
          ClipChildren = True
          object TrackBar1: TvgTrackBar
            Position.Point = '(224,38)'
            Width = 100.000000000000000000
            Height = 15.000000000000000000
            TabOrder = 0
            Min = 1.000000000000000000
            Max = 5.000000000000000000
            Orientation = vgHorizontal
            Value = 3.000000000000000000
            Tracking = True
            OnChange = TrackBar1Change
          end
          object Label1: TvgLabel
            Align = vaTop
            Width = 661.000000000000000000
            Height = 36.000000000000000000
            TabOrder = 1
            Font.Size = 11.000000953674320000
            TextAlign = vgTextAlignCenter
            Text = 'TvgListBox.Columns property'
          end
          object Layout3: TvgLayout
            Align = vaClient
            Position.Point = '(9,66)'
            Width = 643.000000000000000000
            Height = 370.000000000000000000
            Padding.Rect = '(9,30,9,9)'
            object StringListBox1: TvgStringListBox
              Align = vaLeft
              DragDisableHighlight = True
              Width = 266.000000000000000000
              Height = 370.000000000000000000
              Resource = 'listboxstyle'
              TabOrder = 0
              DisableFocusEffect = True
              Columns = 3
              ItemIndex = 0
              ItemHeight = 19.000000000000000000
            end
            object Splitter1: TvgSplitter
              Align = vaLeft
              Cursor = crHSplit
              Position.Point = '(266,0)'
              Width = 7.000000000000000000
              Height = 370.000000000000000000
              TabOrder = 1
              MinSize = 30.000000000000000000
            end
            object HorzListBox1: TvgHorzListBox
              Align = vaClient
              Position.Point = '(273,0)'
              Width = 370.000000000000000000
              Height = 370.000000000000000000
              Resource = 'listboxstyle'
              TabOrder = 2
              DisableFocusEffect = True
              Columns = 3
              ItemIndex = -1
            end
          end
          object CheckBox1: TvgCheckBox
            Position.Point = '(367,36)'
            Width = 253.000000000000000000
            Height = 19.000000000000000000
            TabOrder = 3
            IsChecked = False
            TextAlign = vgTextAlignNear
            Text = 'Touch mode (MouseTracking=true)'
            OnChange = CheckBox1Change
          end
        end
      end
    end
  end
  object OpenPictureDialog1: TOpenDialog
    Left = 334
    Top = 52
  end
end

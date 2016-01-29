object Form6: TForm6
  Left = 176
  Top = 239
  Width = 1040
  Height = 528
  ActiveControl = vgScene1
  Caption = 'VGScene Binding'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object vgScene1: TvgScene
    Left = 0
    Top = 0
    Width = 1024
    Height = 490
    Align = alClient
    DesignSnapGridShow = False
    DesignSnapToGrid = False
    DesignSnapToLines = True
    object Root1: TvgBackground
      Width = 1024.000000000000000000
      Height = 490.000000000000000000
      HelpType = htKeyword
      object ToolBar1: TvgToolBar
        Width = 1024.000000000000000000
        Height = 73.000000000000000000
        HelpType = htKeyword
        TabOrder = 0
        object Label4: TvgLabel
          Align = vaCenter
          Position.Point = '(295,9)'
          Width = 433.000000000000000000
          Height = 55.000000000000000000
          HelpType = htKeyword
          TabOrder = 0
          Font.Size = 12.000000000000000000
          TextAlign = vgTextAlignCenter
          Text = 
            'How to use BindingSource property. This sample haven'#39't a code.  ' +
            'Only VGScene'#39's Binding.'
        end
      end
      object Grid1: TvgGridLayout
        Align = vaClient
        Position.Point = '(4,77)'
        Width = 1016.000000000000000000
        Height = 409.000000000000000000
        Padding.Rect = '(4,4,4,4)'
        ItemHeight = 200.000000000000000000
        ItemWidth = 200.000000000000000000
        Orientation = vgHorizontal
        object Panel1: TvgPanel
          Position.Point = '(2,2)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 0
          object ValueLabel1: TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'TrackBar <-> TextBox and Label'
          end
          object TrackBar1: TvgTrackBar
            Position.Point = '(41,45)'
            Width = 109.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            BindingSource = TextBox1
            Max = 100.000000000000000000
            Frequency = 1.000000000000000000
            Orientation = vgHorizontal
            Tracking = True
          end
          object TextBox1: TvgTextBox
            BindingName = 'text'
            Position.Point = '(13,103)'
            Width = 110.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = TrackBar1
            ReadOnly = False
            Password = False
            Text = '0'
          end
          object Label1: TvgLabel
            Position.Point = '(127,105)'
            Width = 50.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 3
            BindingSource = TrackBar1
            TextAlign = vgTextAlignCenter
            Text = '0'
          end
        end
        object Panel2: TvgPanel
          Position.Point = '(202,2)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 1
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'Two TrackBar <-> sync'
          end
          object t1: TvgTrackBar
            Position.Point = '(30,76)'
            Width = 135.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            BindingSource = t2
            Max = 100.000000000000000000
            Frequency = 0.500000000000000000
            Orientation = vgHorizontal
            Value = 33.000000000000000000
            Tracking = True
          end
          object t2: TvgTrackBar
            Position.Point = '(30,110)'
            Width = 135.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = t1
            Max = 100.000000000000000000
            Frequency = 0.500000000000000000
            Orientation = vgHorizontal
            Value = 33.000000000000000000
            Tracking = True
          end
          object ValueLabel2: TvgValueLabel
            Position.Point = '(56,41)'
            Width = 83.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 3
            BindingSource = t1
            TextAlign = vgTextAlignCenter
            Text = '33'
          end
        end
        object Panel3: TvgPanel
          Position.Point = '(402,2)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 2
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'TextBox -> Label'
          end
          object TextBox2: TvgTextBox
            Position.Point = '(27,105)'
            Width = 149.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            ReadOnly = False
            Password = False
            Text = 'binding text'
          end
          object Label2: TvgLabel
            Position.Point = '(27,46)'
            Width = 149.000000000000000000
            Height = 38.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = TextBox2
            TextAlign = vgTextAlignCenter
            Text = 'binding text'
          end
        end
        object Panel4: TvgPanel
          Position.Point = '(602,2)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 3
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'NumberBox -> Label'
          end
          object NumberBox1: TvgNumberBox
            Position.Point = '(48,104)'
            Width = 100.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            ReadOnly = False
            Max = 100.000000000000000000
            Value = 33.000000000000000000
            ValueType = vgValueInteger
            HorzIncrement = 1.000000000000000000
            VertIncrement = 5.000000000000000000
          end
          object Label3: TvgLabel
            Position.Point = '(73,56)'
            Width = 50.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            Resource = 'valuelabelstyle'
            TabOrder = 2
            BindingSource = NumberBox1
            TextAlign = vgTextAlignCenter
            Text = '33'
          end
        end
        object Panel5: TvgPanel
          Position.Point = '(802,2)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 4
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'TextBox <-> TextBox'
          end
          object TextBox3: TvgTextBox
            Position.Point = '(35,66)'
            Width = 122.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            BindingSource = TextBox4
            ReadOnly = False
            Password = False
            Text = 'TextBox'
          end
          object TextBox4: TvgTextBox
            Position.Point = '(35,111)'
            Width = 122.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = TextBox3
            ReadOnly = False
            Password = False
            Text = 'TextBox'
          end
        end
        object Panel6: TvgPanel
          Position.Point = '(2,202)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 5
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'ListBox <-> TextBox'
          end
          object StringListBox1: TvgStringListBox
            Position.Point = '(30,74)'
            Width = 130.000000000000000000
            Height = 108.000000000000000000
            HelpType = htKeyword
            Resource = 'listboxstyle'
            TabOrder = 1
            HideSelectionUnfocused = False
            ItemIndex = 0
            ItemHeight = 19.000000000000000000
            BindingSource = TextBox5
            Items.strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9')
          end
          object TextBox5: TvgTextBox
            Position.Point = '(45,37)'
            Width = 100.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = StringListBox1
            ReadOnly = False
            Password = False
            Text = '1'
          end
        end
        object Panel7: TvgPanel
          Position.Point = '(202,202)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 6
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'ListBox <-> TextBox'
          end
          object StringComboBox1: TvgStringComboBox
            Position.Point = '(24,38)'
            Width = 148.000000000000000000
            Height = 23.000000000000000000
            HelpType = htKeyword
            Resource = 'comboboxstyle'
            TabOrder = 2
            ItemIndex = 0
            Placement = vgPlacementBottom
            ItemHeight = 19.000000000000000000
            Items.strings = (
              'item 1'
              'item 2'
              'item 3'
              'item 4'
              'item 5'
              'item 6'
              'item 7'
              'item 8')
          end
          object Label5: TvgLabel
            Position.Point = '(40,106)'
            Width = 117.000000000000000000
            Height = 18.000000000000000000
            HelpType = htKeyword
            Resource = 'valuelabelstyle'
            TabOrder = 1
            BindingSource = StringComboBox1
            TextAlign = vgTextAlignCenter
            Text = 'item 1'
          end
        end
        object Panel8: TvgPanel
          Position.Point = '(402,202)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 7
          object TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'TrackBar -> ProgressBar'
          end
          object TrackBar2: TvgTrackBar
            Position.Point = '(48,51)'
            Width = 100.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            Max = 100.000000000000000000
            Orientation = vgHorizontal
            Tracking = True
          end
          object ProgressBar1: TvgProgressBar
            Position.Point = '(16,104)'
            Width = 164.000000000000000000
            Height = 17.000000000000000000
            HelpType = htKeyword
            TabOrder = 2
            BindingSource = TrackBar2
            Max = 100.000000000000000000
            Orientation = vgHorizontal
          end
        end
        object Panel9: TvgPanel
          Position.Point = '(602,202)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 8
          object ValueLabel3: TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            TextAlign = vgTextAlignCenter
            Text = 'Calendar ->'
          end
          object Calendar1: TvgCalendar
            Position.Point = '(8,27)'
            Width = 179.000000000000000000
            Height = 158.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            BindingSource = TextBox6
            Date = 40478.000000000000000000
          end
        end
        object Panel10: TvgPanel
          Position.Point = '(802,202)'
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          Margins.Rect = '(5,5,5,5)'
          Padding.Rect = '(2,2,2,2)'
          HelpType = htKeyword
          TabOrder = 9
          object TextBox6: TvgTextBox
            Position.Point = '(27,105)'
            Width = 149.000000000000000000
            Height = 21.000000000000000000
            HelpType = htKeyword
            TabOrder = 1
            BindingSource = Calendar1
            ReadOnly = False
            Password = False
            Text = '10/27/2010'
          end
          object Label6: TvgLabel
            Position.Point = '(27,46)'
            Width = 149.000000000000000000
            Height = 38.000000000000000000
            HelpType = htKeyword
            TabOrder = 0
            BindingSource = Calendar1
            TextAlign = vgTextAlignCenter
            Text = '10/27/2010'
          end
          object ValueLabel4: TvgValueLabel
            Align = vaTop
            Position.Point = '(5,5)'
            Width = 186.000000000000000000
            Height = 15.000000000000000000
            HelpType = htKeyword
            TabOrder = 3
            TextAlign = vgTextAlignCenter
            Text = '<- Text Controls'
          end
        end
      end
    end
  end
end

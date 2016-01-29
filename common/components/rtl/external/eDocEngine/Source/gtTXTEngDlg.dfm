inherited gtTextEngineDlg: TgtTextEngineDlg
  Left = 192
  Top = 107
  Caption = 'gtTextEngineDlg'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            Height = 374
            inherited chkProcessAfterEachPage: TCheckBox
              Top = 143
            end
          end
        end
        object tsTextFormatting: TTabSheet [1]
          Caption = 'Formatting'
          ImageIndex = 3
          TabVisible = False
          object gbFormatting: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 353
            TabOrder = 0
            object lblTextLineSpacing: TLabel
              Left = 8
              Top = 172
              Width = 77
              Height = 13
              Caption = 'Line Spacing:'
            end
            object lblTextColumnSpacing: TLabel
              Left = 8
              Top = 148
              Width = 98
              Height = 13
              Caption = 'Column Spacing:'
            end
            object lblTextDefaultFont: TLabel
              Left = 8
              Top = 79
              Width = 136
              Height = 13
              Caption = 'Default Document Font:'
            end
            object sbtnSetDefaultFont: TSpeedButton
              Left = 288
              Top = 96
              Width = 20
              Height = 22
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333333333333333333333FFF33FFFFF33333300033000
                00333337773377777333333330333300033333337FF33777F333333330733300
                0333333377FFF777F33333333700000073333333777777773333333333033000
                3333333337FF777F333333333307300033333333377F777F3333333333703007
                33333333377F7773333333333330000333333333337777F33333333333300003
                33333333337777F3333333333337007333333333337777333333333333330033
                3333333333377333333333333333033333333333333733333333333333333333
                3333333333333333333333333333333333333333333333333333}
              NumGlyphs = 2
              OnClick = sbtnSetDefaultFontClick
            end
            object cbLineSpacing: TComboBox
              Left = 112
              Top = 168
              Width = 82
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 4
            end
            object edColumnSpacing: TEdit
              Left = 112
              Top = 144
              Width = 82
              Height = 21
              TabOrder = 3
            end
            object gbSeparatorMode: TGroupBox
              Left = 8
              Top = 16
              Width = 273
              Height = 57
              TabOrder = 1
              object lblSeparator: TLabel
                Left = 16
                Top = 28
                Width = 62
                Height = 13
                Caption = 'Separator:'
              end
              object edSeparator: TEdit
                Left = 96
                Top = 24
                Width = 65
                Height = 21
                TabOrder = 0
              end
            end
            object chkUseSeparator: TCheckBox
              Left = 16
              Top = 16
              Width = 129
              Height = 17
              Caption = 'Use Separator'
              TabOrder = 0
              OnClick = chkUseSeparatorClick
            end
            object pnlDefaultFont: TPanel
              Left = 8
              Top = 96
              Width = 275
              Height = 41
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Caption = 'AaBbYyZz'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object chkTextPageEndLines: TCheckBox
              Left = 8
              Top = 215
              Width = 113
              Height = 17
              Caption = 'Page End Lines'
              TabOrder = 6
            end
            object chkInsertPageBreaks: TCheckBox
              Left = 8
              Top = 194
              Width = 137
              Height = 17
              Caption = 'Insert Page Breaks'
              TabOrder = 5
            end
            object chkTextSingleFile: TCheckBox
              Left = 8
              Top = 236
              Width = 97
              Height = 17
              Caption = 'Single File'
              TabOrder = 7
            end
          end
        end
        inherited tsEMailInfo: TTabSheet [2]
        end
        inherited tsContent: TTabSheet [3]
          inherited gbContentOptions: TGroupBox
            Height = 374
            inherited gbItemsToRender: TGroupBox
              Height = 206
            end
            inherited gbDocInfo: TGroupBox
              Height = 166
            end
          end
        end
        inherited tsBackground: TTabSheet [4]
        end
      end
    end
  end
  inherited OpenPictureDialog: TOpenPictureDialog
    Left = 292
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 320
  end
end

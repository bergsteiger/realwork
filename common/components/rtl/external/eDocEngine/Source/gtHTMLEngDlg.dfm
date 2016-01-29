inherited gtHTMLEngineDlg: TgtHTMLEngineDlg
  Left = 221
  Top = 186
  Caption = 'gtHTMLEngineDlg'
  ClientWidth = 517
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TButton
    Left = 351

  end
  inherited btnCancel: TButton
    Left = 433
     end
  inherited pnlDocDlg: TPanel
    Width = 500

    inherited Panel2: TPanel
      Width = 375

      inherited Panel3: TPanel
        Width = 375

      end
      inherited pcDocument: TPageControl
        Width = 375

        inherited tsPreferences: TTabSheet

          inherited gbPreferences: TGroupBox
            Width = 352

            inherited chkActiveHyperLinks: TCheckBox
              TabOrder = 5
            end
            object chkAutoScrollDocument: TCheckBox
              Left = 8
              Top = 168
              Width = 161
              Height = 17
              Caption = 'Auto Scroll Document'
              TabOrder = 4
            end
          end
        end
        inherited tsContent: TTabSheet

          inherited gbContentOptions: TGroupBox
            Width = 352

            inherited gbItemsToRender: TGroupBox
              Width = 337

            end
            inherited gbDocInfo: TGroupBox
              Width = 337

            end
          end
        end
        inherited tsBackground: TTabSheet

          inherited gbBackground: TGroupBox
            Width = 352

          end
        end
        object tsFileLocationAndOptimization: TTabSheet [3]
          Caption = 'File Location && Optimization'
          ImageIndex = 3
          TabVisible = False
      
          object gbOthers: TGroupBox
            Left = 8
            Top = 0
            Width = 352
            Height = 372
            TabOrder = 0
            object lblDefaultFont: TLabel
              Left = 8
              Top = 175
              Width = 131
              Height = 13
              Caption = 'Default Document Font'
            end
            object sbtnSetDefaultFont: TSpeedButton
              Left = 288
              Top = 192
              Width = 23
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
              OnClick = sbtnSetFontClick
            end
            object chkOptimizeforIE: TCheckBox
              Left = 14
              Top = 38
              Width = 213
              Height = 17
              Caption = 'Optimize for Internet Explorer'
              Checked = True
              State = cbChecked
              TabOrder = 1
            end
            object gbExtCSSFile: TGroupBox
              Left = 8
              Top = 61
              Width = 337
              Height = 49
              TabOrder = 3
              object lblCSSFile: TLabel
                Left = 8
                Top = 24
                Width = 48
                Height = 13
                Caption = 'CSS File'
              end
              object sbtnCSSFileName: TSpeedButton
                Left = 280
                Top = 20
                Width = 23
                Height = 21
                Caption = '...'
                OnClick = sbtnCSSFileNameClick
              end
              object edCSSFile: TEdit
                Left = 105
                Top = 20
                Width = 169
                Height = 21
                TabOrder = 0
              end
            end
            object chkOutputStylesToCSSFile: TCheckBox
              Left = 14
              Top = 59
              Width = 179
              Height = 17
              Caption = 'Output Styles to CSS File'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = chkOutputStylesToCSSFileClick
            end
            object chkPageEndLines: TCheckBox
              Left = 14
              Top = 17
              Width = 193
              Height = 17
              Caption = 'Page End Lines'
              TabOrder = 0
            end
            object gbOuputJSFile: TGroupBox
              Left = 8
              Top = 116
              Width = 337
              Height = 49
              TabOrder = 5
              object lblJSFile: TLabel
                Left = 8
                Top = 24
                Width = 86
                Height = 13
                Caption = 'Java Script File'
              end
              object sbtnJSFileName: TSpeedButton
                Left = 280
                Top = 20
                Width = 23
                Height = 21
                Caption = '...'
                OnClick = sbtnJSFileNameClick
              end
              object edJSFileName: TEdit
                Left = 105
                Top = 20
                Width = 169
                Height = 21
                TabOrder = 0
              end
            end
            object chkOutputScriptsToJSFile: TCheckBox
              Left = 14
              Top = 114
              Width = 227
              Height = 17
              Caption = 'Output Scripts to Java Script File'
              Checked = True
              State = cbChecked
              TabOrder = 4
              OnClick = chkOutputScriptsToJSFileClick
            end
            object pnlDefaultFont: TPanel
              Left = 8
              Top = 192
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
              TabOrder = 6
            end
          end
        end
        object tsNavigatorOptions: TTabSheet [4]
          Caption = 'Navigator Options'
          ImageIndex = 4
          TabVisible = False
          object gbShowNavigator: TGroupBox
            Left = 8
            Top = 20
            Width = 352
            Height = 352
            TabOrder = 2
            object lblNavigatorBackgroundColor: TLabel
              Left = 8
              Top = 23
              Width = 167
              Height = 13
              Caption = 'Navigator Background Color:'
            end
            object lblHoverForeColor: TLabel
              Left = 8
              Top = 69
              Width = 202
              Height = 13
              Caption = 'Navigator Hover Foreground Color:'
            end
            object lblHoverBackColor: TLabel
              Left = 8
              Top = 46
              Width = 205
              Height = 13
              Caption = 'Navigator Hover Background Color:'
            end
            object shpNavigatorBackgroundColor: TShape
              Tag = 2
              Left = 282
              Top = 20
              Width = 31
              Height = 19
              ParentShowHint = False
              ShowHint = True
              OnMouseDown = shpNavigatorColorMouseDown
              OnMouseUp = shpNavigatorColorMouseUp
            end
            object shpHoverForeColor: TShape
              Left = 282
              Top = 66
              Width = 31
              Height = 19
              ParentShowHint = False
              ShowHint = True
              OnMouseDown = shpNavigatorColorMouseDown
              OnMouseUp = shpNavigatorColorMouseUp
            end
            object shpHoverBackColor: TShape
              Tag = 1
              Left = 282
              Top = 43
              Width = 31
              Height = 19
              ParentShowHint = False
              ShowHint = True
              OnMouseDown = shpNavigatorColorMouseDown
              OnMouseUp = shpNavigatorColorMouseUp
            end
            object lblNavigatorType: TLabel
              Left = 8
              Top = 196
              Width = 92
              Height = 13
              Caption = 'Navigator Type:'
            end
            object lblNavigatorOrientation: TLabel
              Left = 8
              Top = 224
              Width = 127
              Height = 13
              Caption = 'Navigator Orientation:'
            end
            object lblNavigatorPosition: TLabel
              Left = 8
              Top = 248
              Width = 108
              Height = 13
              Caption = 'Navigator Position:'
            end
            object gbUseLinks: TGroupBox
              Left = 8
              Top = 88
              Width = 337
              Height = 101
              TabOrder = 2
              object pcShowNavigator: TPageControl
                Left = 2
                Top = 15
                Width = 333
                Height = 85
                ActivePage = tsUseGraphicLinks
                TabOrder = 0
                object tsUseTextLinks: TTabSheet
                  Caption = 'tsUseTextLinks'
                  TabVisible = False
                
                  object lblFirst: TLabel
                    Left = 4
                    Top = 30
                    Width = 29
                    Height = 13
                    Caption = 'First:'
                  end
                  object lblLast: TLabel
                    Left = 159
                    Top = 55
                    Width = 28
                    Height = 13
                    Caption = 'Last:'
                  end
                  object lblNext: TLabel
                    Left = 4
                    Top = 55
                    Width = 31
                    Height = 13
                    Caption = 'Next:'
                  end
                  object lblPrevious: TLabel
                    Left = 159
                    Top = 30
                    Width = 54
                    Height = 13
                    Caption = 'Previous:'
                  end
                  object lblLinkCaptions: TLabel
                    Left = 4
                    Top = 1
                    Width = 78
                    Height = 13
                    Caption = 'Link Captions'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object btnSetFont: TButton
                    Left = 256
                    Top = 1
                    Width = 68
                    Height = 21
                    Caption = 'Select Font'
                    TabOrder = 0
                    OnClick = btnSetFontClick
                  end
                  object edFirst: TEdit
                    Left = 43
                    Top = 26
                    Width = 106
                    Height = 21
                    TabOrder = 1
                  end
                  object edPrevious: TEdit
                    Left = 220
                    Top = 26
                    Width = 104
                    Height = 21
                    TabOrder = 2
                  end
                  object edNext: TEdit
                    Left = 43
                    Top = 51
                    Width = 106
                    Height = 21
                    TabOrder = 3
                  end
                  object edLast: TEdit
                    Left = 220
                    Top = 51
                    Width = 104
                    Height = 21
                    TabOrder = 4
                  end
                end
                object tsUseGraphicLinks: TTabSheet
                  Tag = 1
                  Caption = 'tsUseGraphicLinks'
                  TabVisible = False
                 
                  object lblUseGraphicLinksFirst: TLabel
                    Left = 4
                    Top = 30
                    Width = 29
                    Height = 13
                    Caption = 'First:'
                  end
                  object lblUseGraphicLinksPrevious: TLabel
                    Left = 159
                    Top = 30
                    Width = 54
                    Height = 13
                    Caption = 'Previous:'
                  end
                  object lblUseGraphicLinksNext: TLabel
                    Left = 4
                    Top = 55
                    Width = 31
                    Height = 13
                    Caption = 'Next:'
                  end
                  object lblUseGraphicLinksLast: TLabel
                    Left = 159
                    Top = 55
                    Width = 28
                    Height = 13
                    Caption = 'Last:'
                  end
                  object sbtnFirst: TSpeedButton
                    Left = 130
                    Top = 26
                    Width = 23
                    Height = 21
                    Caption = '...'
                    OnClick = btnImageSourceClick
                  end
                  object sbtnPrevious: TSpeedButton
                    Left = 302
                    Top = 26
                    Width = 23
                    Height = 21
                    Caption = '...'
                    OnClick = btnImageSourceClick
                  end
                  object sbtnNext: TSpeedButton
                    Left = 130
                    Top = 51
                    Width = 23
                    Height = 21
                    Caption = '...'
                    OnClick = btnImageSourceClick
                  end
                  object sbtnLast: TSpeedButton
                    Left = 302
                    Top = 51
                    Width = 23
                    Height = 21
                    Caption = '...'
                    OnClick = btnImageSourceClick
                  end
                  object lblImageSource: TLabel
                    Left = 4
                    Top = 1
                    Width = 79
                    Height = 13
                    Caption = 'Image Source'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentFont = False
                  end
                  object edUseGraphicLinksFirst: TEdit
                    Left = 43
                    Top = 26
                    Width = 84
                    Height = 21
                    TabOrder = 0
                  end
                  object edUseGraphicLinksPrevious: TEdit
                    Left = 217
                    Top = 26
                    Width = 82
                    Height = 21
                    TabOrder = 1
                  end
                  object edUseGraphicLinksLast: TEdit
                    Left = 217
                    Top = 51
                    Width = 82
                    Height = 21
                    TabOrder = 3
                  end
                  object edUseGraphicLinksNext: TEdit
                    Left = 43
                    Top = 51
                    Width = 84
                    Height = 21
                    TabOrder = 2
                  end
                end
              end
            end
            object rbtnUseTextLinks: TRadioButton
              Left = 16
              Top = 87
              Width = 157
              Height = 17
              Caption = 'Use Text Links'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rbtnUseLinksClick
            end
            object rbtnUseGraphicLinks: TRadioButton
              Tag = 1
              Left = 173
              Top = 87
              Width = 160
              Height = 17
              Caption = 'Use Graphic Links'
              TabOrder = 1
              OnClick = rbtnUseLinksClick
            end
            object cbNavigatorType: TComboBox
              Left = 173
              Top = 193
              Width = 108
              Height = 21
              Style = csDropDownList
              TabOrder = 3
            end
            object cbNavigatorOrientation: TComboBox
              Left = 173
              Top = 218
              Width = 108
              Height = 21
              Style = csDropDownList
              TabOrder = 4
            end
            object cbNavigatorPosition: TComboBox
              Left = 173
              Top = 243
              Width = 108
              Height = 21
              Style = csDropDownList
              TabOrder = 5
            end
          end
          object chkShowNavigator: TCheckBox
            Left = 16
            Top = 19
            Width = 125
            Height = 17
            Caption = 'Show Navigator'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = chkShowNavigatorClick
          end
          object chkSingleFile: TCheckBox
            Left = 8
            Top = 0
            Width = 257
            Height = 17
            Caption = 'Single File'
            TabOrder = 0
            OnClick = chkSingleFileClick
          end
        end
        object tsTOCPageSettings: TTabSheet [5]
          Caption = 'TOC Page Settings'
          ImageIndex = 5
          TabVisible = False

          object gbTOCPageSettings: TGroupBox
            Left = 8
            Top = 0
            Width = 352
            Height = 372
            TabOrder = 0
            object lblItemFont: TLabel
              Left = 8
              Top = 71
              Width = 60
              Height = 13
              Caption = 'Item Font:'
            end
            object sbtnTOCItemFont: TSpeedButton
              Left = 288
              Top = 88
              Width = 23
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
              OnClick = sbtnSetFontClick
            end
            object lblTOCTitle: TLabel
              Left = 8
              Top = 20
              Width = 29
              Height = 13
              Caption = 'Title:'
            end
            object lblAlignment: TLabel
              Left = 8
              Top = 44
              Width = 62
              Height = 13
              Caption = 'Alignment:'
            end
            object lblTitleFont: TLabel
              Left = 8
              Top = 143
              Width = 57
              Height = 13
              Caption = 'Title Font:'
            end
            object sbtnTOCTitleFont: TSpeedButton
              Left = 288
              Top = 160
              Width = 23
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
              OnClick = sbtnSetFontClick
            end
            object pnlTOCItemFont: TPanel
              Left = 8
              Top = 88
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
              TabOrder = 0
            end
            object edTOCTitle: TEdit
              Left = 80
              Top = 16
              Width = 97
              Height = 21
              TabOrder = 1
            end
            object cbAlignment: TComboBox
              Left = 80
              Top = 40
              Width = 97
              Height = 21
              Style = csDropDownList
              TabOrder = 2
            end
            object pnlTOCTitleFont: TPanel
              Left = 8
              Top = 160
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
              TabOrder = 3
            end
          end
        end
        inherited tsEMailInfo: TTabSheet

          inherited gbEMailInfo: TGroupBox
            Width = 352

            inherited edHost: TEdit
              Width = 270

            end
            inherited edPort: TEdit
              Width = 270
              Anchors = [akLeft, akTop, akRight]

            end
            inherited edFrom: TEdit
              Width = 270

            end
            inherited edTo: TEdit
              Width = 270

            end
            inherited edCC: TEdit
              Width = 270

            end
            inherited edBCC: TEdit
              Width = 270

            end
            inherited edEmailSubject: TEdit
              Width = 270

            end
            inherited memoBody: TMemo
              Width = 334

            end
            inherited gbAuthentication: TGroupBox
              Width = 334

              inherited edPassword: TEdit
                Width = 248

              end
              inherited edUserID: TEdit
                Width = 248

              end
            end
          end
        end
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 264
  end
  object OpenDialog: TOpenDialog
    Left = 216
    Top = 16
  end
end

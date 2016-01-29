inherited gtPNGEngineDlg: TgtPNGEngineDlg
  Caption = 'gtPNGEngineDlg'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        ActivePage = tsAdvanced
        object tsAdvanced: TTabSheet [3]
          Caption = 'Advanced'
          ImageIndex = 4
          TabVisible = False
          object gbAdvancedOptions: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 372
            TabOrder = 0
            object lblColorType: TLabel
              Left = 8
              Top = 20
              Width = 68
              Height = 13
              Caption = 'Color Type:'
            end
            object cbColorType: TComboBox
              Left = 80
              Top = 16
              Width = 145
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
              OnChange = cbColorTypeChange
            end
            object gbPixelDimension: TGroupBox
              Left = 8
              Top = 48
              Width = 201
              Height = 97
              TabOrder = 2
              object lblXPixelsPerUnit: TLabel
                Left = 16
                Top = 20
                Width = 99
                Height = 13
                Caption = 'X Pixels Per Unit:'
              end
              object lblYPixelsPerUnit: TLabel
                Left = 16
                Top = 44
                Width = 98
                Height = 13
                Caption = 'Y Pixels Per Unit:'
              end
              object lblUnitSpecifier: TLabel
                Left = 16
                Top = 68
                Width = 81
                Height = 13
                Caption = 'Unit Specifier:'
              end
              object edXPixelsPerUnit: TEdit
                Left = 128
                Top = 16
                Width = 65
                Height = 21
                TabOrder = 0
              end
              object edYPixelsPerUnit: TEdit
                Left = 128
                Top = 40
                Width = 65
                Height = 21
                TabOrder = 1
              end
              object cbUnitSpecifier: TComboBox
                Left = 128
                Top = 64
                Width = 65
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 2
              end
            end
            object gbTransparency: TGroupBox
              Left = 8
              Top = 152
              Width = 201
              Height = 81
              TabOrder = 4
              object lblImageAlpha: TLabel
                Left = 8
                Top = 28
                Width = 78
                Height = 13
                Caption = 'Image Alpha:'
              end
              object lblTransparencyColor: TLabel
                Left = 8
                Top = 56
                Width = 118
                Height = 13
                Caption = 'Transparency Color:'
              end
              object shpTransparencyColor: TShape
                Left = 128
                Top = 52
                Width = 31
                Height = 21
                Hint = 'Click to Select Background Color'
                ParentShowHint = False
                ShowHint = True
                OnMouseDown = shpTransparencyColorMouseDown
                OnMouseUp = shpTransparencyColorMouseUp
              end
              object edImageAlpha: TEdit
                Left = 128
                Top = 24
                Width = 65
                Height = 21
                TabOrder = 0
              end
            end
            object chkPixelDimensions: TCheckBox
              Left = 16
              Top = 48
              Width = 121
              Height = 17
              Caption = 'Pixel Dimensions'
              TabOrder = 1
              OnClick = chkPixelDimensionsClick
            end
            object chkTransparency: TCheckBox
              Left = 16
              Top = 152
              Width = 105
              Height = 17
              Caption = 'Transparency'
              TabOrder = 3
              OnClick = chkTransparencyClick
            end
          end
        end
        inherited tsEMailInfo: TTabSheet [4]
        end
        inherited tsQualityAndScaling: TTabSheet [5]
        end
      end
    end
  end
end

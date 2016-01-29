inherited gtTIFFEngineDlg: TgtTIFFEngineDlg
  Caption = 'gtTIFFEngineDlg'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsQualityAndScaling: TTabSheet
          inherited gbQualityAndScaling: TGroupBox
            inherited lblPixelFormat: TLabel
              Enabled = False
            end
            object lblCompressionType: TLabel [1]
              Left = 8
              Top = 92
              Width = 112
              Height = 13
              Caption = 'Compression Type:'
            end
            inherited cbPixelFormat: TComboBox
              Left = 128
              Color = clInactiveBorder
              Enabled = False
            end
            inherited edScaleX: TEdit
              Left = 128
            end
            inherited edScaleY: TEdit
              Left = 128
            end
            inherited chkMonochrome: TCheckBox
              Top = 112
              Color = clInactiveBorder
              Enabled = False
              ParentColor = False
              TabOrder = 4
            end
            object chkGrayscale: TCheckBox
              Left = 8
              Top = 136
              Width = 97
              Height = 17
              Caption = 'Grayscale'
              TabOrder = 5
            end
            object chkMultiPage: TCheckBox
              Left = 8
              Top = 160
              Width = 97
              Height = 17
              Caption = 'Multi Page'
              TabOrder = 6
            end
            object cbCompressionType: TComboBox
              Left = 128
              Top = 88
              Width = 97
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 3
            end
          end
        end
      end
    end
  end
end

inherited gtJPEGEngineDlg: TgtJPEGEngineDlg
  Caption = 'gtJPEGEngineDlg'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsQualityAndScaling: TTabSheet
          inherited gbQualityAndScaling: TGroupBox
            Height = 372
            object lblQuality: TLabel [1]
              Left = 8
              Top = 99
              Width = 45
              Height = 13
              Caption = 'Quality:'
            end
            inherited lblScaleX: TLabel
              Top = 46
            end
            inherited lblScaleY: TLabel
              Top = 72
            end
            inherited edScaleX: TEdit
              Top = 42
            end
            inherited edScaleY: TEdit
              Top = 68
            end
            inherited chkMonochrome: TCheckBox
              Top = 120
              TabOrder = 4
            end
            object chkProgressiveEncoding: TCheckBox
              Left = 8
              Top = 145
              Width = 145
              Height = 17
              Caption = 'Progressive Encoding'
              Checked = True
              State = cbChecked
              TabOrder = 5
            end
            object edQuality: TEdit
              Left = 88
              Top = 95
              Width = 97
              Height = 21
              TabOrder = 3
            end
          end
        end
      end
    end
  end
end

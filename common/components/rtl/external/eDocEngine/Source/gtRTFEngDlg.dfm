inherited gtRTFEngineDlg: TgtRTFEngineDlg
  Caption = 'gtRTFEngineDlg'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            object chkGraphicDataInBinary: TCheckBox
              Left = 8
              Top = 168
              Width = 169
              Height = 17
              Caption = 'Graphic Data In Binary'
              TabOrder = 5
            end
            object rgpEncodingType: TRadioGroup
              Left = 8
              Top = 192
              Width = 297
              Height = 49
              Caption = 'Encoding Type'
              Columns = 2
              Items.Strings = (
                'Positional Accuracy'
                'Ease Of Editing')
              TabOrder = 6
            end
          end
        end
      end
    end
  end
end

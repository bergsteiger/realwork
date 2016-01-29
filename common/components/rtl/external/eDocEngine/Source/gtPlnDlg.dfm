inherited gtPlainSheetDlg: TgtPlainSheetDlg
  Left = 192
  Top = 107
  Caption = 'gtPlainSheetDlg'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            object chkActiveHyperLinks: TCheckBox
              Left = 180
              Top = 144
              Width = 129
              Height = 17
              Caption = 'Active HyperLinks'
              TabOrder = 4
            end
          end
        end
        inherited tsContent: TTabSheet
          inherited gbContentOptions: TGroupBox
            inherited gbItemsToRender: TGroupBox
              inherited chkImage: TCheckBox
                OnClick = chkImageClick
              end
            end
          end
        end
      end
    end
  end
end

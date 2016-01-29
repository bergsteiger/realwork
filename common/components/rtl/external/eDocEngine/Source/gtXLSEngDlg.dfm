inherited gtExcelEngineDlg: TgtExcelEngineDlg
  Left = 433
  Top = 222
  Caption = 'gtExcelEngineDlg'
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        ActivePage = tsFormatting
        inherited tsContent: TTabSheet
          inherited gbContentOptions: TGroupBox
            inherited gbItemsToRender: TGroupBox
              inherited chkImage: TCheckBox
                OnClick = chkImageClick
              end
            end
          end
        end
        inherited tsFormatting: TTabSheet
          inherited gbFormattingOptions: TGroupBox
            object lblPagesPerWorkSheet: TLabel [4]
              Left = 8
              Top = 121
              Width = 4
              Height = 13
            end
            inherited edRowSpacing: TEdit
              Top = 41
            end
            inherited edScaleX: TEdit
              Top = 66
            end
            inherited edScaleY: TEdit
              Top = 91
            end
            object edPagePerWorkSheet: TEdit
              Left = 144
              Top = 117
              Width = 91
              Height = 21
              TabOrder = 4
            end
            object chkPageMargins: TCheckBox
              Left = 8
              Top = 144
              Width = 97
              Height = 17
              TabOrder = 5
            end
            object chkPrintGridLines: TCheckBox
              Left = 8
              Top = 170
              Width = 113
              Height = 17
              TabOrder = 6
            end
          end
        end
      end
    end
  end
end

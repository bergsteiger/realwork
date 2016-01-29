inherited gtSpreadSheetDlg: TgtSpreadSheetDlg
  Left = 168
  Top = 92
  Caption = 'gtSpreadSheetDlg'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            Top = 3
            object lblNumberFormatDecimalPlaces: TLabel [0]
              Left = 8
              Top = 192
              Width = 186
              Height = 13
              Caption = 'Numbere Format Decimal Places'
            end
            inherited chkOpenAfterCreate: TCheckBox
              TabOrder = 4
            end
            object chkAutoFormatCells: TCheckBox
              Left = 180
              Top = 144
              Width = 121
              Height = 17
              Caption = 'AutoFormat Cells'
              TabOrder = 3
              OnClick = chkAutoFormatCellsClick
            end
            object chkApplyAlignment: TCheckBox
              Left = 8
              Top = 168
              Width = 133
              Height = 17
              Caption = 'Apply Alignment'
              TabOrder = 5
            end
            object edNumberFormatDecimalPlaces: TEdit
              Left = 8
              Top = 206
              Width = 133
              Height = 21
              TabOrder = 6
            end
          end
        end
        object tsFormatting: TTabSheet [3]
          Caption = 'Formatting'
          ImageIndex = 2
          TabVisible = False
          object gbFormattingOptions: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 372
            TabOrder = 0
            object lblColumnSpacing: TLabel
              Left = 8
              Top = 20
              Width = 98
              Height = 13
              Caption = 'Column Spacing:'
            end
            object lblRowSpacing: TLabel
              Left = 8
              Top = 44
              Width = 78
              Height = 13
              Caption = 'Row Spacing:'
            end
            object lblScaleX: TLabel
              Left = 8
              Top = 68
              Width = 48
              Height = 13
              Caption = 'Scale X:'
            end
            object lblScaleY: TLabel
              Left = 8
              Top = 92
              Width = 47
              Height = 13
              Caption = 'Scale Y:'
            end
            object edColumnSpacing: TEdit
              Left = 144
              Top = 16
              Width = 65
              Height = 21
              TabOrder = 0
              OnKeyPress = edColumnSpacingKeyPress
            end
            object edRowSpacing: TEdit
              Left = 144
              Top = 40
              Width = 65
              Height = 21
              TabOrder = 1
            end
            object edScaleX: TEdit
              Left = 144
              Top = 64
              Width = 65
              Height = 21
              TabOrder = 2
              OnKeyPress = edKeyPress
            end
            object edScaleY: TEdit
              Left = 144
              Top = 88
              Width = 65
              Height = 21
              TabOrder = 3
              OnKeyPress = edKeyPress
            end
          end
        end
        inherited tsEMailInfo: TTabSheet
          DesignSize = (
            329
            385)
          inherited gbEMailInfo: TGroupBox
            Anchors = [akLeft, akTop, akRight, akBottom]
            inherited edHost: TEdit
              Anchors = [akLeft, akTop, akRight]
            end
            inherited edPort: TEdit
              Anchors = [akLeft, akTop, akRight]
            end
          end
        end
      end
    end
  end
end

inherited gtGraphicsDlg: TgtGraphicsDlg
  Left = 192
  Top = 107
  Caption = 'gtGraphicsDlg'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDocDlg: TPanel
    inherited Panel2: TPanel
      inherited pcDocument: TPageControl
        ActivePage = tsQualityAndScaling
        inherited tsContent: TTabSheet
          inherited gbContentOptions: TGroupBox
            inherited gbItemsToRender: TGroupBox
              inherited gbImageSettings: TGroupBox
                inherited lblOutputImageFormat: TLabel
                  Enabled = False
                end
                inherited lblJPEGQuality: TLabel
                  Enabled = False
                end
                inherited cbOutputImageFormat: TComboBox
                  Color = clInactiveBorder
                  Enabled = False
                end
                inherited edJPEGQuality: TEdit
                  Color = clInactiveBorder
                  Enabled = False
                end
              end
              inherited chkImage: TCheckBox
                OnClick = chkImageClick
              end
            end
          end
        end
        object tsQualityAndScaling: TTabSheet [3]
          Caption = 'Quality && Scaling'
          ImageIndex = 3
          TabVisible = False
          object gbQualityAndScaling: TGroupBox
            Left = 8
            Top = 0
            Width = 313
            Height = 353
            TabOrder = 0
            object lblPixelFormat: TLabel
              Left = 8
              Top = 20
              Width = 76
              Height = 13
              Caption = 'Pixel Format:'
            end
            object lblScaleX: TLabel
              Left = 8
              Top = 44
              Width = 48
              Height = 13
              Caption = 'Scale X:'
            end
            object lblScaleY: TLabel
              Left = 8
              Top = 68
              Width = 47
              Height = 13
              Caption = 'Scale Y:'
            end
            object cbPixelFormat: TComboBox
              Left = 88
              Top = 16
              Width = 97
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
            end
            object edScaleX: TEdit
              Left = 88
              Top = 40
              Width = 97
              Height = 21
              TabOrder = 1
            end
            object edScaleY: TEdit
              Left = 88
              Top = 64
              Width = 97
              Height = 21
              TabOrder = 2
            end
            object chkMonochrome: TCheckBox
              Left = 8
              Top = 88
              Width = 97
              Height = 17
              Caption = 'Monochrome'
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  inherited OpenPictureDialog: TOpenPictureDialog
    Left = 164
  end
end

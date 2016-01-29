inherited DictItemEditDlg: TDictItemEditDlg
  Left = 512
  Top = 165
  VertScrollBar.Range = 0
  AutoScroll = False
  ClientHeight = 397
  ClientWidth = 508
  Constraints.MinHeight = 225
  Constraints.MinWidth = 300
  Font.Color = clBlack
  KeyPreview = True
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 352
    Width = 508
    DesignSize = (
      508
      45)
    inherited OK: TBitBtn
      Left = 234
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 325
    end
    inherited Help: TBitBtn
      Left = 415
    end
  end
  inherited Panel1: TPanel
    Width = 508
    Height = 352
    inline Frame1: TDictItemEditFrame
      Left = 1
      Top = 1
      Width = 506
      Height = 350
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      inherited pnlName: TPanel
        Width = 506
        Height = 233
        OnResize = nil
        inherited lblNameRus: TLabel
          Width = 430
        end
        inherited sbSpellChecker: TSpeedButton
          Left = 470
          Top = 5
        end
        inherited lblNameEng: TLabel
          Width = 462
        end
        inherited mNameRus: TevMemo
          Width = 488
          TextSource.OnBruttoCharCountChange = nil
        end
        inherited mNameEng: TevMemo
          Width = 489
          TextSource.OnBruttoCharCountChange = nil
        end
      end
      inherited AddedDataPanel: TPanel
        Top = 233
        Width = 506
        inherited pnlExtCode: TPanel
          Width = 506
          inherited edtCode: TEdit
            Width = 491
          end
        end
        inherited pnlExtPrivate: TPanel
          Width = 506
        end
      end
    end
  end
end

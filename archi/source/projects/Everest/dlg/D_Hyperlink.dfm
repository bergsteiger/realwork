inherited dHyperLink: TdHyperLink
  Left = 394
  Caption = #1053#1086#1074#1072#1103' '#1089#1089#1099#1083#1082#1072
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited FormPanel: TPanel
    inherited pnButtons: TPanel
      inherited btOk: TBitBtn
        OnClick = OKBtnClick
      end
    end
    inherited pnMain: TPanel
      inherited Panel5: TPanel
        inline frSubCombo: TfrSubCombo
          Left = 0
          Top = 0
          Width = 212
          Height = 191
          TabOrder = 2
          Visible = False
          inherited otlSub: TvtOutliner
            RowHeight = 19
          end
        end
        object edtURL: TevEdit
          Left = 4
          Top = 4
          Width = 337
          Height = 25
          LMargin = 1
          RMargin = 8
          TabOrder = 0
          TabStop = True
          BorderStyle = bsSingle
        end
        object cbSub: TCheckBox
          Left = 4
          Top = 30
          Width = 340
          Height = 17
          Caption = #1057#1089#1099#1083#1082#1072' '#1085#1072' '#1084#1077#1090#1082#1091
          TabOrder = 1
          OnClick = cbSubClick
        end
      end
      inherited Panel4: TPanel
        object lbURL: TLabel
          Left = 28
          Top = 7
          Width = 55
          Height = 19
          Alignment = taRightJustify
          AutoSize = False
          Caption = #1055#1091#1090#1100
        end
      end
    end
  end
end

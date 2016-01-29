inherited MDIListDlg: TMDIListDlg
  Left = 263
  Top = 115
  Width = 398
  Height = 295
  Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1086#1082#1086#1085
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited FormPanel: TPanel
    Width = 390
    Height = 261
    inherited pnButtons: TPanel
      Top = 218
      Width = 388
      inherited btOk: TBitBtn
        OnClick = btOKClick
      end
    end
    inherited pnMain: TPanel
      Width = 388
      Height = 217
      object lstMDIChildren: TvtStringLister
        Left = 1
        Top = 1
        Width = 386
        Height = 215
        Sorted = False
        AlienSource = False
        Images = dmStandardRes.ilCommon
        AutoRowHeight = False
        IntegralHeight = False
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 19
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        MultiStrokeItem = True
        ReadOnly = False
        OnGetItemImageIndex = lstMDIChildrenGetItemImageIndex
        Align = alClient
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        ParentColor = False
        TabOrder = 0
        TabStop = True
        OnActionElement = lstMDIChildrenActionElement
      end
    end
  end
end

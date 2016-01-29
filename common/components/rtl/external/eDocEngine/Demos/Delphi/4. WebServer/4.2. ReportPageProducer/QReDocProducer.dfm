object frmQuickReport: TfrmQuickReport
  Left = 169
  Top = 155
  Width = 823
  Height = 368
  VertScrollBar.Position = 16
  Caption = 'QuickReport Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = 8
    Top = -8
    Width = 816
    Height = 1056
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = Table1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = Letter
    Page.Values = (
      127.000000000000000000
      2794.000000000000000000
      127.000000000000000000
      2159.000000000000000000
      127.000000000000000000
      127.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrintIfEmpty = True
    ShowProgress = False
    SnapToGrid = True
    Units = Inches
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    object TitleBand1: TQRBand
      Left = 48
      Top = 48
      Width = 720
      Height = 89
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        235.479166666666700000
        1905.000000000000000000)
      BandType = rbTitle
      object QRLabel1: TQRLabel
        Left = 61
        Top = 15
        Width = 597
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          79.375000000000000000
          161.395833333333300000
          39.687500000000000000
          1579.562500000000000000)
        Alignment = taCenter
        AlignToBand = True
        AutoSize = True
        AutoStretch = True
        Caption = 'Gnostice eDocEngine WebServer Application'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clTeal
        Font.Height = -24
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 18
      end
      object QRLabel2: TQRLabel
        Left = 122
        Top = 47
        Width = 475
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          79.375000000000000000
          322.791666666666700000
          124.354166666666700000
          1256.770833333333000000)
        Alignment = taCenter
        AlignToBand = True
        AutoSize = True
        AutoStretch = True
        Caption = 'Page Producer Interfaced With QuickReport'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clTeal
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 14
      end
    end
    object DetailBand1: TQRBand
      Left = 48
      Top = 137
      Width = 720
      Height = 193
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        510.645833333333300000
        1905.000000000000000000)
      BandType = rbDetail
      object QRDBText2: TQRDBText
        Left = 235
        Top = 16
        Width = 94
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          621.770833333333300000
          42.333333333333330000
          248.708333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clSkyBlue
        DataSet = Table1
        DataField = 'Common_Name'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBRichText1: TQRDBRichText
        Left = 235
        Top = 40
        Width = 470
        Height = 137
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          362.479166666666700000
          621.770833333333300000
          105.833333333333300000
          1243.541666666667000000)
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        DataField = 'Notes'
        DataSet = Table1
      end
      object QRDBImage1: TQRDBImage
        Left = 8
        Top = 16
        Width = 217
        Height = 161
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          425.979166666666700000
          21.166666666666670000
          42.333333333333330000
          574.145833333333300000)
        DataField = 'Graphic'
        DataSet = Table1
        Stretch = True
      end
    end
  end
  object Table1: TTable
    Active = True
    AutoRefresh = True
    DatabaseName = 'DBDEMOS'
    TableName = 'biolife.db'
    Left = 152
    Top = 8
  end
end

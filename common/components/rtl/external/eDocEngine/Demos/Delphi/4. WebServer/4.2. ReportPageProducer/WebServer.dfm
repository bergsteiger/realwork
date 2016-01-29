object wmdServer: TwmdServer
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'waiProducer'
      PathInfo = '/gtDocProducer1'
      Producer = gtDocProducer1
    end>
  Left = 380
  Top = 117
  Height = 189
  Width = 214
  object gtPDFEngine1: TgtPDFEngine
    FileExtension = 'pdf'
    FileDescription = 'Adobe PDF Files'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.347500000000000000
    Page.Height = 11.805700000000000000
    Preferences.OpenAfterCreate = False
    Preferences.OutputToUserStream = True
    Preferences.ShowSetupDialog = False
    InputXRes = 96
    InputYRes = 96
    FontEncoding = feWinAnsiEncoding
    Left = 24
    Top = 8
  end
  object gtQRExportInterface1: TgtQRExportInterface
    Engine = gtPDFEngine1
    Left = 80
    Top = 56
  end
  object gtDocProducer1: TgtDocProducer
    ExportInterface = gtQRExportInterface1
    OnCreateContent = gtDocProducer1CreateContent
    Left = 144
    Top = 104
  end
end

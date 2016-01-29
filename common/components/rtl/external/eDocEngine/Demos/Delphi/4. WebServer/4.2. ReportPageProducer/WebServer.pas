unit WebServer;

interface

//Remove the dot (.) below to configure demo for eDocEngine Pro
{.$DEFINE gtPro}

uses
  SysUtils, Classes, HTTPApp, gtDocProducer, gtXportIntf, gtQRXportIntf,
  gtClasses3, gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtPDFEng,
  QReDocProducer
  {$IFDEF gtPro}
  , gtExPDFEng
  {$ENDIF}
  ;

type
  TwmdServer = class(TWebModule)
    gtPDFEngine1: TgtPDFEngine;
    gtQRExportInterface1: TgtQRExportInterface;
    gtDocProducer1: TgtDocProducer;
    procedure gtDocProducer1CreateContent(Sender: TgtDocProducer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wmdServer: TwmdServer;

implementation

{$R *.dfm}

procedure TwmdServer.gtDocProducer1CreateContent(Sender: TgtDocProducer);
begin
  with TfrmQuickReport.Create(nil) do
  begin
    TgtQRExportInterface(Sender.ExportInterface).RenderDocument(
    	QuickRep1, False);
  end;
end;

end.

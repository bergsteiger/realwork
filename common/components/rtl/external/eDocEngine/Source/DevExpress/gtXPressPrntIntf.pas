{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                              }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

unit gtXPressPrntIntf;

interface
uses
  Classes, Windows, gtCstDocEng, gtXportIntf, dxPSCore;

type

  TgtXPressPrntInterface = class(TgtExportInterface)
  public
    procedure RenderDocument(AXPressPrntr: TdxComponentPrinter;
		AXPressReportLink: TBasedxReportLink = nil);
  published
    property Engine;
  end;

implementation

{ TgtXPressPrntInterface }

procedure TgtXPressPrntInterface.RenderDocument(AXPressPrntr: TdxComponentPrinter;
  AXPressReportLink: TBasedxReportLink);
var
  LI : Integer;
  LRepLink: TBasedxReportLink;
begin
  with IgtDocumentEngine(Engine), AXPressPrntr do
  begin
    if (AXPressReportLink = nil) then
		LRepLink := CurrentLink
	else
		LRepLink := AXPressReportLink;
	LRepLink.Active := True;
	RebuildReport(LRepLink);
    Page.PaperSize := Custom;
    Engine.MeasurementUnit := mupixels;
    Page.Width := LRepLink.RealPrinterPage.PageSizePixels.X;
    Page.Height := LRepLink.RealPrinterPage.PageSizePixels.Y;

    StartDocument;
    if Engine.EngineStatus = esCancelled then Exit;
    LI := 0;
    while LI <= GetPageCount - 1 do
    begin
      if LI <> 0 then
        NewPage;
      with LRepLink.RealPrinterPage do
      PaintPage(Engine.Canvas, LI, Rect(0, 0, PageSizePixels.X,
        PageSizePixels.Y), PaintRectPixels);
      Inc(LI);
    end;
    EndDocument;
 end;
end;

end.

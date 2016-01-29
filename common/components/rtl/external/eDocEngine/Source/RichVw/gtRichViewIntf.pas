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

unit gtRichViewIntf;

interface

uses
  Classes, Windows, Forms, gtCstDocEng, gtXportIntf, RichView, RVReport,
  PtblRV;
type

  TgtRichViewInterface = class(TgtExportInterface)
  public
    procedure RenderDocument(ARVPrint: TRVPrint; IsFormatted: Boolean); overload;
    procedure RenderDocument(ARVHelper: TRVReportHelper); overload;
  published
    property Engine;
  end;

implementation
uses
  RVScroll;


{ TgtRichViewInterface }

procedure TgtRichViewInterface.RenderDocument(ARVPrint: TRVPrint;
  IsFormatted: Boolean);
var
  LI: Integer;
begin
  with ARVPrint, IgtDocumentEngine(Engine) do
  begin
    if not IsFormatted then
      FormatPages(rvdoALL);
    Engine.MeasurementUnit := muPixels;
    Page.Width := ARVPrint.Preview100PercentWidth;
    Page.Height := ARVPrint.Preview100PercentHeight;
    for LI := 1 to ARVPrint.PagesCount do
    begin
      if LI = 1 then
      begin
        StartDocument;
        if Engine.EngineStatus <> esStarted then Exit;
      end
      else
        NewPage;
      ARVPrint.DrawPreview(LI, Engine.Canvas, Rect(0, 0, Round(Page.Width),
        Round(Page.Height)));
    end;
    EndDocument;
  end;
end;

procedure TgtRichViewInterface.RenderDocument(ARVHelper: TRVReportHelper);
var
  LI, LWidth, LHeight: Integer;
  LUnit: TgtUnitType;
begin
  with ARVHelper, IgtDocumentEngine(Engine) do
  begin
    LUnit := Engine.MeasurementUnit;
    Engine.MeasurementUnit := muPixels;
    LWidth := Round(Page.Width - Page.LeftMargin - Page.RightMargin);
    LHeight := Round(Page.Height - Page.TopMargin - Page.BottomMargin -
      Page.HeaderHeight - Page.FooterHeight);
    StartDocument;
    if Engine.EngineStatus <> esStarted then Exit;
    Init(Engine.Canvas, Round(LWidth));
    FormatNextPage(Round(LHeight));
    LI := 0;
    while LI < PagesCount do
    begin
      if LI <> 0 then
        NewPage;
      DrawPage(LI+1, Engine.Canvas, True, LHeight);
      FormatNextPage(Round(LHeight));
      Inc(LI);
    end;
    EndDocument;
    Engine.MeasurementUnit := LUnit;
  end;
end;

end.

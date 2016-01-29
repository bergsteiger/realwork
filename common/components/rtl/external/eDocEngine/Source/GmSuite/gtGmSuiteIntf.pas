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

unit gtGmSuiteIntf;

interface
uses
  Classes, Windows, gtCstDocEng, gtXportIntf, GmPreview, GmTypes;

type

  TgtGmSuiteInterface = class(TgtExportInterface)
  public
    procedure RenderDocument(GmPreview1: TGmPreview);
  published
    property Engine;
  end;

implementation
uses
  GmPageList;

{ TgtGmSuiteInterface }

procedure TgtGmSuiteInterface.RenderDocument(GmPreview1: TGmPreview);
var
  LI : Integer;
  LPage : TGmPage;
begin
  with IgtDocumentEngine(Engine) do
  begin
    Page.PaperSize := gtCstDocEng.Custom;
    Engine.MeasurementUnit := muPixels;
    for LI := 1 to GmPreview1.NumPages do
    begin
      LPage := GmPreview1.Pages[LI];
      Page.Width :=  LPage.PageSize[gmPixels].Width;
      Page.Height :=  LPage.PageSize[gmPixels].Height;
      if LI = 1 then
        StartDocument
      else
        NewPage;
       LPage.DrawToCanvas(Engine.Canvas, 96, 96, False);
    end;
    EndDocument;
  end;
end;

end.

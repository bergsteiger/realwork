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

{$I ..\gtExpIntf.inc}
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- THtmlViewer Version Support ---
// If Enabled: Supports THtmlViewer v9.22 and above.
// If Disabled: Supports THtmlViewer versions below v9.22
//{$DEFINE THtmlViewer922Up}

unit gtHtmlViewIntf;

interface
uses
  Classes, Windows, Forms, gtCstDocEng, gtXportIntf, Htmlview,
  MetaFilePrinter, Htmlsubs;

type

  TgtHtmlViewInterface = class(TgtExportInterface)
  private
    FAutoSizePage: Boolean;
    procedure SetAutoSizePage(Value: Boolean);
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AHTMLFile: string); overload;
    procedure RenderDocument(AHTMLView: THTMLViewer); overload;
  published
    property Engine;
    property AutoSizePage: Boolean read FAutoSizePage write SetAutoSizePage;
  end;


implementation
uses
  Printers, Graphics, SysUtils;

type
  EExcessiveSizeError = Class(Exception);

const
  MaxHScroll = 6000;  {max horizontal display in pixels}

{ TgtHtmlViewInterface }

constructor TgtHtmlViewInterface.Create(AOwner: TComponent);
begin
  inherited;
  FAutoSizePage := True;
end;

destructor TgtHtmlViewInterface.Destroy;
begin

  inherited;
end;

procedure TgtHtmlViewInterface.RenderDocument(AHTMLView: THTMLViewer);
var
  LFormatWidth, LI: Integer;
  LSize: TSize;
  LMetafileList: TList;
begin
  with IgtDocumentEngine(Engine) do
  begin
    Page.PaperSize := Custom;
    Engine.MeasurementUnit := muPixels;

    LFormatWidth := AHTMLView.FullDisplaySize(Round(Page.Width -
      (Page.LeftMargin + Page.RightMargin))).cx;
    LSize := AHTMLView.FullDisplaySize(LFormatWidth);
    AHTMLView.DefBackground := clWhite;
(*
    LMetafileList := TgtHackHtmlView(AHTMLView).MakeMetaFiles(0,
     Round(LFormatWidth), Round(LSize.cx),
     Round(Page.Height - (Page.TopMargin + Page.BottomMargin
     + Page.HeaderHeight + Page.FooterHeight)));
*)


    LMetafileList := AHTMLView.MakePagedMetaFiles(LFormatWidth,
      Round(Page.Height - (Page.TopMargin + Page.BottomMargin +
       Page.HeaderHeight + Page.FooterHeight)));

    if(LMetafileList <> nil) then
    begin
      for LI := 0 to LMetafileList.Count - 1 do
      begin
        //if the HTML file is not resizable then change pdf pagesize to HTML page size
        if (AutoSizePage and (LFormatWidth > Round(Page.Width -
          Page.LeftMargin - Page.RightMargin))) then
        begin
          Page.Width := TMetafile(LMetafileList.Items[LI]).Width +
            Page.LeftMargin + Page.RightMargin;
        end;
        if LI = 0  then
          StartDocument
        else
          NewPage;
        IgtDocumentEngine(Engine).PlayMetaFile(TMetafile(LMetafileList.Items[LI]));
      end;
      EndDocument;
      for LI := 0 to LMetafileList.Count - 1 do
        TMetafile(LMetafileList.Items[LI]).Free;
      LMetafileList.Free;
    end
  end;
end;

procedure TgtHtmlViewInterface.RenderDocument(AHTMLFile: string);
var
  LHTMLView: THTMLViewer;
begin
  LHTMLView := THTMLViewer.Create(Self);
  LHTMLView.Visible := False;
  LHTMLView.Parent := Application.MainForm;
  LHTMLView.LoadFromFile(AHTMLFile);
  RenderDocument(LHTMLView);
  LHTMLView.Free;
end;

procedure TgtHtmlViewInterface.SetAutoSizePage(Value: Boolean);
begin
  FAutoSizePage := Value;
end;


end.

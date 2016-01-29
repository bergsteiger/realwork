{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

unit gtScaleRichViewIntf;

interface

uses
  Classes, Windows, Forms, gtCstDocEng, gtXportIntf, SclRView, Graphics,
  Printers;

type
  TgtSRVRenderingOption = (srvroPageNoVisible, srvroClipMargins, srvroPrinting);
  TgtSRVRenderingOptions = set of TgtSRVRenderingOption;

  TgtScaleRichViewInterface = class(TgtExportInterface)
  private
    FRenderingOptions: TgtSRVRenderingOptions;
    function MakePageMetafile(ASRichViewEdit: TSRichViewEdit;
      PageNo, Width, Height: Integer): TMetafile;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RenderDocument(ASRichViewEdit: TSRichViewEdit); overload;
  published
    property Engine;
    property RenderingOptions: TgtSRVRenderingOptions
      read FRenderingOptions write FRenderingOptions
      default [srvroPageNoVisible, srvroClipMargins,srvroPrinting];
  end;

implementation

{ TgtScaleRichViewInterface }

constructor TgtScaleRichViewInterface.Create(AOwner: TComponent);
begin
  inherited;
  FRenderingOptions := [srvroPageNoVisible, srvroClipMargins,srvroPrinting];
end;

function TgtScaleRichViewInterface.MakePageMetafile(ASRichViewEdit
  : TSRichViewEdit; PageNo, Width, Height: Integer): TMetafile;
var
  LPageNoVisible, LClipMargins, LPrinting: Boolean;

begin
  Result := TMetafile.Create;
  Result.Width := Width;
  Result.Height := Height;
  ASRichViewEdit.CanUpdate := False;
  ASRichViewEdit.UseDrawHyperlinksEvent := True;

  LPageNoVisible := srvroPageNoVisible in FRenderingOptions;
  LClipMargins := srvroClipMargins in FRenderingOptions;
  LPrinting := srvroPrinting in FRenderingOptions;

  // DrawMetafile method parameters
  // PageNo:Staring Page Number
  // Result: Metafile to Draw the RichView page on to
  // PageNoVisible :Specifies whether to print page numbers
  // ClipMargins :Specifies whether all drawing outside the document area
  // (i.e. drawing on margins) will be cropped.
  // Printing :Specifies whether this is a drawing for printing
  // (a special method for drawing pictures is used in this case).
  ASRichViewEdit.DrawMetafile(PageNo, Result, LPageNoVisible, LClipMargins,
    LPrinting);

  ASRichViewEdit.CanUpdate := True;
end;

procedure TgtScaleRichViewInterface.RenderDocument(ASRichViewEdit
  : TSRichViewEdit);
var
  LI, LWidth, LHeight: Integer;
  LUnit: TgtUnitType;
  LMetafile: TMetafile;
begin
  with ASRichViewEdit, IgtDocumentEngine(Engine) do
  begin
    LUnit := Engine.MeasurementUnit;
    Engine.MeasurementUnit := muPixels;
    LWidth := ASRichViewEdit.PageWidth100Pix;
    LHeight := ASRichViewEdit.PageHeight100Pix;
    with IgtDocumentEngine(Engine) do
    begin
      Page.PaperSize := Custom;
      Page.Orientation := ASRichViewEdit.PageProperty.Orientation;
      Page.Width := ASRichViewEdit.PageWidth100Pix;
      Page.Height := ASRichViewEdit.PageHeight100Pix;
      Page.LeftMargin := ASRichViewEdit.PageProperty.LeftMargin;
      Page.TopMargin := ASRichViewEdit.PageProperty.TopMargin;
      Page.RightMargin := ASRichViewEdit.PageProperty.RightMargin;
      Page.BottomMargin := ASRichViewEdit.PageProperty.BottomMargin;
    end;
    StartDocument;
    if Engine.EngineStatus <> esStarted then
      Exit;

    for LI := 1 to ASRichViewEdit.PageCount do
    begin
      if LI > 1 then
        NewPage;

      LMetafile := MakePageMetafile(ASRichViewEdit, LI, LWidth, LHeight);
      PlayMetafile(0, 0, LMetafile);
      LMetafile.Free;
    end;
    EndDocument;
    Engine.MeasurementUnit := LUnit;
  end;
end;


end.

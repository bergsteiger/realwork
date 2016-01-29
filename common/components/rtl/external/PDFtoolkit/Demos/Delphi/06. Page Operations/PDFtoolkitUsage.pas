unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
{********* Merge, Split & Reorganize *********}
procedure AppendPages(APDFDoc:TgtPDFDocument; AFilename, APageRange: string);
procedure DeletePages(APDFDoc:TgtPDFDocument; APageRange: string);
procedure InsertPages(APDFDoc:TgtPDFDocument; APageRange, AFilename: string;
  AAfterPage:Integer);
procedure Extractpages(APDFDoc:TgtPDFDocument; AExtractTo,APageRange: string);
procedure Mergedoc(APDFDoc:TgtPDFDocument; AFileList: TStringList; ASaveToFile: string);
procedure StitchPages(APDFDoc:TgtPDFDocument;AStitchPage,AToPage: Integer);
procedure StitchPagesSideBySide(APDFDoc:TgtPDFDocument;AStitchPage,AToPage: Integer);

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure AppendPages(APDFDoc:TgtPDFDocument;AFilename, APageRange: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.AppendPagesFrom(AFilename,APageRange);
  end;
end;

procedure DeletePages(APDFDoc:TgtPDFDocument; APageRange: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.DeletePages(APageRange);
  end;
end;

procedure InsertPages(APDFDoc:TgtPDFDocument; APageRange, AFilename: string;
  AAfterPage:Integer);
var
  LTempDoc: TgtPDFDocument;
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.InsertPagesFrom(AFilename,APageRange,AAfterPage);
  end;
end;

procedure Extractpages(APDFDoc:TgtPDFDocument; AExtractTo,APageRange: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.ExtractPagesTo(AExtractTo,APageRange);
  end;
end;

procedure Mergedoc(APDFDoc:TgtPDFDocument; AFileList: TStringList; ASaveToFile: string);
begin
  APDFDoc.MergeDocs(AFileList);
  APDFDoc.ShowSetupDialog := False;
  APDFDoc.OpenAfterSave := True;	
  APDFDoc.SaveToFile(ASaveToFile);
end;

procedure StitchPages(APDFDoc:TgtPDFDocument;AStitchPage,AToPage: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.Stitch(AToPage,AStitchPage);
  end;
end;

procedure StitchPagesSideBySide(APDFDoc:TgtPDFDocument;AStitchPage,AToPage: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.StitchSideBySide(AToPage,AStitchPage);
  end;
end;



end.





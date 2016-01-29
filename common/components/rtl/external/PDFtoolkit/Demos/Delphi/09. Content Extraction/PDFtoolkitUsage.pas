unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt, gtWideStrings;

{********* Content extraction*****}
function ExtractTextFormatted(APDFDoc:TgtPDFDocument; APageno: Integer): TgtWideStringList;
function ExtractImages(APDFDoc:TgtPDFDocument; APageno: Integer):TgtPDFPageElementList;


//const

implementation

function ExtractTextFormatted(APDFDoc:TgtPDFDocument; APageno: Integer): TgtWideStringList;
begin
  Result := nil;
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.ExtractTextFromPage(APageno, True);
  end;
end;

function ExtractImages(APDFDoc:TgtPDFDocument; APageno: Integer):TgtPDFPageElementList;
begin
  Result := nil;
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetPageElements(APageno,[etImage],muPixels);
  end;
end;

end.




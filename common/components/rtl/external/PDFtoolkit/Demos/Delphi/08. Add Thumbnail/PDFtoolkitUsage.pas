unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;

procedure AddThumbnail(APDFDoc:TgtPDFDocument; AImage:TGraphic; APageNo: Integer);

implementation

procedure AddThumbnail(APDFDoc:TgtPDFDocument; AImage:TGraphic; APageNo: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.AddThumbnail(APageNo,AImage);
  end;
end;


end.




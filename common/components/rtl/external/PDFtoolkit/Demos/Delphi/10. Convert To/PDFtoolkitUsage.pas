unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtExProPDFDoc, gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;

type
  FHackExPro = class(TgtExProPDFDocument);
    
procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
procedure ConvertPDFToImage(APDFDoc:TgtPDFDocument; AHandle: HDC;Awidth, AHeight: Cardinal; APageno:Integer);



//const

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure ConvertPDFToImage(APDFDoc:TgtPDFDocument; AHandle: HDC;Awidth, AHeight: Cardinal; APageno:Integer);
//var
//  LStream: TMemoryStream;
begin
  if APDFDoc.IsLoaded then
  begin
//    LStream := TMemoryStream.Create;
    FHackExPro(APDFDoc).RenderToDC(AHandle, Awidth, AHeight, APageNo, 72, 72, 0,
      True, False);
//    LStream.Free;
  end;
end;

end.





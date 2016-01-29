unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtExProPDFDoc, gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;

procedure InsertBlankPDFPage(APDFDoc:TgtPDFDocument; APosition: Integer; AWidth, Aheight: Double);
procedure AddCustomPDFInfo(APDFDoc:TgtPDFDocument; AName, AValue: string; ASchema: Integer);
procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
procedure MaskRectPDF(APDFDoc:TgtPDFDocument; LRect: TRect; LColor: TColor; APageNo: Integer);
procedure AddHTMLText(APDFDoc: TgtPDFDocument; Ax, Ay: Extended; AText, APageno: string);
procedure AddFileAttachment(APDFDoc: TgtPDFDocument;AFilename, AAttachname :string; ALeft, ATop,
  ARight, ABottom: Extended;AAttachIcon, APageno: Integer);

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure InsertBlankPDFPage(APDFDoc:TgtPDFDocument; APosition: Integer; AWidth, Aheight: Double);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.InsertBlankPageAt(APosition, AWidth, Aheight);
  end;
end;

procedure AddCustomPDFInfo(APDFDoc:TgtPDFDocument; AName, AValue: string; ASchema: Integer);
var
  LCstInfo: TgtCustomPDFInfo;
begin
  if APDFDoc.IsLoaded then
  begin
    LCstInfo := TgtCustomPDFInfo.Create;
    LCstInfo.Name := AName;
    LCstInfo.Value := AValue;
    LCstInfo.Schema := TgtCustomInfoSchema(ASchema);
    APDFDoc.AddCustomPDFInfo(LCstInfo);
  end;
end;

procedure MaskRectPDF(APDFDoc:TgtPDFDocument; LRect: TRect; LColor: TColor; APageNo: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
   APDFDoc.MaskRect(APageNo, LRect, LColor);
  end;
end;

procedure AddHTMLText(APDFDoc: TgtPDFDocument; Ax, Ay: Extended; AText, APageno: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.TextOut(AText,APageno,Ax,Ay);
  end;
end;

procedure AddFileAttachment(APDFDoc: TgtPDFDocument;AFilename, AAttachname :string; ALeft, ATop,
  ARight, ABottom: Extended;AAttachIcon, APageno: Integer);

  function CreateFileAttchment: TgtPDFFileAttachment;
  begin
    Result := TgtPDFFileAttachment.Create;
    with Result do
    begin
      FileName:= AFilename;
      AttachmentName:= AAttachname;
      SetBounds(ALeft, ATop, ARight, ABottom);
      FileAttachmentIcon:= TgtFileAttachmentIcon(AAttachIcon);
    end;
  end;

var
  LTempFileAttachment: TgtPDFFileAttachment;
  begin
  LTempFileAttachment := CreateFileAttchment;
  try
    APDFDoc.InsertFileAttachment(LTempFileAttachment, APageno);
  finally
    LTempFileAttachment.Free;
  end;
end;

end.





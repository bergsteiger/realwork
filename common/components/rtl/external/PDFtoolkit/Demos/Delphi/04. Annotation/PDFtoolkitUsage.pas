unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;


procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
procedure InsertLinkAnnotation(APDFDoc: TgtPDFDocument; LAction: TgtPDFURIAction; ALeft,
  ATop, ARight, ABottom: Extended; ATitle, AName: string; ABCKColor: TColor; APageno: Integer);
procedure InsertLineAnnotation(APDFDoc: TgtPDFDocument; AX1, AY1, AX2, AY2: Extended;
  ATitle, AName, AContents: string; ABorderWidth: Integer;ABCKColor: TColor; APageno: Integer);
procedure InsertCircleAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  AContents: string; ABCKColor, AInteriorColor: TColor; AIsCloudy: Boolean;  AIntensity, APageno: Integer);
procedure InsertCaretAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABorderWidth: Integer; ABCKColor: TColor; ACaretSym,APageno: Integer);
procedure InsertSquareAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  AContents: string; ABCKColor, AInteriorColor: TColor; AIsCloudy: Boolean;  AIntensity, APageno: Integer);
procedure InsertPolygonAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AVerstices: string; ABCKColor: TColor; AIsCloudy: Boolean;
  AIntensity, ABorderwidth,APageno: Integer);
procedure InsertPolylineAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AVerstices: string; ABCKColor: TColor; ABorderwidth,APageno: Integer);
procedure InsertInkAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AInkList: string; ABCKColor: TColor; ABorderwidth,APageno: Integer);
procedure InsertStampAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; ABorderStyle,ABorderwidth,APageno: Integer);
procedure InsertMarkupAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; ABorderwidth,APageno: Integer;
  Ax1,Ay1,Ax2,Ay2,Ax3,Ay3,Ax4,Ay4: Extended);
procedure InsertTextAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; AOpen: Boolean;AHCornerRad,AVCornerRad,ABorderwidth,APageno: Integer);
procedure InsertFreeTextAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; AfreeTextAlign,ABorderwidth,APageno: Integer);



implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure InsertLinkAnnotation(APDFDoc: TgtPDFDocument; LAction: TgtPDFURIAction; ALeft,
  ATop, ARight, ABottom: Extended; ATitle, AName: string; ABCKColor: TColor; APageno: Integer);
var
  LLinkAnnot: TgtPDFLinkAnnotation;

  function CreateLinkAnnotation: TgtPDFLinkAnnotation;
  begin
    Result := TgtPDFLinkAnnotation.Create;
    with Result do
    begin
      Action := LAction;
      SetBounds(ALeft, ATop, ARight, ABottom);
      AnnotTitle := ATitle;
      Name := AName;
      BackgroundColor := ABCKColor;
    end;
  end;
begin
  LLinkAnnot := CreateLinkAnnotation;
  try
    APDFDoc.InsertAnnotation(LLinkAnnot,APageno);
  finally
    LLinkAnnot.Free;
  end;
end;

procedure InsertLineAnnotation(APDFDoc: TgtPDFDocument; AX1, AY1, AX2, AY2: Extended;
  ATitle, AName, AContents: string; ABorderWidth: Integer;ABCKColor: TColor; APageno: Integer);
var
  LLineAnnot: TgtPDFLineAnnotation;

  function CreateLineAnnotation: TgtPDFLineAnnotation;
  begin
    Result := TgtPDFLineAnnotation.Create;
    with Result do
    begin
      gtLine(AX1, AY1, AX2, AY2);
      AnnotTitle := ATitle;
      Name := AName;
      Contents := AContents;
      BorderWidth := ABorderWidth;
      BackgroundColor := ABCKColor;
    end;
  end;
begin
  try
    LLineAnnot := CreateLineAnnotation;
    APDFDoc.InsertAnnotation(LLineAnnot,APageno);
  finally
    LLineAnnot.Free;
  end;
end;

procedure InsertCircleAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  AContents: string; ABCKColor, AInteriorColor: TColor; AIsCloudy: Boolean;  AIntensity, APageno: Integer);
var
  LCircleAnnot: TgtPDFCircleAnnotation;

  function CreateCircleAnnotation: TgtPDFCircleAnnotation;
  begin
    Result := TgtPDFCircleAnnotation.Create;
    with Result do
    begin
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      Intensity := AIntensity;
      IsCloudy := AIsCloudy;
      CircleInteriorColor := AInteriorColor;
    end;
  end;
begin
  try
    LCircleAnnot := CreateCircleAnnotation;
    APDFDoc.InsertAnnotation(LCircleAnnot,APageno);
  finally
    LCircleAnnot.Free;
  end;
end;

procedure InsertCaretAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABorderWidth: Integer; ABCKColor: TColor; ACaretSym,APageno: Integer);
var
  LCaretAnnot: TgtPDFCaretAnnotation;

  function CreateCaretAnnotation: TgtPDFCaretAnnotation;
  begin
    Result := TgtPDFCaretAnnotation.Create;
    with Result do
    begin
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      AnnotTitle := ATitle;
      Name := AName;
      BorderWidth := ABorderWidth;
      CaretSymbol := TgtCaretSymbol(ACaretSym);
    end;
  end;
begin
  try
    LCaretAnnot := CreateCaretAnnotation;
    APDFDoc.InsertAnnotation(LCaretAnnot,APageno);
  finally
    LCaretAnnot.Free;
  end;
end;

procedure InsertSquareAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  AContents: string; ABCKColor, AInteriorColor: TColor; AIsCloudy: Boolean; AIntensity, APageno: Integer);
Var
  LSquareAnnot: TgtPDFSquareAnnotation;

  function CreateSquareAnnotation: TgtPDFSquareAnnotation;
  begin
    Result := TgtPDFSquareAnnotation.Create;
    with Result do
    begin
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      Intensity := AIntensity;
      IsCloudy := AIsCloudy;
      SquareInteriorColor := AInteriorColor;
    end;
  end;
begin
  try
    LSquareAnnot := CreateSquareAnnotation;
    APDFDoc.InsertAnnotation(LSquareAnnot,APageno);
  finally
    LSquareAnnot.Free;
  end;
end;

procedure InsertPolygonAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AVerstices: string; ABCKColor: TColor; AIsCloudy: Boolean;
  AIntensity, ABorderwidth,APageno: Integer);
Var
  LPolygonAnnot: TgtPDFPolygonAnnotation;

  function CreatePolygonAnnotation: TgtPDFPolygonAnnotation;
  begin
    Result := TgtPDFPolygonAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      SetVertices(AVerstices);
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      Intensity := AIntensity;
      IsCloudy := AIsCloudy;
      BorderWidth := ABorderwidth;
    end;
  end;
begin
  try
    LPolygonAnnot := CreatePolygonAnnotation;
    APDFDoc.InsertAnnotation(LPolygonAnnot,APageno);
  finally
    LPolygonAnnot.Free;
  end;
end;

procedure InsertPolylineAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AVerstices: string; ABCKColor: TColor; ABorderwidth,APageno: Integer);
Var
  LPolylineAnnot: TgtPDFPolylineAnnotation;

  function CreatePolylineAnnotation: TgtPDFPolylineAnnotation;
  begin
    Result := TgtPDFPolylineAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      SetVertices(AVerstices);
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
    end;
  end;

begin
  try
    LPolylineAnnot := CreatePolylineAnnotation;
    APDFDoc.InsertAnnotation(LPolylineAnnot,APageno);
  finally
    LPolylineAnnot.Free;
  end;
end;

procedure InsertInkAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents, AInkList: string; ABCKColor: TColor; ABorderwidth,APageno: Integer);
var
  LInkAnnot: TgtPDFInkAnnotation;

  function CreateInkAnnotation: TgtPDFInkAnnotation;
  begin
    Result := TgtPDFInkAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      InkList := AInkList;
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
    end;
  end;

begin
  try
    LInkAnnot := CreateInkAnnotation;
    APDFDoc.InsertAnnotation(LInkAnnot,APageno);
  finally
    LInkAnnot.Free;
  end;
end;

procedure InsertStampAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; ABorderStyle,ABorderwidth,APageno: Integer);

  function CreateStampAnnotation: TgtPDFStampAnnotation;
  begin
    Result := TgtPDFStampAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      BorderStyle := TgtAnnotBorderStyle(ABorderStyle);
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
    end;
  end;

var
  LStampAnnot: TgtPDFStampAnnotation;
begin
  LStampAnnot := CreateStampAnnotation;
  try
    APDFDoc.InsertAnnotation(LStampAnnot,APageno);
  finally
    LStampAnnot.Free;
  end;
end;

procedure InsertMarkupAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; ABorderwidth,APageno: Integer;
  Ax1,Ay1,Ax2,Ay2,Ax3,Ay3,Ax4,Ay4: Extended);

  function CreateMarkUpAnnotation: TgtPDFMarkUpAnnotation;
  begin
    Result := TgtPDFMarkUpAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
      SetQuad(Ax1,Ay1,Ax2,Ay2,Ax3,Ay3,Ax4,Ay4);
    end;
  end;

var
  LMarkUpAnnot: TgtPDFMarkUpAnnotation;
begin
  LMarkUpAnnot := CreateMarkUpAnnotation;
  try
    APDFDoc.InsertAnnotation(LMarkUpAnnot,APageno);
  finally
    LMarkUpAnnot.Free;
  end;
end;

procedure InsertTextAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; AOpen: Boolean;AHCornerRad,AVCornerRad,ABorderwidth,APageno: Integer);

  function CreateTextAnnotation: TgtPDFTextAnnotation;
  begin
    Result := TgtPDFTextAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
      Open := AOpen;
      BorderHorizontalCornerRadius := AHCornerRad;
      BorderVerticalCornerRadius := AVCornerRad;
    end;
  end;

var
  LTextAnnot: TgtPDFTextAnnotation;
begin
  LTextAnnot := CreateTextAnnotation;
  try
    APDFDoc.InsertAnnotation(LTextAnnot,APageno);
  finally
    LTextAnnot.Free;
  end;
end;

procedure InsertFreeTextAnnotation(APDFDoc: TgtPDFDocument; ALeft,ATop, ARight, ABottom: Extended;
  ATitle, AName, AContents: string; ABCKColor: TColor; AfreeTextAlign,ABorderwidth,APageno: Integer);

  function CreateFreeTextAnnotation: TgtPDFFreeTextAnnotation;
  begin
    Result := TgtPDFFreeTextAnnotation.Create;
    with Result do
    begin
      AnnotTitle := ATitle;
      Name := AName;
      SetBounds(ALeft, ATop, ARight, ABottom);
      Contents := AContents;
      BackgroundColor := ABCKColor;
      BorderWidth := ABorderwidth;
      FreeTextAllignment := TgtFreeTextAllignment(AfreeTextAlign);
    end;
  end;

var
  LFreeTextAnnot: TgtPDFFreeTextAnnotation;
begin
  LFreeTextAnnot := CreateFreeTextAnnotation;
  try
    APDFDoc.InsertAnnotation(LFreeTextAnnot,APageno);
  finally
    LFreeTextAnnot.Free;
  end;
end;





end.




